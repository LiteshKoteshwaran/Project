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
    public class WiserChangeDialog : IDialog<object>
    {
        public async Task StartAsync(IDialogContext context)
        {
            await Change(context);
        }
        private async Task Change(IDialogContext context)
        {
            List<string> List = new List<string>();
            List = SqlOperations.GetList("OptionsForChangingWiser");
            PromptDialog.Choice(context, CaptureChangeRequest, List, "Which change are you requesting?", "Please select from given Options");
        }

        private async Task CaptureChangeRequest(IDialogContext context, IAwaitable<string> result)
        {
            string Input = await result; ;
            context.ConversationData.SetValue(StateKeys.ChangeRequest, Input);
            WiserRootDialog wiserRootDialog = new WiserRootDialog();
            await wiserRootDialog.AskForPinAndName(context, result);
        }
    }
}