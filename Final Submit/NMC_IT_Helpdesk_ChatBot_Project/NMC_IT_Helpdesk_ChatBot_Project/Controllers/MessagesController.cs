using System;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web.Http;
using Microsoft.Bot.Builder.Dialogs;
using Microsoft.Bot.Connector;
using NMC_IT_Helpdesk_ChatBot_Project.Dialogs;

namespace NMC_IT_Helpdesk_ChatBot_Project
{
    [BotAuthentication]
    public class MessagesController : ApiController
    {
        /// <summary>
        /// POST: api/Messages
        /// Receive a message from a user and reply to it
        /// </summary>
        public async Task<HttpResponseMessage> Post([FromBody]Activity activity)
        {
            try
            {
                if (activity.GetActivityType() == ActivityTypes.Message)
                {
                    //var connector = new ConnectorClient(new Uri(activity.ServiceUrl));
                    //Activity IsTypingReply = activity.CreateReply();
                    //IsTypingReply.Type = ActivityTypes.Typing;
                    //await connector.Conversations.ReplyToActivityAsync(IsTypingReply);

                    await SendTyping(activity);


                    await Conversation.SendAsync(activity, () => new Dialogs.RootDialog());
                }
                else
                {
                    HandleSystemMessage(activity);
                }
            }
            catch(Exception e)
            {
                ExceptionLog.LogFile(e);
            }
            var response = Request.CreateResponse(HttpStatusCode.OK);
            return response;
        }

        private /*async Task<Activity>*/ Activity HandleSystemMessage(Activity message)
        {
            string messageType = message.GetActivityType();
            if (messageType == ActivityTypes.DeleteUserData)
            {
                // Implement user deletion here
                // If we handle user deletion, return a real message
            }
            else if (messageType == ActivityTypes.ConversationUpdate)
            {
                // Handle conversation state changes, like members being added and removed
                // Use Activity.MembersAdded and Activity.MembersRemoved and Activity.Action for info
                // Not available in all channels
            }
            else if (messageType == ActivityTypes.ContactRelationUpdate)
            {
                // Handle add/remove from contact lists
                // Activity.From + Activity.Action represent what happened
            }
            else if (messageType == ActivityTypes.Typing)
            {
                // Handle knowing that the user is typing
                //var connector = new ConnectorClient(new Uri(message.ServiceUrl));
                //Activity IsTypingReply = message.CreateReply();
                //IsTypingReply.Type = ActivityTypes.Typing;
                //await connector.Conversations.ReplyToActivityAsync(IsTypingReply);



            }
            else if (messageType == ActivityTypes.Ping)
            {
            }

            return null;
        }

        private async Task SendTyping(Activity activity)
        {
            var client = new ConnectorClient(new Uri(activity.ServiceUrl));
            var reply = activity.CreateReply();
            if (activity.ChannelId == ChannelIds.Webchat || activity.ChannelId == ChannelIds.Directline)
            {
                reply.Type = ActivityTypes.Event;
                reply.Name = "typing";
            }
            else
            {
                reply.Type = ActivityTypes.Typing;
                //reply.Name = "typing";
            }

            await client.Conversations.SendToConversationAsync(reply);
        }
    }
}