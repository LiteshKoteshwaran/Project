using Microsoft.Bot.Builder.Dialogs;
using Microsoft.Bot.Connector;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;

namespace NMC_IT_Helpdesk_ChatBot_Project.Dialogs
{
    [Serializable]
    public class WiserRootDialog : IDialog<object>
    {
        public static string UserRequest, message;
        RootDialog rootDialog = new RootDialog();
        string UserInput;
        public static bool UserIncomplete = false;


        public async Task StartAsync(IDialogContext context)
        {
            string Name;
            context.UserData.TryGetValue(StateKeys.UserName,out Name);

            RootDialog.BotResponse = SqlOperations.GetResponseFromBot("ToFetchBotsReply", Intents.FootPrintsWiserIssueTicketing, "CheckForWiserLogin");
            message = RootDialog.BotResponse.Replace("Name", Name);

            SqlOperations.ForConversationLog(RootDialog.message, message);


            PromptDialog.Choice(context, MessageReceivedAsync, new List<string>() { "Yes", "No" }, message, " Please select the given option ", 3);
        }

        private async Task MessageReceivedAsync(IDialogContext context, IAwaitable<string> result)
        {
            string activity = await result;

            if (activity == "Yes")
            {
                RootDialog.BotResponse = SqlOperations.GetResponseFromBot("ToFetchBotsReply", Intents.FootPrintsWiserIssueTicketing, "AskingForFaultOrChange");
                SqlOperations.ForConversationLog(activity, RootDialog.BotResponse);

                PromptDialog.Choice(context, FaultOrChange, new List<string>() { "Fault", "Change" }, RootDialog.BotResponse, " Please select the given option ", 3);
            }

            else if (activity == "No")
            {
                RootDialog.BotResponse = SqlOperations.GetResponseFromBot("ToFetchBotsReply", Intents.FootPrintsWiserIssueTicketing, "AskingForProblem");
                SqlOperations.ForConversationLog(activity, RootDialog.BotResponse);

                await context.PostAsync(RootDialog.BotResponse);
                context.Wait(Proceed);
            }
        }

        private async Task FaultOrChange(IDialogContext context, IAwaitable<string> result)
        {
            UserRequest = await result;
            if (UserRequest == "Fault")
            {
                context.Call(new WiserFaultDialog(), RiseTicketForFault);

            }

            else if (UserRequest == "Change")
            {
                SqlOperations.ForConversationLog(UserRequest, "Options for change");
                context.Call(new WiserChangeDialog(), AskForPinAndName);
            }

        }

        public async Task AskForPinAndName(IDialogContext context, IAwaitable<object> result)
        {

            List<string> ListOfQusetions = new List<string>();
            ListOfQusetions = SqlOperations.GetList("OptionsForFaultWiser");

            context.ConversationData.TryGetValue(StateKeys.ChangeRequest, out message);

            SqlOperations.ForConversationLog(message, ListOfQusetions[1]);
            await context.PostAsync(ListOfQusetions[1]);
            context.Wait(CapturePinAndRegistrant);
        }
        private async Task CapturePinAndRegistrant(IDialogContext context, IAwaitable<object> result)
        {
            var Input = await result as Activity;
            context.ConversationData.SetValue(StateKeys.PinAndName, Input.Text);

            await Proceed(context,result);
        }

        private async Task CaptureUserIssue(IDialogContext context, IAwaitable<object> result)
        {
            var UserInput = await result as Activity;

            context.ConversationData.SetValue(StateKeys.UserIssue, UserInput);

            SqlOperations.ForConversationLog(message, "User's Issue");

            await Proceed(context,result);
        }

        private async Task Proceed(IDialogContext context, IAwaitable<object> result)
        {
            if (UserRequest == "Change")
            {
                context.ConversationData.TryGetValue(StateKeys.PinAndName, out string message);

                RootDialog.BotResponse = SqlOperations.GetResponseFromBot("ToFetchBotsReply", Intents.FootPrintsWiserIssueTicketing, "AskingToProceed");
                SqlOperations.ForConversationLog(message, RootDialog.BotResponse);
            }
            PromptDialog.Choice(context, EndOfFlow, new List<string>() { "Yes", "No" }, RootDialog.BotResponse, "Please select from given Options");
        }

        private async Task EndOfFlow(IDialogContext context, IAwaitable<string> result)
        {
            UserInput = await result; 

            if (UserInput == "Yes")
            {
                await WiserChangeForm(context);
            }
            if (UserInput == "No")
            {
                SqlOperations.ForConversationLog(UserInput, "Ok thank you");
                await context.PostAsync("Ok thank you");
                await rootDialog.StartAsync(context);
            }
        }

        internal async Task RiseTicketForFault(IDialogContext context, IAwaitable<object> result)
        {
            RootDialog.BotResponse = SqlOperations.GetResponseFromBot("ToFetchBotsReply", Intents.FootPrintsWiserIssueTicketing, "EndForFault");

            await context.PostAsync(RootDialog.BotResponse);
            Email.SendEmail(RootDialog.Email);

            SqlOperations.ForConversationLog(RootDialog.BotResponse,"Email has been sent");

            context.Wait(Luis.IdentifyUserQueryUsingLuis);
        }

        private async Task WiserChangeForm(IDialogContext context)
        {

            RootDialog.BotResponse = SqlOperations.GetResponseFromBot("ToFetchBotsReply", Intents.FootPrintsWiserIssueTicketing, "EndOfWiser");

            SqlOperations.ForConversationLog(UserInput, RootDialog.BotResponse);

            await context.PostAsync(RootDialog.BotResponse);
            await rootDialog.StartAsync(context);
        }
    }
}