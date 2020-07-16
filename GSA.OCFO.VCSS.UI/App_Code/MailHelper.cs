using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Net.Mail;
using System.Xml.Linq;
using System.Net.Mime;

/// <summary>
/// Summary description for MailHelper
/// </summary>
public static class MailHelper
{
    private static void SendMail(string tomail, string subject, string msg, string fromemail, string fromemaildisplay)
    {
        try
        {
            LinkedResource logo = new LinkedResource(HttpContext.Current.Server.MapPath("~") + "/Images/MailLogo.gif", "image/gif");
            logo.ContentId = "gsalogo";
            logo.TransferEncoding = TransferEncoding.Base64;

            AlternateView aview = AlternateView.CreateAlternateViewFromString(msg, null, MediaTypeNames.Text.Html);
            aview.LinkedResources.Add(logo);

            string[] mailto = tomail.Split(',');

            if (mailto == null)
                throw new ArgumentNullException("To Mail Address list is empty");

            SmtpClient mailer = new SmtpClient();

            MailMessage message = new MailMessage();

            message.From = new MailAddress(fromemail, fromemaildisplay);

            foreach (var item in mailto)
            {
                message.To.Add(new MailAddress(item));
            }

            message.Subject = subject;
            message.AlternateViews.Add(aview);
            message.IsBodyHtml = true;

            mailer.Send(message);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public static void SendRequestMails(string accounttype, string confirmations, List<User> userinfo, List<Account> regaccounts, List<Account> accessaccounts)
    {
        try
        {
            bool byPassAdminMails = Convert.ToBoolean(Utilities.GetConfigurationValue("ByPassAdminMails"));

            string accountType = accounttype.ToUpper().Equals("V") ? "Vendor" : "Customer";
            string confReg = confirmations.Split('|')[0];
            string confAcc = confirmations.Split('|')[1];

            string requestormail = userinfo.First().EmailAddress;
            string financemail = !byPassAdminMails ? (accounttype.ToUpper().Equals("V") ? Utilities.GetConfigurationValue("VFinancialUsers") :
                                                      Utilities.GetConfigurationValue("CFinancialUsers")) : requestormail;
            string secmail = !byPassAdminMails ? Utilities.GetConfigurationValue("SecurityMailBox") : requestormail;
            string regmail = !byPassAdminMails ? Utilities.GetConfigurationValue("RegistrationMailBox") : requestormail;
            string adminmail = string.Empty;

            XDocument content = Utilities.GenerateListToXML(confirmations, string.Empty, userinfo, accessaccounts, regaccounts, string.Empty);

            SendMail(requestormail, "VCSS: Receipt of your request", Utilities.GetMessageBody(content, accountType, string.Empty, "REQUESTOR"), regmail, "VCSS Registration");

            if (regaccounts != null && regaccounts.Count > 0)
            {
                SendMail(regmail, "VCSS: New request received - " + confReg, Utilities.GetMessageBody(content, accountType, string.Empty, "REGISTRATIONMAILBOX"), regmail, "VCSS Registration");
                SendMail(financemail, "VCSS: New request received - " + confReg, Utilities.GetMessageBody(content, string.Empty, string.Empty, "FINANCEUSERS"), regmail, "VCSS Registration");
            }

            if (accessaccounts != null && accessaccounts.Count > 0)
            {
                SendMail(secmail, "VCSS: New request received - " + confAcc, Utilities.GetMessageBody(content, accountType, string.Empty, "SECURITYMAILBOX"), secmail, "VCSS Security");

                var administrators = accessaccounts.Select(row => new { Email = row.AdministratorEmail }).Distinct();
                foreach (var administrator in administrators)
                {
                    var accounts = accessaccounts.Where(x => x.AdministratorEmail.Equals(administrator.Email)).ToList();
                    adminmail = !byPassAdminMails ? administrator.Email : requestormail;
                    SendMail(adminmail, "VCSS: New request received - " + confAcc, Utilities.GetMessageBody(Utilities.GenerateListToXML(confirmations, string.Empty, userinfo, accounts, null, string.Empty), accountType, string.Empty, "ACCOUNTADMINISTRATOR"), secmail, "VCSS Security");
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public static void SendSupportRequestMails(string srtype, string requesttype, string accounttype, List<User> userinfo, List<Account> accounts, string comment)
    {
        try
        {
            bool byPassAdminMails = Convert.ToBoolean(Utilities.GetConfigurationValue("ByPassAdminMails"));

            string requestormail = userinfo.First().EmailAddress;
            string secmail = !byPassAdminMails ? Utilities.GetConfigurationValue("SecurityMailBox") : requestormail;
            string servicedeskmail = !byPassAdminMails ? Utilities.GetConfigurationValue("OCFOCustomerServiceEmail") : requestormail;
            string registrationmail = !byPassAdminMails ? Utilities.GetConfigurationValue("RegistrationMailBox") : requestormail;

            string accountType = accounttype.ToUpper().Equals("V") ? "VENDOR" : "CUSTOMER";

            XDocument content = Utilities.GenerateListToXML(null, requesttype, userinfo, accounts, null, comment);

            string subject = srtype.Equals("RA") ? "VCSS: Remove Account Code/BOAC from User Profile" : (srtype.Equals("RV") ? "VCSS: Separated User/Deactivate User Account" : "VCSS: Receipt of your change request");

            SendMail(requestormail, subject, Utilities.GetMessageBody(content, accountType, srtype, "REQUESTOR"), secmail, "VCSS Security");

            if (srtype.ToUpper().Equals("CA"))
            {
                string adminmail = !byPassAdminMails ? accounts.First().AdministratorEmail : requestormail;

                SendMail(registrationmail, subject, Utilities.GetMessageBody(content, accountType, srtype, "REGISTRATIONMAILBOX"), registrationmail, "VCSS Registration");
                SendMail(adminmail, subject, Utilities.GetMessageBody(content, accountType, srtype, "ACCOUNTADMINISTRATOR"), secmail, "VCSS Security");
            }
            else if (srtype.ToUpper().Equals("UE") || srtype.ToUpper().Equals("UP"))
            {
                SendMail(secmail, subject, Utilities.GetMessageBody(content, accountType, srtype, "SECURITYMAILBOX"), secmail, "VCSS Security");
                SendMail(servicedeskmail, subject, Utilities.GetMessageBody(content, accountType, srtype, "SECURITYMAILBOX"), secmail, "VCSS Security");
            }
            else
            {
                SendMail(secmail, subject, Utilities.GetMessageBody(content, accountType, srtype, "SECURITYMAILBOX"), secmail, "VCSS Security");
            }

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
}
