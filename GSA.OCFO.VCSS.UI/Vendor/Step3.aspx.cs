using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class Vendor_Step3 : System.Web.UI.Page
{
    private string vendor = "V";
    private string access = "A";
    private string registration = "R";

    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Cache.SetCacheability(HttpCacheability.NoCache);

        if (!IsPostBack)
        {
            if (Page.PreviousPage == null || !(CacheHelper.Exists<List<Account>>(SessionCache.VRCacheKey) || CacheHelper.Exists<List<Account>>(SessionCache.VACacheKey)))
            {
                Utilities.ClearCache(vendor);
                Response.Redirect("Step1.aspx", true);
            }

            BindCart();
        }
    }

    private void BindCart()
    {
        if ((CacheHelper.Exists<List<Account>>(SessionCache.VACacheKey)))
        {
            if ((CacheHelper.Get<List<Account>>(SessionCache.VACacheKey)).Count > 0)
            {
                divAccess.Visible = true;
                lvAccountReqestAccounts.DataSource = !string.IsNullOrEmpty(SessionCache.VACacheKey) ? CacheHelper.Get<List<Account>>(SessionCache.VACacheKey) : null;
            }
        }

        if ((CacheHelper.Exists<List<Account>>(SessionCache.VRCacheKey)))
        {
            if ((CacheHelper.Get<List<Account>>(SessionCache.VRCacheKey)).Count > 0)
            {
                divRegistration.Visible = true;
                lvRegistrationAccounts.DataSource = !string.IsNullOrEmpty(SessionCache.VRCacheKey) ? CacheHelper.Get<List<Account>>(SessionCache.VRCacheKey) : null;
            }
        }

        if (CacheHelper.Exists<List<Account>>(SessionCache.VRCacheKey) && CacheHelper.Exists<List<Account>>(SessionCache.VACacheKey))
        {
            if ((CacheHelper.Get<List<Account>>(SessionCache.VRCacheKey)).Count > 0 && (CacheHelper.Get<List<Account>>(SessionCache.VACacheKey)).Count > 0)
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
                if (!string.IsNullOrEmpty(SessionCache.VACacheKey))
                {
                    accessAccounts = CacheHelper.Get<List<Account>>(SessionCache.VACacheKey);
                }

                if (!string.IsNullOrEmpty(SessionCache.VRCacheKey))
                {
                    registrationAccounts = CacheHelper.Get<List<Account>>(SessionCache.VRCacheKey);
                }

                user = CacheHelper.Get<List<User>>(SessionCache.UICacheKey);

                string confirmations = SessionCache.Confirmations = DataAccess.CreateRequest(Utilities.GenerateListToXML(null, string.Empty, user, accessAccounts, registrationAccounts, string.Empty).ToString(), "V");

                if (!string.IsNullOrEmpty(confirmations))
                {
                    MailHelper.SendRequestMails(vendor, confirmations, user, registrationAccounts, accessAccounts);
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