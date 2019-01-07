using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;

namespace NMC_IT_Helpdesk_ChatBot_Project
{
    [Serializable]
    public class Email : System.Web.UI.Page
    {
        public static void SendEmail( string Email)
        {
            try
            {
                string Token = Guid.NewGuid().ToString();
                MailMessage message = new MailMessage();
                SmtpClient smtp = new SmtpClient();
                message.From = new MailAddress("NMCItHelpDesk@outlook.com");
                message.To.Add(new MailAddress(Email));
                message.Subject = "Refernece ticket number";
                message.Body = " The Reference ticket number :" + Token.Substring(0,10);
                smtp.Port = 587;
                smtp.Host = "smtp.office365.com";  
                smtp.EnableSsl = true;
                smtp.UseDefaultCredentials = false;
                smtp.Credentials = new NetworkCredential("NMCItHelpDesk@outlook.com", "12345Acuvate");
                smtp.DeliveryMethod = SmtpDeliveryMethod.Network;
                smtp.Send(message);
            }
            catch (Exception e)
            {
                ExceptionLog.LogFile(e);
            }
        }
    }
}
