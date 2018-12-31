using NMC_IT_Helpdesk_Chatbot.Dialogs;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NMC_IT_Helpdesk_Chatbot
{
    [Serializable]
    public class SQLQuries
    {
        public static bool IsSuccess;
        DAL dal = new DAL();
        private static string Query;
        List<string> List;

        internal void GetUserInfo(string Email)
        {
            Query = "Select Name from UserInformation where Email = '"+Email+"'";
            UserInformation.Name = dal.GetSelection(Query);
        }

        internal List<string> GetListOfOptions(string Type)
        {
            List = new List<string>();
            Query = "Select Answer from QnA where Type = '" + Type + "'";
            List = dal.GetListOnSelection(Query);
            return List;
        }
    }
}