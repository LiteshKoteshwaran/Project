using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NMC_IT_Helpdesk_ChatBot_Project
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


        public static readonly string ProcForUserName = "ForUserName";

        public static readonly string ParamIntentName = "IntentName";
        public static readonly string ParamType = "Type";
        public static readonly string ParamUserReply = "UserReply";
        public static readonly string ParamBotsReply = "BotsReply";

        public static readonly string FootPrintsWiserIssueTicketing = "FootPrintsWiserIssueTicketing";

    }

    public class MessageType
    {
        public static readonly string WiserWelcome = "WiserWelcome";
        public static readonly string CheckForWiserLogin = "CheckForWiserLogin";
        public static readonly string AskingForFaultOrChange = "AskingForFaultOrChange";
        public static readonly string AskingForProblem = "AskingForProblem";
        public static readonly string FaultQuestion = "FaultQuestion";
        public static readonly string FaultQuestion1 = "FaultQuestion1";
        public static readonly string FaultQuestion2 = "FaultQuestion2";
        public static readonly string FaultQuestion3 = "FaultQuestion3";
        public static readonly string FaultQuestion4 = "FaultQuestion4"; 
        public static readonly string FaultQuestion5 = "FaultQuestion5";
        public static readonly string OptionForChange = "OptionForChange";
        public static readonly string EndForFault = "EndForFault";
        public static readonly string AskForPinName = "AskForPinName";
        public static readonly string AskingToProceed = "AskingToProceed";
        public static readonly string EndOfWiser = "EndOfWiser";
    }
}