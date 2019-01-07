using Microsoft.Bot.Builder.Dialogs;
using Microsoft.Bot.Connector;
using NMC_IT_Helpdesk_ChatBot_Project.Dialogs;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web;

namespace NMC_IT_Helpdesk_ChatBot_Project
{
    [Serializable]
    public class Luis
    {
        public static string intent,entity;

        public static async Task IdentifyUserQueryUsingLuis(IDialogContext context, IAwaitable<object> result)
        {
            var message = await result as Activity;
            RootDialog.message = message.Text;
            LuisResponse Data = new LuisResponse();
            try
            {
                using (HttpClient client = new HttpClient())
                {
                    var responseInString = await client.GetStringAsync(@"https://westus.api.cognitive.microsoft.com/luis/v2.0/apps/ee65d2a0-a313-4c91-8f16-c709f1bda9b7?staging=true&verbose=true&timezoneOffset=-360&subscription-key=0ba1fb13013c46189a8385460812c0bf&q="
                   + System.Uri.EscapeDataString(message.Text));

                    Data = Newtonsoft.Json.JsonConvert.DeserializeObject<LuisResponse>(responseInString);
                    intent = Data.topScoringIntent.intent;
                    if (Data.entities.Count() > 0)
                    {
                        entity = Data.entities[0].entity;
                    }
                    await IdentifyUserIntent(context,result);
                }
            }
            catch (Exception ex)
            {
                ExceptionLog.LogFile(ex);
            }

        }
        public static async Task IdentifyUserIntent(IDialogContext context, IAwaitable<object> result)
        {
            try
            {
                switch (Luis.intent)
                {
                    case (Intents.FootPrintsWiserIssueTicketing):
                        context.Call(new WiserRootDialog(), ResumeAfterOptionDialog);
                        break;
                    case (Intents.EmailAutoReplySetup):
                    case (Intents.EmailCalendarAccess):
                    case (Intents.EmailMimecastRelease):
                    case (Intents.EmailInboxBlockSpam):
                    case (Intents.EmailOutlookSignatureCreation):
                    case (Intents.SelfServiceRequestHardwareType):
                        context.Call(new StaticAndDynamicQnA(), ResumeAfterOptionDialog);
                        break;
                    case (Intents.SmallTalkHelpWhatCanYouDo):
                    case (Intents.SmallTalkGreetingHello):
                    case (Intents.SmallTalkGreetingHowAreYou):
                    case (Intents.SmallTalkGreetingPartOfDAy):
                    case (Intents.SmallTalkGratitudeThankYou):
                    case (Intents.SmallTalkGratitudeWellDone):
                    case (Intents.SmallTalkGratitudeBye):
                    case (Intents.SmallTalkAngryMood):
                    case (Intents.SmallTalkAngryWrongAnswer):
                    case (Intents.SmallTalkGreetingHobbies):
                    case (Intents.SmallTalkGreetingFunny):
                    case (Intents.SmallTalkGreetingWhereDoUWork):
                    case (Intents.SmallTalkEasterEggHitchhikers):
                    case (Intents.SmallTalkEasterEggFootball):
                    case (Intents.SmallTalkEasterEggRelationship):
                    case (Intents.SmallTalkEasterEggHAL):
                    case (Intents.SmallTalkEasterEggAsimov):
                        context.Call(new SmallTalk(), ResumeAfterOptionDialog);
                        break;
                    default: await context.PostAsync($"Sorry {RootDialog.Name} i couldn't understand\n how can i help you");
                        context.Wait(IdentifyUserQueryUsingLuis);
                        break;
                }
            }
            catch (Exception e)
            {
                ExceptionLog.LogFile(e);
            }
        }
        private static Task ResumeAfterOptionDialog(IDialogContext context, IAwaitable<object> result)
        {
            context.Call(new RootDialog(), ResumeAfterOptionDialog);
            return Task.CompletedTask;
        }
    }
}