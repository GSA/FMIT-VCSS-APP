using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Data;

public partial class Vendor_Step2 : System.Web.UI.Page
{
    private string vendor = "V";
    private string access = "A";
    private string registration = "R";

    Account act = new Account();

    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Cache.SetCacheability(HttpCacheability.NoCache);

        if (!(CacheHelper.Exists<List<Account>>(SessionCache.VACacheKey) || CacheHelper.Exists<List<Account>>(SessionCache.VRCacheKey)))
        {
            Utilities.ClearCache(vendor);
            Response.Redirect("Step1.aspx", true);
        }

        BindCart();

        if (!IsPostBack)
        {
            //if (CacheHelper.Exists<List<User>>("UserInfo"))
            if (CacheHelper.Exists<List<User>>(SessionCache.UICacheKey))
            {
                //ddlTitle.SelectedValue = CacheHelper.Get<List<User>>(SessionCache.UICacheKey).First().Title;
                txtFirstName.Text = CacheHelper.Get<List<User>>(SessionCache.UICacheKey).First().FirstName;
                txtLastName.Text = CacheHelper.Get<List<User>>(SessionCache.UICacheKey).First().LastName;
                txtEmailAddress.Text = CacheHelper.Get<List<User>>(SessionCache.UICacheKey).First().EmailAddress;
                txtConfirmEmailAddress.Text = CacheHelper.Get<List<User>>(SessionCache.UICacheKey).First().EmailAddress;
                txtPhoneNumber.Text = CacheHelper.Get<List<User>>(SessionCache.UICacheKey).First().PhoneNumber;
                txtNonUSPhoneNumber.Text = CacheHelper.Get<List<User>>(SessionCache.UICacheKey).First().NonUSPhoneNumber;
                txtFaxNumber.Text = CacheHelper.Get<List<User>>(SessionCache.UICacheKey).First().FaxNumber;
            }
        }
    }

    protected void lvAccessAccounts_ItemCommand(object sender, RadListViewCommandEventArgs e)
    {
        RadListViewDataItem item = e.ListViewItem as RadListViewDataItem;

        act.AccountCode = item.GetDataKeyValue("AccountCode").ToString();
        act.AddressCode = item.GetDataKeyValue("AddressCode").ToString();
        act.RegistrationNumber = item.GetDataKeyValue("RegistrationNumber").ToString();

        if (e.CommandName == "Remove")
        {
            Utilities.RemoveFromCache(act, vendor, access);
        }

        if (((CacheHelper.Get<List<Account>>(SessionCache.VACacheKey)).Count == 0 && !(CacheHelper.Exists<List<Account>>(SessionCache.VRCacheKey) && (CacheHelper.Get<List<Account>>(SessionCache.VRCacheKey)).Count > 0)))
        {
            Response.Redirect("Step1.aspx", true);
        }

        BindCart();
    }

    protected void lvRegistrationAccounts_ItemCommand(object sender, RadListViewCommandEventArgs e)
    {
        RadListViewDataItem item = e.ListViewItem as RadListViewDataItem;

        act.Num = item.GetDataKeyValue("Num").ToString();
        act.Name = item.GetDataKeyValue("Name").ToString();

        if (e.CommandName == "Remove")
        {
            Utilities.RemoveFromCache(act, vendor, registration);
        }

        if (((CacheHelper.Get<List<Account>>(SessionCache.VRCacheKey)).Count == 0 && !(CacheHelper.Exists<List<Account>>(SessionCache.VACacheKey) && (CacheHelper.Get<List<Account>>(SessionCache.VACacheKey)).Count > 0)))
        {
            Response.Redirect("Step1.aspx", true);
        }

        BindCart();
    }

    private void BindCart()
    {

        if (CacheHelper.Exists<List<Account>>(SessionCache.VACacheKey) && (CacheHelper.Get<List<Account>>(SessionCache.VACacheKey)).Count > 0)
        {
            rdzAccessRequest.Visible = true;
            lvAccessAccounts.DataSource = CacheHelper.Get<List<Account>>(SessionCache.VACacheKey);
        }
        else { rdzAccessRequest.Visible = false; }

        if (CacheHelper.Exists<List<Account>>(SessionCache.VRCacheKey) && (CacheHelper.Get<List<Account>>(SessionCache.VRCacheKey)).Count > 0)
        {
            rdzRegistrationRequest.Visible = true;
            lvRegistrationAccounts.DataSource = CacheHelper.Get<List<Account>>(SessionCache.VRCacheKey);
        }
        else
        {
            rdzRegistrationRequest.Visible = false;
        }
    }

    protected void btnContinue_Click(object sender, EventArgs e)
    {
        SessionCache.UICacheKey = DateTime.Now.ToString("ddMMyyHHmmssffff");

        List<User> user = new List<User>();
        user.Add(new User
        {
            Title = string.Empty,// ddlTitle.SelectedValue,
            FirstName = txtFirstName.Text.Trim(),
            LastName = txtLastName.Text.Trim(),
            EmailAddress = txtEmailAddress.Text.Trim(),
            PhoneNumber = txtPhoneNumber.Text.Trim(),
            NonUSPhoneNumber = txtNonUSPhoneNumber.Text.Trim(),
            FaxNumber = txtFaxNumber.Text.Trim()
        });

        CacheHelper.Create(SessionCache.UICacheKey, user);
    }
}