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
        public static string intent;
        public static List<string> Entity = new List<string>();
        public static List<string> EntityType = new List<string>();

        public static async Task IdentifyUserQueryUsingLuis(IDialogContext context, IAwaitable<object> result)
        {
            Entity.Clear();
            EntityType.Clear();

            var message = await result as Activity;
            RootDialog.message = message.Text;
            LuisResponse Data = new LuisResponse();
            try
            {
                using (HttpClient client = new HttpClient())
                {
                    var responseInString = await client.GetStringAsync(@"https://westus.api.cognitive.microsoft.com/luis/v2.0/apps/2d33781b-3316-4448-a01a-d3208f5b7993?staging=true&verbose=true&timezoneOffset=-360&subscription-key=045e34d91e564e549b7df4a50bc57079&q="
                   + System.Uri.EscapeDataString(message.Text));

                    Data = Newtonsoft.Json.JsonConvert.DeserializeObject<LuisResponse>(responseInString);
                    intent = Data.topScoringIntent.intent;
                    await IdentifyUserIntent(context,result);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }
        public static async Task IdentifyUserIntent(IDialogContext context, IAwaitable<object> result)
        {
            try
            {
                switch (Luis.intent)
                {
                    case ("FootPrintsWiserIssueTicketing"):
                        context.Call(new WiserRootDialog(), ResumeAfterOptionDialog);
                        break;
                }
            }
            catch (Exception e)
            {

            }
        }
        private static Task ResumeAfterOptionDialog(IDialogContext context, IAwaitable<object> result)
        {
            context.Call(new RootDialog(), ResumeAfterOptionDialog);
            return Task.CompletedTask;
        }
    }
}