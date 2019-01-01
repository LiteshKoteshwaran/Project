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
        static string UserRequest, message;
        RootDialog rootDialog = new RootDialog();
        string UserInput;
        public async Task StartAsync(IDialogContext context)
        {
            string Name;
            context.UserData.TryGetValue(StateKeys.UserName,out Name);

            RootDialog.BotResponse = SqlOperations.GetResponseFromBot("ToFetchBotsReply", StateKeys.FootPrintsWiserIssueTicketing, "CheckForWiserLogin");
            message = RootDialog.BotResponse.Replace("Name", Name);

            SqlOperations.ForConversationLog(RootDialog.message, message);

            //await context.PostAsync(message);

            PromptDialog.Choice(context, MessageReceivedAsync, new List<string>() { "Yes", "No" }, message, " Please select the given option ", 3);
        }

        private async Task MessageReceivedAsync(IDialogContext context, IAwaitable<string> result)
        {
            string activity = await result;

            if (activity == "Yes")
            {
                

                RootDialog.BotResponse = SqlOperations.GetResponseFromBot("ToFetchBotsReply", StateKeys.FootPrintsWiserIssueTicketing, "AskingForFaultOrChange");
                SqlOperations.ForConversationLog(activity, RootDialog.BotResponse);

                //await context.PostAsync("Great, are you reporting a fault or requesting a change? ");
                PromptDialog.Choice(context, FaultOrChange, new List<string>() { "Fault", "Change" }, RootDialog.BotResponse, " Please select the given option ", 3);
            }

            else if (activity == "No")
            {
                RootDialog.BotResponse = SqlOperations.GetResponseFromBot("ToFetchBotsReply", StateKeys.FootPrintsWiserIssueTicketing, "AskingForProblem");
                SqlOperations.ForConversationLog(activity, RootDialog.BotResponse);

                //await context.PostAsync("No problem, we will start a investigation on this issue.\nBreifly describe the problem you are facing.");
                await context.PostAsync(RootDialog.BotResponse);
                context.Wait(Proceed);
            }
        }

        private async Task FaultOrChange(IDialogContext context, IAwaitable<string> result)
        {
            UserRequest = await result;
            if (UserRequest == "Fault")
            {
                await AskForPinAndName(context,result);
            }

            else if (UserRequest == "Change")
            {
                SqlOperations.ForConversationLog(UserRequest, "Options for change");
                context.Call(new WiserChangeDialog(), AskForPinAndName);
            }

        }

        public async Task AskForPinAndName(IDialogContext context, IAwaitable<object> result)
        {
            string PinAndName;
            if (!context.ConversationData.TryGetValue(StateKeys.PinAndName, out PinAndName))
            {
                if (UserRequest == "Fault")
                {
                    RootDialog.BotResponse = SqlOperations.GetResponseFromBot("ToFetchBotsReply", StateKeys.FootPrintsWiserIssueTicketing, "FaultQuestion1");
                    SqlOperations.ForConversationLog(UserRequest, RootDialog.BotResponse);
                }
                else
                {
                    context.ConversationData.TryGetValue(StateKeys.ChangeRequest, out message);
                    RootDialog.BotResponse = SqlOperations.GetResponseFromBot("ToFetchBotsReply", StateKeys.FootPrintsWiserIssueTicketing, "FaultQuestion1");
                    SqlOperations.ForConversationLog(message, RootDialog.BotResponse);
                }
                //await context.PostAsync("PRN/Pin & Registrant full name");
                await context.PostAsync(RootDialog.BotResponse);
                context.Wait(CapturePinAndRegistrant);
            }
        }
        private async Task CapturePinAndRegistrant(IDialogContext context, IAwaitable<object> result)
        {
            var Input = await result as Activity;
            context.ConversationData.SetValue(StateKeys.PinAndName, Input.Text);

            //SqlOperations.ForConversationLog(Input.Text, RootDialog.BotResponse);

            if (UserRequest == "Fault")
            {
                context.Call(new WiserFaultDialog(), RiseTicketForFault);
            }

            else if (UserRequest == "Change")
            {
                await Proceed(context,result);
            }
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
                RootDialog.BotResponse = SqlOperations.GetResponseFromBot("ToFetchBotsReply", StateKeys.FootPrintsWiserIssueTicketing, "AskingToProceed");
                SqlOperations.ForConversationLog(message, RootDialog.BotResponse);
            }
            PromptDialog.Choice(context, EndOfFlow, new List<string>() { "Yes", "No" }, RootDialog.BotResponse, "Please select from given Options");
        }

        private async Task EndOfFlow(IDialogContext context, IAwaitable<string> result)
        {
            UserInput = await result; 

            if (UserInput == "Yes")
            {
                //SqlOperations.ForConversationLog(UserInput, RootDialog.BotResponse);
                await WiserChangeForm(context);
            }
            if (UserInput == "No")
            {
                SqlOperations.ForConversationLog(UserInput, RootDialog.BotResponse);
                await context.PostAsync("Ok thank you");
                await rootDialog.StartAsync(context);
            }
        }

        internal async Task RiseTicketForFault(IDialogContext context, IAwaitable<object> result)
        {
            context.ConversationData.TryGetValue(StateKeys.AdditionalInfo, out string message);

            RootDialog.BotResponse = SqlOperations.GetResponseFromBot("ToFetchBotsReply", StateKeys.FootPrintsWiserIssueTicketing, "EndForFault");

            SqlOperations.ForConversationLog(message, RootDialog.BotResponse);
            //await context.PostAsync("I have logged a ticket on this with the relevant support team and they will be in touch to resolve this issue\n Your reference ticket number is sent to your email.\n if possible please share a screenshot of the error message, you can dp that by replying with the screenshot as a attachment.\n you can ask me other IT related question, i will be happy to assist.");
            await context.PostAsync(RootDialog.BotResponse);
            await rootDialog.StartAsync(context);
        }

        private async Task WiserChangeForm(IDialogContext context)
        {

            RootDialog.BotResponse = SqlOperations.GetResponseFromBot("ToFetchBotsReply", StateKeys.FootPrintsWiserIssueTicketing, "EndOfWiser");

            SqlOperations.ForConversationLog(UserInput, RootDialog.BotResponse);

            await context.PostAsync(RootDialog.BotResponse);
            //await context.PostAsync("You will have to formally complete a Wiser change form and get it signed by Geri and <@AD Line Manager>.\nHere is the Wiser change form <insert link>.\nAfter completion please submit it via ITSelf.");
            await rootDialog.StartAsync(context);
        }
    }
}