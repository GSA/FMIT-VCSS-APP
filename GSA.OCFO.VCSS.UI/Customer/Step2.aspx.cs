using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class Customer_Step2 : System.Web.UI.Page
{
    private string customer = "C";
    private string access = "A";
    private string registration = "R";

    Account act = new Account();

    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Cache.SetCacheability(HttpCacheability.NoCache);

        BindCart();

        if (!(CacheHelper.Exists<List<Account>>(SessionCache.CACacheKey) || CacheHelper.Exists<List<Account>>(SessionCache.CRCacheKey)))
        {
            Utilities.ClearCache(customer);
            Response.Redirect("Step1.aspx", false);
        }

        if (!IsPostBack)
        {
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
            Utilities.RemoveFromCache(act, customer, access);
        }

        if (((CacheHelper.Get<List<Account>>(SessionCache.CACacheKey)).Count == 0 && !(CacheHelper.Exists<List<Account>>(SessionCache.CRCacheKey) && (CacheHelper.Get<List<Account>>(SessionCache.CRCacheKey)).Count > 0)))
        {
            Response.Redirect("Step1.aspx", true);
        }

        BindCart();
    }

    protected void lvRegistrationAccounts_ItemCommand(object sender, RadListViewCommandEventArgs e)
    {
        RadListViewDataItem item = e.ListViewItem as RadListViewDataItem;

        act.AccountCode = item.GetDataKeyValue("AccountCode") != null ? item.GetDataKeyValue("AccountCode").ToString() : string.Empty;
        act.Name = item.GetDataKeyValue("Name").ToString();
        act.ALC = item.GetDataKeyValue("ALC") != null ? item.GetDataKeyValue("ALC").ToString() : string.Empty;

        if (e.CommandName == "Remove")
        {
            Utilities.RemoveFromCache(act, customer, registration);
        }

        if (((CacheHelper.Get<List<Account>>(SessionCache.CRCacheKey)).Count == 0 && !(CacheHelper.Exists<List<Account>>(SessionCache.CACacheKey) && (CacheHelper.Get<List<Account>>(SessionCache.CACacheKey)).Count > 0)))
        {
            Response.Redirect("Step1.aspx", true);
        }

        BindCart();
    }

    private void BindCart()
    {
        if (CacheHelper.Exists<List<Account>>(SessionCache.CACacheKey) && (CacheHelper.Get<List<Account>>(SessionCache.CACacheKey)).Count > 0)
        {
            rdzAccessRequest.Visible = true;
            lvAccessAccounts.DataSource = CacheHelper.Get<List<Account>>(SessionCache.CACacheKey);
        }
        else { rdzAccessRequest.Visible = false; }

        if (CacheHelper.Exists<List<Account>>(SessionCache.CRCacheKey) && (CacheHelper.Get<List<Account>>(SessionCache.CRCacheKey)).Count > 0)
        {
            rdzRegistrationRequest.Visible = true;
            lvRegistrationAccounts.DataSource = CacheHelper.Get<List<Account>>(SessionCache.CRCacheKey);
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
            Title = string.Empty,//ddlTitle.SelectedValue,
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