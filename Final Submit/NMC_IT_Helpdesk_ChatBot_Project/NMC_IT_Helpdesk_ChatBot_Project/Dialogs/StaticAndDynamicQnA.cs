using Microsoft.Bot.Builder.Dialogs;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;

namespace NMC_IT_Helpdesk_ChatBot_Project.Dialogs
{
    [Serializable]
    public class StaticAndDynamicQnA : IDialog<object>
    {
        public async Task StartAsync(IDialogContext context)
        {
            await MessageReceivedAsync(context);
        }
        private async Task MessageReceivedAsync(IDialogContext context)
        {
            if(Luis.intent==Intents.EmailCalendarAccess)
            {
                    RootDialog.BotResponse = SqlOperations.ForBotReply(Luis.intent);
                    await context.PostAsync(RootDialog.BotResponse);

                    SqlOperations.ForConversationLog(RootDialog.message, RootDialog.BotResponse);
            }
            else if (Luis.intent == Intents.EmailMimecastRelease)
            {
                RootDialog.BotResponse = SqlOperations.ForBotReply(Luis.intent);
                await context.PostAsync(RootDialog.BotResponse);

                SqlOperations.ForConversationLog(RootDialog.message, RootDialog.BotResponse);
            }
            else if (Luis.intent == Intents.EmailInboxBlockSpam)
            {
                RootDialog.BotResponse = SqlOperations.ForBotReply(Luis.intent);
                await context.PostAsync(RootDialog.BotResponse);

                SqlOperations.ForConversationLog(RootDialog.message, RootDialog.BotResponse);
            }
            else if (Luis.intent == Intents.EmailOutlookSignatureCreation)
            {
                RootDialog.BotResponse = SqlOperations.ForBotReply(Luis.intent);
                await context.PostAsync(RootDialog.BotResponse);

                SqlOperations.ForConversationLog(RootDialog.message, RootDialog.BotResponse);
            }
            else if (Luis.intent == Intents.EmailAutoReplySetup)
            {
                for (int i = 0; i < Entities.EmailAutoReplySetup.Count; i++)
                {
                    if (RootDialog.Email.Contains(Entities.EmailAutoReplySetup[i]))
                    {
                        string Entity = Entities.EmailAutoReplySetup[i];
                        RootDialog.BotResponse = SqlOperations.ForBotReplywithEntity(Luis.intent, Entity);
                        string message = RootDialog.BotResponse.Replace("{Name}", RootDialog.Name);
                        await context.PostAsync(message);
                        SqlOperations.ForConversationLog(RootDialog.message, message);
                        break;
                    }
                }

            }
            else if(Luis.intent == Intents.SelfServiceRequestHardwareType)
            {
                RootDialog.BotResponse = SqlOperations.ForBotReplywithEntity(Luis.intent, Luis.entity);
                string message = RootDialog.BotResponse.Replace("{Name}", RootDialog.Name);
                await context.PostAsync(message);
                SqlOperations.ForConversationLog(RootDialog.message, message);
            }

            RootDialog rootDialog = new RootDialog();
            await rootDialog.StartAsync(context);
        }
    }
}