using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Customer_Step3 : System.Web.UI.Page
{
    private string customer = "C";
    private string access = "A";
    private string registration = "R";

    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Cache.SetCacheability(HttpCacheability.NoCache);

        if (!IsPostBack)
        {
            if (Page.PreviousPage == null || !(CacheHelper.Exists<List<Account>>(SessionCache.CRCacheKey) || CacheHelper.Exists<List<Account>>(SessionCache.CACacheKey)))
            {
                Utilities.ClearCache(customer);
                Response.Redirect("Step1.aspx", true);
            }
            BindCart();
        }        
    }

    private void BindCart()
    {
        if ((CacheHelper.Exists<List<Account>>(SessionCache.CACacheKey)))
        {
            if ((CacheHelper.Get<List<Account>>(SessionCache.CACacheKey)).Count > 0)
            {
                divAccess.Visible = true;
                lvAccessAccounts.DataSource = !string.IsNullOrEmpty(SessionCache.CACacheKey) ? CacheHelper.Get<List<Account>>(SessionCache.CACacheKey) : null;
            }
        }

        if ((CacheHelper.Exists<List<Account>>(SessionCache.CRCacheKey)))
        {
            if ((CacheHelper.Get<List<Account>>(SessionCache.CRCacheKey)).Count > 0)
            {
                divRegistration.Visible = true;
                lvRegistrationAccounts.DataSource = !string.IsNullOrEmpty(SessionCache.CRCacheKey) ? CacheHelper.Get<List<Account>>(SessionCache.CRCacheKey) : null;
            }
        }

        if (CacheHelper.Exists<List<Account>>(SessionCache.CRCacheKey) && CacheHelper.Exists<List<Account>>(SessionCache.CACacheKey))
        {
            if ((CacheHelper.Get<List<Account>>(SessionCache.CRCacheKey)).Count > 0 && (CacheHelper.Get<List<Account>>(SessionCache.CACacheKey)).Count > 0)
            {
                divider.Visible = true;
            }
        }

        lvUserInfo.DataSource = CacheHelper.Get<List<User>>(SessionCache.UICacheKey);
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        List<Account> accessAccounts = new List<Account>();
        List<Account> registrationAccounts = new List<Account>();
        List<User> user = new List<User>();

        try
        {
            rcptSubmit.Validate();
            Page.Validate();

            if (rcptSubmit.IsValid)
            {
                if (!string.IsNullOrEmpty(SessionCache.CACacheKey))
                {
                    accessAccounts = CacheHelper.Get<List<Account>>(SessionCache.CACacheKey);
                }

                if (!string.IsNullOrEmpty(SessionCache.CRCacheKey))
                {
                    registrationAccounts = CacheHelper.Get<List<Account>>(SessionCache.CRCacheKey);
                }

                user = CacheHelper.Get<List<User>>(SessionCache.UICacheKey);

                string confirmations = SessionCache.Confirmations = DataAccess.CreateRequest(Utilities.GenerateListToXML(null, string.Empty, user, accessAccounts, registrationAccounts, string.Empty).ToString(), customer);

                if (!string.IsNullOrEmpty(confirmations))
                {
                    MailHelper.SendRequestMails(customer, confirmations, user, registrationAccounts, accessAccounts);
                    Response.Redirect("Step4.aspx", true);
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
}