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
    public class WiserChangeDialog : IDialog<object>
    {

        SQLQuries sqlQuries;
        public async Task StartAsync(IDialogContext context)
        {
            context.Wait(Change);
        }
        private async Task Change(IDialogContext context, IAwaitable<object> result)
        {
            List<string> List = new List<string>();
            sqlQuries = new SQLQuries();

            List = sqlQuries.GetListOfOptions("OptionForChange");
            PromptDialog.Choice(context, CaptureChangeRequest, List, "Which change are you requesting?", "Please select from given Options");
        }

        private async Task CaptureChangeRequest(IDialogContext context, IAwaitable<object> result)
        {
            var Input = await result as Activity;
            context.ConversationData.SetValue(StateKeys.ChangeRequest, Input.Text);
        }
    }
}