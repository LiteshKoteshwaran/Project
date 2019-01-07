using AdaptiveCards;
using AdaptiveCards.Rendering.Wpf;
using Microsoft.Bot.Builder.Dialogs;
using Microsoft.Bot.Connector;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Remoting.Contexts;
using System.Threading.Tasks;
using System.Windows;

namespace NMC_IT_Helpdesk_ChatBot_Project.Dialogs
{
    [Serializable]
    public class WiserFaultDialog : IDialog<object>
    {
        int index = 0;
        public static List<string> ListOfQusetions = new List<string>();
        public static List<string> ListOfAnswer = new List<string>();
        public static List<string> ListOfUnAnsweredQuestion = new List<string>();
        public static string AdditionalInfo, NosOfUserImpacted, DisplayedErrorMessage, TaskAttemptedWhileIssue, PinAndFullName;
        dynamic Data;



        public async Task StartAsync(IDialogContext context)
        {
            await AdaptiveCards(context);
        }

        private async Task AdaptiveCards(IDialogContext context)
        {

            ListOfAnswer.Clear();
            ListOfQusetions.Clear();
            ListOfUnAnsweredQuestion.Clear();


            AdditionalInfo = string.Empty;
            NosOfUserImpacted = string.Empty;
            DisplayedErrorMessage = string.Empty;
            TaskAttemptedWhileIssue = string.Empty;
            PinAndFullName = string.Empty;


            ListOfQusetions = SqlOperations.GetList("OptionsForFaultWiser");
            {
                try
                {
                    var replyActivity = context.MakeMessage();
                    replyActivity.Attachments.Add(new Microsoft.Bot.Connector.Attachment()
                    {
                        ContentType = "application/vnd.microsoft.card.adaptive",
                        Content = JObject.Parse($@"
                                                    {{
                                                      ""$schema"": ""http://adaptivecards.io/schemas/adaptive-card.json"",
                                                      ""type"": ""AdaptiveCard"",
                                                      ""version"": ""1.0"",
                                                      ""body"": [
                                                        {{
                                                                                ""type"": ""ColumnSet"",
                                                                                ""columns"": [
                                                                                                {{
                                                                                                    ""type"": ""Column"",
                                                                                                    ""items"": 
                                                                                                                [                                                                                                                   
                                                                                                                    {{
                                                                                                                        ""type"": ""TextBlock"",
                                                                                                                        ""size"": ""Medium"",
                                                                                                                        ""weight"": ""Bolder"",
                                                                                                                        ""text"": ""{ListOfQusetions[0]}""
                                                                                                                    }},
                                                                                                                    {{
                        
                                                                                                                        ""type"": ""TextBlock"",
                                                                                                                        ""text"": ""{ ListOfQusetions[1] }"",
                                                                                                                    }},
                                                                                                                    {{
                                                                                                                        ""type"": ""Input.Text"",
                                                                                                                        ""id"": ""PinAndFullName"",
                                                                                                                        ""placeholder"": "" * required"",
                                                                                                                    }},
                                                                                                                    {{  
                                                                                                                        ""type"": ""TextBlock"",
                                                                                                                        ""text"": ""{ListOfQusetions[2]}"",
                                                                                                                    }},
                                                                                                                    {{
                                                                                                                        ""type"": ""Input.Text"",
                                                                                                                        ""id"": ""TaskAttemptedWhileIssue"",
                                                                                                                        ""placeholder"": "" * required"",
                                                                                                                    }},
                                                                                                                    {{    
                                                                                                                        ""type"": ""TextBlock"",
                                                                                                                        ""text"": ""{ListOfQusetions[3]}"",
                                                                                                                    }},
                                                                                                                    {{
                                                                                                                        ""type"": ""Input.Text"",
                                                                                                                        ""id"": ""DisplayedErrorMessage"",
                                                                                                                        ""placeholder"": "" * required"",
                                                                                                                    }},
                                                                                                                    {{                                                                                                              
                                                                                                                        ""type"": ""TextBlock"",
                                                                                                                        ""text"": ""{ListOfQusetions[4]}"",
                                                                                                                    }},
                                                                                                                    {{
                                                                                                                        ""type"": ""Input.Text"",
                                                                                                                        ""id"": ""NosOfUserImpacted"",
                                                                                                                        ""placeholder"": "" * required"",
                                                                                                                    }},
                                                                                                                    {{                                                                                                              
                                                                                                                        ""type"": ""TextBlock"",
                                                                                                                        ""text"": ""{ListOfQusetions[5]}"",
                                                                                                                    }},
                                                                                                                    {{
                                                                                                                        ""type"": ""Input.Text"",
                                                                                                                        ""id"": ""AdditionalInfo"",
                                                                                                                        ""placeholder"": ""optional"",
                                                                                                                    }},
                                                                                                                ]
                                                                                                }}
                                                                                             ]
                                                        }}       
                                                                ],
                                                          ""actions"": [
                                                            {{
                                                                ""type"": ""Action.Submit"",
                                                                ""title"": ""Submit"",
                                                                   ""Id"": ""submit""                        
                                                            }},
                                                                       ]
                                                    }}")
                    });

                    await context.PostAsync(replyActivity);

                    context.Wait(ReadDataFromAdaptiveCard);

                }
                catch (Exception e)
                {
                    ExceptionLog.LogFile(e);
                }
            }
        }


        internal async Task ReadDataFromAdaptiveCard(IDialogContext context, IAwaitable<object> result)
        {
            var token = await result as Activity;
            string str = token.Value.ToString();
            Data = Newtonsoft.Json.JsonConvert.DeserializeObject<dynamic>(str);

            await AssignValue(context, result);

        }


        internal async Task AssignValue(IDialogContext context, IAwaitable<object> result)
        {
            if (String.IsNullOrEmpty(PinAndFullName))
            {
                PinAndFullName = Data.PinAndFullName;
                ListOfAnswer.Add(PinAndFullName);
                SqlOperations.ForConversationLog(WiserRootDialog.UserRequest, ListOfQusetions[0]);
                SqlOperations.ForConversationLog(PinAndFullName, ListOfQusetions[1]);
            }

            if (String.IsNullOrEmpty(TaskAttemptedWhileIssue))
            {
                TaskAttemptedWhileIssue = Data.TaskAttemptedWhileIssue;
                ListOfAnswer.Add(TaskAttemptedWhileIssue);
                SqlOperations.ForConversationLog(TaskAttemptedWhileIssue, ListOfQusetions[2]);
            }

            if (String.IsNullOrEmpty(DisplayedErrorMessage))
            {
                DisplayedErrorMessage = Data.DisplayedErrorMessage;
                ListOfAnswer.Add(DisplayedErrorMessage);
                SqlOperations.ForConversationLog(DisplayedErrorMessage, ListOfQusetions[3]);
            }

            if (String.IsNullOrEmpty(NosOfUserImpacted))
            {
                NosOfUserImpacted = Data.NosOfUserImpacted;
                ListOfAnswer.Add(NosOfUserImpacted);
                SqlOperations.ForConversationLog(NosOfUserImpacted, ListOfQusetions[4]);
            }

            if (String.IsNullOrEmpty(AdditionalInfo))
            {
                AdditionalInfo = Data.AdditionalInfo;
                SqlOperations.ForConversationLog(AdditionalInfo, ListOfQusetions[5]);

                await Validation(context, result);
            }


        }

        public async Task Validation(IDialogContext context, IAwaitable<object> result)
        {

            for (int i = 0; i < ListOfAnswer.Count; i++)
            {
                if (ListOfAnswer[i].Count() <= 0)
                {
                    ListOfUnAnsweredQuestion.Add(ListOfQusetions[i+1]);
                }
            }

            if (ListOfUnAnsweredQuestion.Count > 0)
            {
                await context.PostAsync("these are * required");
                await context.PostAsync(ListOfUnAnsweredQuestion[index]);
                index++;
                context.Wait(InCaseOfValidation);

            }
            else
            {
                WiserRootDialog wiserRootDialog = new WiserRootDialog();
                await wiserRootDialog.RiseTicketForFault(context, result);
            }

        }
        internal async Task InCaseOfValidation(IDialogContext context, IAwaitable<object> result)
        {
            var Input = await result as Activity;

            if (String.IsNullOrEmpty(PinAndFullName))
            {
                PinAndFullName = Input.Text;

                SqlOperations.ForConversationLog("these are * required", ListOfQusetions[1]);

                await context.PostAsync(ListOfUnAnsweredQuestion[index]);
                index++;
                context.Wait(InCaseOfValidation);

            }

            else if (String.IsNullOrEmpty(TaskAttemptedWhileIssue))
            {

                TaskAttemptedWhileIssue = Input.Text;

                SqlOperations.ForConversationLog(PinAndFullName, ListOfQusetions[2]);

                await context.PostAsync(ListOfUnAnsweredQuestion[index]);
                index++;

                context.Wait(InCaseOfValidation);
            }
            else if (String.IsNullOrEmpty(DisplayedErrorMessage))
            {

                DisplayedErrorMessage = Input.Text;

                SqlOperations.ForConversationLog(DisplayedErrorMessage, ListOfQusetions[3]);

                await context.PostAsync(ListOfUnAnsweredQuestion[index]);
                index++;
                context.Wait(InCaseOfValidation);

            }

            else if (String.IsNullOrEmpty(NosOfUserImpacted))
            {
                NosOfUserImpacted = Input.Text;

                SqlOperations.ForConversationLog(NosOfUserImpacted, ListOfQusetions[4]);
                WiserRootDialog.UserIncomplete = true;
                WiserRootDialog wiserRootDialog = new WiserRootDialog();
                await wiserRootDialog.RiseTicketForFault(context,result);

            }


        }

    }
}

