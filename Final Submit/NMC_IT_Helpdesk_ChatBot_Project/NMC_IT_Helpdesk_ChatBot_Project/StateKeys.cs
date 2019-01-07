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


        public const string Img = "data:image/jpeg;base64,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";
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

    public class Intents
    {
        public const string FootPrintsWiserIssueTicketing = "FootPrintsWiserIssueTicketing";
        public const string EmailCalendarAccess = "EmailCalendarAccess";
        public const string EmailMimecastRelease = "EmailMimecastRelease";
        public const string EmailInboxBlockSpam = "EmailInboxBlockSpam";
        public const string EmailOutlookSignatureCreation = "EmailOutlookSignatureCreation";
        public const string SelfServiceRequestHardwareType = "SelfServiceRequestHardwareType";
        public const string EmailAutoReplySetup = "EmailAutoReplySetup";
        public const string SmallTalkHelpWhatCanYouDo = "SmallTalkHelpWhatCanYouDo";
        public const string SmallTalkGreetingHowAreYou = "SmallTalkGreetingHowAreYou";
        public const string SmallTalkGreetingHello = "SmallTalkGreetingHello";
        public const string SmallTalkGreetingPartOfDAy = "SmallTalkGreetingPartOfDAy";
        public const string SmallTalkGratitudeThankYou = "SmallTalkGratitudeThankYou";
        public const string SmallTalkGratitudeWellDone = "SmallTalkGratitudeWellDone";
        public const string SmallTalkGratitudeBye = "SmallTalkGratitudeBye";
        public const string SmallTalkAngryMood = "SmallTalkAngryMood";
        public const string SmallTalkAngryWrongAnswer = "SmallTalkAngryWrongAnswer";
        public const string SmallTalkGreetingHobbies = "SmallTalkGreetingHobbies";
        public const string SmallTalkGreetingFunny = "SmallTalkGreetingFunny";
        public const string SmallTalkGreetingWhereDoUWork = "SmallTalkGreetingWhereDoUWork";
        public const string SmallTalkEasterEggHitchhikers = "SmallTalkEasterEggHitchhikers";
        public const string SmallTalkEasterEggFootball = "SmallTalkEasterEggFootball";
        public const string SmallTalkEasterEggRelationship = "SmallTalkEasterEggRelationship";
        public const string SmallTalkEasterEggHAL = "SmallTalkEasterEggHAL";
        public const string SmallTalkEasterEggAsimov = "SmallTalkEasterEggAsimov";
    }

    public class Entities
    {
        public static readonly List<string> SelfServiceRequestHardwareTypeList = new List<string> { "laptop", "desktop" , "monitor" , "VDI" , "ipad" , "mobilephone" };
        public static readonly List<string> EmailAutoReplySetup = new List<string> { "webmail", "outlook", "random"};
    }
}