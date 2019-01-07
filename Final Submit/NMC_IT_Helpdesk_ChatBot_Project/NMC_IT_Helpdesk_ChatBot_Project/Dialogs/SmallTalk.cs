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
    public class SmallTalk : IDialog<object>
    {
        public async Task StartAsync(IDialogContext context)
        {
            await MessageReceivedAsync(context);
        }
        private async Task MessageReceivedAsync(IDialogContext context)
        {
            try
            {
                if (Intents.SmallTalkHelpWhatCanYouDo == Luis.intent)
                {
                    SqlOperations.ForConversationLog(RootDialog.message, "Carousel");
                    List<string> List = new List<string>();
                    List = SqlOperations.GetList("OptionsForThingsDoneByBot");
                    string message = List[0].Replace("{Name}", RootDialog.Name);
                    List.RemoveAt(0);
                    await context.PostAsync(message);
                    await HeroCard(context, List);
                }
                else
                {
                    RootDialog.BotResponse = SqlOperations.ForBotReply(Luis.intent);
                    if(RootDialog.message== "Morning"|| RootDialog.message == "Afternoon" || RootDialog.message == "Evening" || RootDialog.message == "Night")
                    {
                        await context.PostAsync(RootDialog.message+" "+RootDialog.BotResponse);
                        SqlOperations.ForConversationLog(RootDialog.message, RootDialog.BotResponse);
                    }
                    else if (RootDialog.BotResponse.Contains("{Name}"))
                    {
                        string message = RootDialog.BotResponse.Replace("{Name}", RootDialog.Name);

                        await context.PostAsync(message);
                    }
                    else
                    {
                        await context.PostAsync(RootDialog.BotResponse);
                        SqlOperations.ForConversationLog(RootDialog.message, RootDialog.BotResponse);
                    }
                    RootDialog rootDialog = new RootDialog();
                    await rootDialog.StartAsync(context);
                }
            }
            catch(Exception e)
            {
                ExceptionLog.LogFile(e);
            }
        }
        private async Task HeroCard(IDialogContext context, List<string> List)
        {
            try
            {
                var resultMessage = context.MakeMessage();
                resultMessage.AttachmentLayout = AttachmentLayoutTypes.Carousel;
                resultMessage.Attachments = new List<Attachment>();

                foreach (var message in List)
                {
                    HeroCard heroCard = new HeroCard()
                    {
                        Title = message,
                        Images = new List<CardImage>()
                    {
                        new CardImage(){Url = StateKeys.Img}
                    },
                        //Buttons = new List<CardAction>()
                        //{
                        //    new CardAction()
                        //    {
                        //        Title = "Ready To Hepl",
                        //        Type = ActionTypes.ImBack,
                        //        Value = "",
                        //    }
                        //}
                    };
                    resultMessage.Attachments.Add(heroCard.ToAttachment());
                }

                await context.PostAsync(resultMessage);
                await context.PostAsync("How can I Help you");
                RootDialog rootDialog = new RootDialog();
                await rootDialog.StartAsync(context);
            }
            catch(Exception e)
            {
                ExceptionLog.LogFile(e);
            }
        }
    }
}
