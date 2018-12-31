using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;


namespace NMC_IT_Helpdesk_ChatBot_Project
{
    [Serializable]
    public class ConnectionManager
    {
        public static string ConnectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
    }
}