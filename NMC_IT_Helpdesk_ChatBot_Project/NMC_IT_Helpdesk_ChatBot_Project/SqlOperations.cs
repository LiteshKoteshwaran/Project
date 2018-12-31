using NMC_IT_Helpdesk_ChatBot_Project.Dialogs;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace NMC_IT_Helpdesk_ChatBot_Project
{
    public static class SqlOperations
    {
        public static string Result;
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
                }
            }
            catch (Exception e)
            {
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
                    param.Size = 50;
                    command.Parameters.Add(param);
                    command.ExecuteNonQuery();
                    Result = command.Parameters[StateKeys.ParamBotsReply].Value.ToString();
                    connection.Close();
                }
            }
            catch (Exception e)
            {
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
                    string UserId = GetSelection("select Id from UserInformation where Name = "+"'"+RootDialog.Name+"'");
                    cmd.CommandText = "insert into ConversationLog values('"+UserId+"'"+" ,'"+UserReply + "'" + " ,'" + BotResponse + "'" + " ,'" + Time+"')";
                    int RowsAffected = cmd.ExecuteNonQuery();
                    if (RowsAffected < 1)
                    {
                        throw new Exception("Could not process the data");
                    }

                }
                catch (Exception ex)
                {
                    isSuccess = false;
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
                    throw ex;
                }
            }
            return Selection;
        }
    }
}