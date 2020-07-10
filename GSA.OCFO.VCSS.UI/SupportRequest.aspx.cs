using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Oracle.DataAccess.Client;

public partial class SupportRequest : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        srconfirmation.Visible = false;
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        rcptSubmit.Validate();
        Page.Validate();

        if (rcptSubmit.IsValid)
        {
            btnSubmit.Enabled = false;
            DataSet ds = new DataSet();

            string company = txtCompanyName.Text.Trim();
            string duns = txtDunsNumber.Text.Trim();
            string organization = txtOrganizationName.Text.Trim();
            string acttype = rbltCustAccountType.SelectedValue;
            string alc = string.Empty;
            string accountcode = string.Empty;
            string updatedemail = txtUpdatedEmail.Text.Trim();
            string updateoption = rbtnUpdateType.SelectedValue;
            string accounttype = rbtnAccountType.SelectedValue;
            string topic = lbTopic.SelectedValue;
            string srtype = string.Empty;
            string requesttype = string.Empty;
            bool sendMail = false;
            List<Account> acts = new List<Account>();

            if (acttype.Equals("ALC"))
            { alc = txtAccountNumber.Text.Trim(); }
            else { accountcode = txtAccountNumber.Text.Trim(); }

            try
            {
                OracleDataReader oraReader;
                if (topic == "1")
                {
                    requesttype = rbtnChangeAccountAdminType.SelectedValue.ToUpper().Equals("N") ? "New Account Administrator" : "Account Administrator left";

                    srtype = "CA";

                    if (accounttype == "V")
                    {
                        //Create a new DataTable.
                        DataTable dtReader = new DataTable("Records");

                        //ds = DataAccess.GetAccountSearch(duns, string.Empty, string.Empty, string.Empty, string.Empty, "V");
                        oraReader = DataAccess.GetAccountSearch(duns, string.Empty, string.Empty, string.Empty, string.Empty, "V");

                        //Load DataReader into the DataTable.
                        dtReader.Load(oraReader);

                        //now, convert to DataSet
                        ds.Tables.Add(dtReader);
                        
                    }
                    else
                    {
                        //Create a new DataTable.
                        DataTable dtReader = new DataTable("Records");

                        //ds = DataAccess.GetAccountSearch(string.Empty, string.Empty, alc, accountcode, string.Empty, "C");
                        oraReader = DataAccess.GetAccountSearch(string.Empty, string.Empty, alc, accountcode, string.Empty, "C");

                        //Load DataReader into the DataTable.
                        dtReader.Load(oraReader);

                        //now, convert to DataSet
                        ds.Tables.Add(dtReader);
                    }

                    if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                    {
                        var accounts = ds.Tables[0].AsEnumerable().Select(r => new
                        {
                            Number = r.Field<string>("ACTNUM"),
                            Number4 = r.Field<string>("ACTNUM4"),
                            ALC = r.Field<string>("ALC"),
                            AccountCode = r.Field<string>("ACTCODE"),
                            AddressCode = r.Field<string>("ADDRCODE"),
                            RegistrationNumber = r.Field<string>("REGNUM"),
                            Name = r.Field<string>("NAME"),
                            Administrator = r.Field<string>("ADMINNAME"),
                            AdministratorEmail = r.Field<string>("ADMINEMAIL"),
                            AdministratorPhone = r.Field<string>("ADMINPHONE"),
                        });

                        foreach (var account in accounts)
                        {
                            acts.Add(new Account
                            {
                                Num = account.Number,
                                Num4 = account.Number4,
                                ALC = account.ALC,
                                AccountCode = account.AccountCode,
                                AddressCode = account.AddressCode,
                                RegistrationNumber = account.RegistrationNumber,
                                Name = account.Name,
                                Administrator = account.Administrator,
                                AdministratorEmail = account.AdministratorEmail,
                                AdministratorPhone = account.AdministratorPhone
                            });
                        }
                        sendMail = true;
                    }
                }
                else if (topic == "2")
                {
                    srtype = "RA";

                    if (accounttype == "V")
                    {
                        acts.Add(new Account { Num = duns, Name = company });
                    }
                    else
                    {
                        acts.Add(new Account { ALC = alc, AccountCode = accountcode, Name = organization });
                    }

                    sendMail = true;
                }
                else if (topic == "3")
                {
                    srtype = "RV";
                    sendMail = true;
                }
                else if (topic == "4")
                {
                    if (updateoption == "E")
                    {
                        srtype = "UE";
                    }
                    else
                    {
                        srtype = "UP";
                    }
                    sendMail = true;
                }

                List<User> user = new List<User>();
                user.Add(new User
                {
                    FirstName = txtFirstName.Text.Trim(),
                    LastName = txtLastName.Text.Trim(),
                    EmailAddress = txtEmailAddress.Text.Trim(),
                    PhoneNumber = txtPhoneNumber.Text.Trim(),
                    NewEmailAddress = txtUpdatedEmail.Text.Trim()
                });


                if (sendMail)
                {
                    MailHelper.SendSupportRequestMails(srtype, requesttype, accounttype, user, acts, string.Empty);
                    srmain.Visible = false;
                    srconfirmation.Visible = true;
                    lblConfirmation.Text = Utilities.GetMessageBody(Utilities.GenerateListToXML(null, requesttype, user, acts, null, string.Empty), accounttype.Equals("V") ? "Vendor" : "Customer", srtype, "REQUESTOR").Replace("cid:gsalogo", "Images/MailLogo.gif");
                }
                else
                {
                    if (topic == "1")
                    {
                        lblNoAccountMessage.Visible = true;
                        btnSubmit.Enabled = true;
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}