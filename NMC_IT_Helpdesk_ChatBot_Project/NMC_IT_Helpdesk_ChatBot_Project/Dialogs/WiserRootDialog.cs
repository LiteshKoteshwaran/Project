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
        static string UserRequest;
        RootDialog rootDialog = new RootDialog();

        public async Task StartAsync(IDialogContext context)
        {
            string Name;
            context.UserData.TryGetValue(StateKeys.UserName,out Name);
            await context.PostAsync($"Hi {Name}, firstly can I check that you are able to log into WISER? ");

            PromptDialog.Choice(context, MessageReceivedAsync, new List<string>() { "Yes", "No" }, "Select any of the given option", " Please select the given option ", 3);
        }

        private async Task MessageReceivedAsync(IDialogContext context, IAwaitable<string> result)
        {
            string activity = await result;

            if (activity == "Yes")
            {
                await context.PostAsync("Great, are you reporting a fault or requesting a change? ");
                PromptDialog.Choice(context, FaultOrChange, new List<string>() { "Fault", "Change" }, "Select any of the given option", " Please select the given option ", 3);
            }

            else if (activity == "No")
            {
                await context.PostAsync("No problem, we will start a investigation on this issue.\nBreifly describe the problem you are facing.");
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
                context.Call(new WiserChangeDialog(), AskForPinAndName);
            }

        }

        private async Task AskForPinAndName(IDialogContext context, IAwaitable<object> result)
        {
            string PinAndName;
            if (!context.ConversationData.TryGetValue(StateKeys.PinAndName, out PinAndName))
            {
                await context.PostAsync("PRN/Pin & Registrant full name");
                context.Wait(CapturePinAndRegistrant);
            }
        }
        private async Task CapturePinAndRegistrant(IDialogContext context, IAwaitable<object> result)
        {
            var Input = await result as Activity;
            context.ConversationData.SetValue(StateKeys.PinAndName, Input.Text);

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

            await Proceed(context,result);
        }

        private async Task Proceed(IDialogContext context, IAwaitable<object> result)
        {
            PromptDialog.Choice(context, EndOfFlow, new List<string>() { "Yes", "No" }, "Ok all set.\n Should I proceed??", "Please select from given Options");
        }

        private async Task EndOfFlow(IDialogContext context, IAwaitable<string> result)
        {
            string UserInput = await result; ;

            if (UserInput == "Yes")
            {
                await WiserChangeForm(context);
            }
            if (UserInput == "No")
            {
                await context.PostAsync("Ok thank you");
                await rootDialog.StartAsync(context);
            }
        }

        internal async Task RiseTicketForFault(IDialogContext context, IAwaitable<object> result)
        {
            await context.PostAsync("I have logged a ticket on this with the relevant support team and they will be in touch to resolve this issue\n Your reference ticket number is sent to your email.\n if possible please share a screenshot of the error message, you can dp that by replying with the screenshot as a attachment.\n you can ask me other IT related question, i will be happy to assist.");
            await rootDialog.StartAsync(context);
        }

        private async Task WiserChangeForm(IDialogContext context)
        {
            await context.PostAsync("You will have to formally complete a Wiser change form and get it signed by Geri and <@AD Line Manager>.\nHere is the Wiser change form <insert link>.\nAfter completion please submit it via ITSelf.");
            await rootDialog.StartAsync(context);
        }
    }
}