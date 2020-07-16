using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using System.Xml.Xsl;

public partial class Vendor_Step4 : System.Web.UI.Page
{
    private string vendor = "V";

    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Cache.SetCacheability(HttpCacheability.NoCache);

        if (!IsPostBack)
        {
            List<Account> accessAccounts = new List<Account>();
            List<Account> registrationAccounts = new List<Account>();

            //if (!(CacheHelper.Exists<List<Account>>(SessionCache.VRCacheKey) || CacheHelper.Exists<List<Account>>(SessionCache.VACacheKey)))
            if (string.IsNullOrEmpty(SessionCache.Confirmations))
            {
                Response.Redirect("Step1.aspx", true);
            }
            else
            {
                if (!string.IsNullOrEmpty(SessionCache.VACacheKey))
                {
                    accessAccounts = CacheHelper.Get<List<Account>>(SessionCache.VACacheKey);
                }
                if (!string.IsNullOrEmpty(SessionCache.VRCacheKey))
                {
                    registrationAccounts = CacheHelper.Get<List<Account>>(SessionCache.VRCacheKey);
                }

                lblConfirmation.Text = Utilities.GetMessageBody(Utilities.GenerateListToXML(SessionCache.Confirmations, string.Empty, CacheHelper.Get<List<User>>(SessionCache.UICacheKey), accessAccounts, registrationAccounts, string.Empty), "Vendor", string.Empty, "REQUESTOR").Replace("cid:gsalogo", "../Images/MailLogo.gif");

                Utilities.ClearCache(vendor);
                Session.Clear();
            }
        }
    }
}