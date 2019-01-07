using NMC_IT_Helpdesk_ChatBot_Project.Dialogs;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;

namespace NMC_IT_Helpdesk_ChatBot_Project
{
    public static class SqlOperations
    {
        public static string Result, UserId, Query;
        public static bool IsSuccess = true;
        public static string GetStaticResponse(string ProcName, string UserInput, string InputPramName, string OutputPramName)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(ConnectionManager.ConnectionString))
                {
                    connection.Open();
                    SqlCommand command = new SqlCommand(ProcName, connection);

                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue(InputPramName, UserInput);

                    SqlParameter param = new SqlParameter();
                    param.ParameterName = OutputPramName;
                    param.Direction = ParameterDirection.Output;
                    param.SqlDbType = SqlDbType.VarChar;
                    param.Size = 50;
                    command.Parameters.Add(param);
                    command.ExecuteNonQuery();
                    Result = command.Parameters[OutputPramName].Value.ToString();
                    connection.Close();
                    if (Result.Count() < 1)
                    {
                        IsSuccess = false;
                    }
                    else
                        IsSuccess = true;
                }
            }
            catch (Exception e)
            {
                ExceptionLog.LogFile(e);
                IsSuccess = false;
            }
            return Result;
        }

        public static List<string> GetList(string ProcName)
        {
            List<string> Items = new List<string>();
            DataTable ds = new DataTable();
            using (SqlConnection conn = new SqlConnection(ConnectionManager.ConnectionString))
            {
                try
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand(ProcName, conn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    SqlDataAdapter sadp = new SqlDataAdapter(cmd);
                    sadp.Fill(ds);
                    foreach (DataRow dr in ds.Rows)
                    {
                        string Item = dr[0].ToString();
                        Items.Add(Item);
                    }
                }
                catch (Exception e)
                {
                    ExceptionLog.LogFile(e);
                }
                return Items;
            }
        }

        public static string GetResponseFromBot(string ProcName, string intent,string Type)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(ConnectionManager.ConnectionString))
                {
                    connection.Open();
                    SqlCommand command = new SqlCommand(ProcName, connection);

                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue(StateKeys.ParamIntentName, intent);
                    command.Parameters.AddWithValue(StateKeys.ParamType, Type);
                    SqlParameter param = new SqlParameter();
                    param.ParameterName = StateKeys.ParamBotsReply;
                    param.Direction = ParameterDirection.Output;
                    param.SqlDbType = SqlDbType.VarChar;
                    param.Size = 500;
                    command.Parameters.Add(param);
                    command.ExecuteNonQuery();
                    Result = command.Parameters[StateKeys.ParamBotsReply].Value.ToString();
                    connection.Close();
                }
            }
            catch (Exception e)
            {
                ExceptionLog.LogFile(e);
                IsSuccess = false;
            }
            return Result;
        }

        public static bool ForConversationLog(string UserReply ,string BotResponse)
        {
            bool isSuccess = true;
            var Time = DateTime.Now;
            using (var conn = new SqlConnection(ConnectionManager.ConnectionString))
            {
                try
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand();
                    cmd.Connection = conn;
                    UserId = GetSelection("select Id from LiteshUserInformation where Name = "+"'"+RootDialog.Name+"'");
                    cmd.CommandText = "insert into LiteshConversationLog values('"+UserId+"'"+" ,'"+UserReply + "'" + " ,'" + BotResponse + "'" + " ,'" + Time+"')";
                    int RowsAffected = cmd.ExecuteNonQuery();
                    if (RowsAffected < 1)
                    {
                        throw new Exception("Could not process the data");
                    }

                }
                catch (Exception ex)
                {
                    isSuccess = false;
                    ExceptionLog.LogFile(ex);
                }
                finally
                {
                    conn.Close();
                }
                return isSuccess;
            }
        }
        public static string GetSelection(string Query)
        {
            string Selection = "";
            DataTable dataTable = new DataTable();
            using (SqlConnection connection = new SqlConnection(ConnectionManager.ConnectionString))
            {
                SqlCommand cmd = new SqlCommand(Query, connection);
                try
                {
                    connection.Open();
                    Selection = cmd.ExecuteScalar().ToString();
                }
                catch (Exception ex)
                {
                    ExceptionLog.LogFile(ex);
                }
            }
            return Selection;
        }


        internal static string ForBotReply(string intent)
        {
            try
            {
               Query = "select Answer from LiteshQnA join liteshIntent on LiteshIntent.Id = LiteshQnA.IntentId where LiteshIntent.Name='" + intent + "'";
            }
            catch(Exception ex)
            {
                ExceptionLog.LogFile(ex);
            }
            return Result = GetSelection(Query);
        }

        internal static string ForBotReplywithEntity(string intent, string entity)
        {
            try
            {
               Query = "select Answer from LiteshQnA join LiteshIntent on LiteshIntent.Id = LiteshQnA.IntentId join LiteshEntity on LiteshEntity.Id = LiteshQnA.EntityId where (liteshIntent.Name='" + intent + "' and LiteshEntity.Name='" + entity + "')";
            }
            catch(Exception ex)
            {
                ExceptionLog.LogFile(ex);
            }
            return Result = GetSelection(Query);
        }


        public static void ForErrorLog(Exception ex)
        {
            using (SqlConnection connection = new SqlConnection(ConnectionManager.ConnectionString))
            {
                try
                {
                    connection.Open();
                    SqlCommand cmd = new SqlCommand("ForErrorLog", connection);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("UserId", UserId);
                    cmd.Parameters.AddWithValue("MethodName", ex.TargetSite.ToString());
                    cmd.Parameters.AddWithValue("StackTrace", ex.StackTrace.ToString());
                    cmd.ExecuteNonQuery();
                    connection.Close();
                }
                catch (Exception e)
                {
                    ExceptionLog.LogFile(e);
                }
            }

        }

    }

        public class ExceptionLog
        {
            public static void LogFile(Exception ex)
            {
                string strPath = @"D:\FinalProject\NMC_IT_Helpdesk_ChatBot_Project\ErrorLog.txt";
                if (!File.Exists(strPath))
                {
                    File.Create(strPath).Dispose();
                }
                using (StreamWriter sw = File.AppendText(strPath))
                {
                    sw.WriteLine("=============Error Logging ===========");
                    sw.WriteLine("===========Start============= " + DateTime.Now);
                    sw.WriteLine("Error Message: " + ex.Message);
                    sw.WriteLine("Stack Trace: " + ex.StackTrace);
                    sw.WriteLine("===========End============= " + DateTime.Now);
                }
                SqlOperations.ForErrorLog(ex);
            }
        }
    }

