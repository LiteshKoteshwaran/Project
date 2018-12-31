using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Threading.Tasks;
using Microsoft.Bot.Builder.Dialogs;
using Microsoft.Bot.Connector;

namespace NMC_IT_Helpdesk_ChatBot_Project.Dialogs
{
    [Serializable]
    public class RootDialog : IDialog<object>
    {
        public static string Name, Email;
        List<string> list;
        static string UserResponse, BotResponse,message; 
        public async Task StartAsync(IDialogContext context)
        {
            // Checking if the user has given his name before 
            if (context.UserData.TryGetValue(StateKeys.UserName, out Name))
            {
                context.Wait(Luis.IdentifyUserQueryUsingLuis);
            }

            else
            {
                //If Its First Time 
                BotResponse = SqlOperations.GetResponseFromBot("ToFetchBotsReply", StateKeys.FootPrintsWiserIssueTicketing, "AskForEmail");

                await context.PostAsync(BotResponse);
                context.Wait(MessageReceivedAsync);
            }
        }

        private async Task MessageReceivedAsync(IDialogContext context, IAwaitable<object> result)
        {
            //Capturing the given Email address by the user
            var activity = await result as Activity;
            context.Wait(CheckForUserExistance);
        }

        private async Task CheckForUserExistance(IDialogContext context, IAwaitable<object> result)
        {
            var activity = await result as Activity;
            Email = activity.Text;

            SqlOperations.GetStaticResponse( StateKeys.ProcForUserName, Email, "Email", "UserName");

            // validating Email 
            Name = SqlOperations.Result; 


            // If the User Existence 
            if (SqlOperations.IsSuccess)
            {
                context.UserData.SetValue(StateKeys.UserEmail, Email);
                context.UserData.SetValue(StateKeys.UserName, Name);

                BotResponse =  SqlOperations.GetResponseFromBot("ToFetchBotsReply", StateKeys.FootPrintsWiserIssueTicketing, MessageType.WiserWelcome);

                    message = BotResponse.Replace("Name",Name);

                SqlOperations.ForConversationLog(activity.Text, message);
                await context.PostAsync(message);


                context.Wait(Luis.IdentifyUserQueryUsingLuis);
            }
            else
            {
                BotResponse = SqlOperations.GetResponseFromBot("ToFetchBotsReply", StateKeys.FootPrintsWiserIssueTicketing, "WorngEmail");

                await context.PostAsync(BotResponse);

            }
        }
    }
}