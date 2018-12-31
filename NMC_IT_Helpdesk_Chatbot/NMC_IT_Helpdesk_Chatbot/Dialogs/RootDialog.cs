using System;
using System.Threading.Tasks;
using Microsoft.Bot.Builder.Dialogs;
using Microsoft.Bot.Connector;

namespace NMC_IT_Helpdesk_Chatbot.Dialogs
{
    [Serializable]
    public class RootDialog : IDialog<object>
    {
        SQLQuries sqlQuries;


        public async Task StartAsync(IDialogContext context)
        {
            string Name;

            //communicating with user if its not the first time
            if (context.UserData.TryGetValue(StateKeys.UserName, out Name))
            {
                await context.PostAsync($"Hi {Name}, how can i help you?");
                context.Wait(MessageReceivedAsync);
            }
            else
            {
                await context.PostAsync($"Hi \n Please Enter Your Email");
                context.Wait(CheckForUserExistance);
            }
        }

        private async Task MessageReceivedAsync(IDialogContext context, IAwaitable<object> result)
        {
            var activity = await result as Activity;
            context.Wait(CheckForUserExistance);
        }
        private async Task CheckForUserExistance(IDialogContext context, IAwaitable<object> result)
        {
            var activity = await result as Activity;
            UserInformation.Email = activity.Text;

            sqlQuries = new SQLQuries();

            // validating Email 
            sqlQuries.GetUserInfo(UserInformation.Email);

            // If the User Email exits 
            await context.PostAsync("enter");
            context.Wait(Luis.IdentifyUserQueryUsingLuis);

            //if (SQLQuries.IsSuccess)
            //{
            //    try
            //    {
            //        //context.UserData.SetValue(StateKeys.UserName, UserInformation.Name);
            //        await context.PostAsync($"Hi, how can i help you today ?");
            //        context.Wait(Luis.IdentifyUserQueryUsingLuis);
            //        //await Luis.IdentifyUserQueryUsingLuis(context,result);
            //    }
            //    catch(Exception e)
            //    {

            //    }
            //}
            //else
            //{
            //    await context.PostAsync("Hey can please Re-enter your Email???");
            //}

        }
    }
}