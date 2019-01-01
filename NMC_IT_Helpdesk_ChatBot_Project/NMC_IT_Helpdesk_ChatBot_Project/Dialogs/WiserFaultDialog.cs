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
    public class WiserFaultDialog : IDialog<Object>
    {
        string TaskAttemptedDuringIssue, DisplayedErrorMessage, NosUsersImpacted, AdditionalInfo;

        public async Task StartAsync(IDialogContext context)
        {
            context.ConversationData.TryGetValue(StateKeys.PinAndName,out string message);

            RootDialog.BotResponse = SqlOperations.GetResponseFromBot("ToFetchBotsReply", StateKeys.FootPrintsWiserIssueTicketing, "FaultQuestion2");
            SqlOperations.ForConversationLog(message, RootDialog.BotResponse);

            //await context.PostAsync("What task were you attempting when this issue occurred");
            await context.PostAsync(RootDialog.BotResponse);
            context.Wait(Fault);
        }

        internal async Task Fault(IDialogContext context, IAwaitable<object> result)
        {
            var Input = await result as Activity;
            if (!context.ConversationData.TryGetValue(StateKeys.TaskAttemptedDuringIssue, out TaskAttemptedDuringIssue))
            {
                RootDialog.BotResponse = SqlOperations.GetResponseFromBot("ToFetchBotsReply", StateKeys.FootPrintsWiserIssueTicketing, "FaultQuestion3");
                SqlOperations.ForConversationLog(Input.Text, RootDialog.BotResponse);

                context.ConversationData.SetValue(StateKeys.TaskAttemptedDuringIssue, Input.Text);
                //await context.PostAsync("Any error messages displayed");
                await context.PostAsync(RootDialog.BotResponse);
                context.Wait(Fault);
            }
            else if (!context.ConversationData.TryGetValue(StateKeys.DisplayedErrorMessage, out DisplayedErrorMessage))
            {
                RootDialog.BotResponse = SqlOperations.GetResponseFromBot("ToFetchBotsReply", StateKeys.FootPrintsWiserIssueTicketing, "FaultQuestion4");
                SqlOperations.ForConversationLog(Input.Text, RootDialog.BotResponse);

                context.ConversationData.SetValue(StateKeys.DisplayedErrorMessage, Input.Text);
                //await context.PostAsync("Number of users impacted");

                await context.PostAsync(RootDialog.BotResponse);

                context.Wait(Fault);
            }

            else if (!context.ConversationData.TryGetValue(StateKeys.NosUsersImpacted, out NosUsersImpacted))
            {
                RootDialog.BotResponse = SqlOperations.GetResponseFromBot("ToFetchBotsReply", StateKeys.FootPrintsWiserIssueTicketing, "FaultQuestion5");
                SqlOperations.ForConversationLog(Input.Text, RootDialog.BotResponse);

                context.ConversationData.SetValue(StateKeys.NosUsersImpacted, Input.Text);
                //await context.PostAsync("Any additional information you feel would be useful");

                await context.PostAsync(RootDialog.BotResponse);

                context.Wait(Fault);
            }

            else if (!context.ConversationData.TryGetValue(StateKeys.AdditionalInfo, out AdditionalInfo))
            {
                context.ConversationData.SetValue(StateKeys.AdditionalInfo, Input.Text);
                WiserRootDialog wiserRootDialog = new WiserRootDialog();
                await wiserRootDialog.RiseTicketForFault(context,result);
            }
        }
    }
}