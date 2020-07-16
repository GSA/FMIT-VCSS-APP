using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Customer_Step4 : System.Web.UI.Page
{
    private string customer = "C";
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Cache.SetCacheability(HttpCacheability.NoCache);

        if (!IsPostBack)
        {
            List<Account> accessAccounts = new List<Account>();
            List<Account> registrationAccounts = new List<Account>();

            if (string.IsNullOrEmpty(SessionCache.Confirmations))
            {
                Response.Redirect("Step1.aspx", true);
            }
            else
            {
                accessAccounts = CacheHelper.Exists<List<Account>>(SessionCache.CACacheKey) ? CacheHelper.Get<List<Account>>(SessionCache.CACacheKey) : accessAccounts;
                registrationAccounts = CacheHelper.Exists<List<Account>>(SessionCache.CRCacheKey) ? CacheHelper.Get<List<Account>>(SessionCache.CRCacheKey) : registrationAccounts;

                lblConfirmation.Text = Utilities.GetMessageBody(Utilities.GenerateListToXML(SessionCache.Confirmations, string.Empty, CacheHelper.Get<List<User>>(SessionCache.UICacheKey), accessAccounts, registrationAccounts, string.Empty), "Customer", string.Empty, "REQUESTOR").Replace("cid:gsalogo", "../Images/MailLogo.gif");
            }
        }

        Utilities.ClearCache(customer);
        Session.Clear();
    }
}