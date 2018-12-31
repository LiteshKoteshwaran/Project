using Microsoft.Bot.Builder.Dialogs;
using Microsoft.Bot.Connector;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;

namespace NMC_IT_Helpdesk_Chatbot.Dialogs
{
    [Serializable]

    public class WiserFaultDialog : IDialog<object>
    {
        public async Task StartAsync(IDialogContext context)
        {
            context.Wait(Fault);
        }

        internal async Task Fault(IDialogContext context, IAwaitable<object> result)
        {
            string TaskAttemptedDuringIssue, DisplayedErrorMessage, NosUsersImpacted, AdditionalInfo;

            if (!context.ConversationData.TryGetValue(StateKeys.TaskAttemptedDuringIssue, out TaskAttemptedDuringIssue))
            {
                await context.PostAsync("What task were you attempting when this issue occurred");
                var Input = await result as Activity;
                context.ConversationData.SetValue(StateKeys.TaskAttemptedDuringIssue, Input.Text);
                context.Wait(Fault);
            }

            if (!context.ConversationData.TryGetValue(StateKeys.DisplayedErrorMessage, out DisplayedErrorMessage))
            {
                await context.PostAsync("Any error messages displayed");
                var Input = await result as Activity;
                context.ConversationData.SetValue(StateKeys.DisplayedErrorMessage, Input.Text);
                context.Wait(Fault);
            }

            if (!context.ConversationData.TryGetValue(StateKeys.NosUsersImpacted, out NosUsersImpacted))
            {
                await context.PostAsync("Number of users impacted");
                var Input = await result as Activity;
                context.ConversationData.SetValue(StateKeys.NosUsersImpacted, Input.Text);
                context.Wait(Fault);
            }

            if (!context.ConversationData.TryGetValue(StateKeys.AdditionalInfo, out AdditionalInfo))
            {
                await context.PostAsync("Any additional information you feel would be useful");
                var Input = await result as Activity;
                context.ConversationData.SetValue(StateKeys.AdditionalInfo, Input.Text);
                context.Wait(Fault);
            }
        }
    }
}