using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace NMC_IT_Helpdesk_Chatbot
{
    [Serializable]
    public class DAL
    {
        ConnectionManager connetionMannger = new ConnectionManager();
        DataTable dataTable;

        public string GetSelection(string Query)
        {
            string Selection = "";
            DataTable dataTable = new DataTable();
            using (SqlConnection connection = new SqlConnection(ConnectionManager.ConnectionString))
            {
                SqlCommand cmd = new SqlCommand(Query, connection);
                try
                {
                    connection.Open();
                    Selection = cmd.ExecuteScalar().ToString().ToLower();
                    SQLQuries.IsSuccess = true;
                }
                catch (Exception ex)
                {
                    SQLQuries.IsSuccess = false;
                }
            }
            return Selection;
        }

        public List<string> GetListOnSelection(string Query)
        {
            List<string> Items = new List<string>();
            dataTable = connetionMannger.DataTableConnection(Query);
            foreach (DataRow dr in dataTable.Rows)
            {
                string Item = dr[0].ToString();
                Items.Add(Item);
            }
            return Items;
        }
    }
}