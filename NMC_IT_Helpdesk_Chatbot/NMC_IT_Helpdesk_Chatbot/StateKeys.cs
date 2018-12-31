using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NMC_IT_Helpdesk_Chatbot
{
    [Serializable]
    public class StateKeys
    {

        public static readonly string PinAndName = "PinAndName";
        public static readonly string TaskAttemptedDuringIssue = "TaskAttemptedDuringIssue";
        public static readonly string DisplayedErrorMessage = "DisplayedErrorMessage";
        public static readonly string NosUsersImpacted = "NosUsersImpacted";
        public static readonly string AdditionalInfo = "AdditionalInfo";
        public static readonly string ChangeRequest = "ChangeRequest";
        public static readonly string UserIssue = "UserIssue";

        public static readonly string UserEmail = "UserEmail";
        public static readonly string UserName = "UserName";
    }
}