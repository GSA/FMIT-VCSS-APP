using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Data;
using Oracle.DataAccess.Client;

public partial class Customer_Step1 : System.Web.UI.Page
{
    private string customer = "C";
    private string access = "A";
    private string registration = "R";
    Account act = new Account();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
            BindCart();
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        lvAccessAccounts.DataSourceID = "odsAccessAccounts";
    }

    protected void lvAccessAccounts_ItemCommand(object sender, Telerik.Web.UI.RadListViewCommandEventArgs e)
    {
        RadListViewDataItem item = e.ListViewItem as RadListViewDataItem;

        act.ALC = item.GetDataKeyValue("ALC").ToString();
        act.AccountCode = item.GetDataKeyValue("ACTCODE").ToString();
        act.AddressCode = item.GetDataKeyValue("ADDRCODE").ToString();
        act.RegistrationNumber = item.GetDataKeyValue("REGNUM").ToString();
        act.Name = item.GetDataKeyValue("NAME").ToString();
        act.Administrator = item.GetDataKeyValue("ADMINNAME").ToString();
        act.AdministratorEmail = item.GetDataKeyValue("ADMINEMAIL").ToString();
        act.AdministratorPhone = item.GetDataKeyValue("ADMINPHONE").ToString();

        if (e.CommandName == RadListView.SelectCommandName)
        {
            Utilities.AddToCache(act, customer, access);
        }
        BindCart();
    }

    protected void odsAccessAccounts_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
    {
        e.InputParameters["alc"] = rbtnAccessAccountType.SelectedValue.Equals("ALC") ? txtAccessALC.Text.Trim() : string.Empty;
        e.InputParameters["actcode"] = rbtnAccessAccountType.SelectedValue.Equals("ACT") ? txtAccessALC.Text.Trim() : string.Empty;
    }

    protected void lvAccessRequestsCart_ItemCommand(object sender, RadListViewCommandEventArgs e)
    {
        RadListViewDataItem item = e.ListViewItem as RadListViewDataItem;
        act.AccountCode = item.GetDataKeyValue("AccountCode").ToString();
        act.AddressCode = item.GetDataKeyValue("AddressCode").ToString();
        act.RegistrationNumber = item.GetDataKeyValue("RegistrationNumber").ToString();

        if (e.CommandName == "Remove")
        {
            Utilities.RemoveFromCache(act, customer, access);
        }
        BindCart();
    }

    protected void lvRegistrationsRequestsCart_ItemCommand(object sender, RadListViewCommandEventArgs e)
    {
        RadListViewDataItem item = e.ListViewItem as RadListViewDataItem;
        act.ALC = item.GetDataKeyValue("ALC") != null ? item.GetDataKeyValue("ALC").ToString() : string.Empty;
        act.AccountCode = item.GetDataKeyValue("AccountCode") != null ? item.GetDataKeyValue("AccountCode").ToString() : string.Empty;
        act.Name = item.GetDataKeyValue("Name").ToString();

        if (e.CommandName == "Remove")
        {
            Utilities.RemoveFromCache(act, customer, registration);
        }
        BindCart();
    }

    private void BindCart()
    {
        List<Account> acts = new List<Account>();
        lvAccessRequestsCart.DataSource = CacheHelper.Exists<List<Account>>(SessionCache.CACacheKey) ? CacheHelper.Get<List<Account>>(SessionCache.CACacheKey) : acts;
        lvRegistrationsRequestsCart.DataSource = CacheHelper.Exists<List<Account>>(SessionCache.CRCacheKey) ? CacheHelper.Get<List<Account>>(SessionCache.CRCacheKey) : acts;
    }

    protected void btnRegister_Click(object sender, EventArgs e)
    {
        lblMessage.Visible = false;
        string acttype = rbltRegistrationAccountType.SelectedValue;

        act.Name = txtRegAccountName.Text.Trim();
        act.Address1 = txtAddress1.Text.Trim();
        act.Address2 = txtAddress2.Text.Trim();
        act.City = txtCity.Text.Trim();
        act.State = ddlState.SelectedValue;
        act.ZipCode = txtZipCode.Text.Trim();

        if (acttype.Equals("ALC"))
        {
            act.ALC = txtRegAccountNumber.Text.Trim();
            act.AccountCode = string.Empty;
        }
        else if (acttype.Equals("ACT"))
        {
            act.ALC = string.Empty;
            act.AccountCode = txtRegAccountNumber.Text.Trim();
        }

        DataSet ds = new DataSet();
        OracleDataReader oraReader;

        oraReader = DataAccess.GetAccountSearch(string.Empty, string.Empty, act.ALC, act.AccountCode, act.Name, customer);

        //Create a new DataTable.
        DataTable dtReader = new DataTable("Records");

        //Load DataReader into the DataTable.
        dtReader.Load(oraReader);

        //now, convert to DataSet
        ds.Tables.Add(dtReader);

        //ds = DataAccess.GetAccountSearch(string.Empty, string.Empty, act.ALC, act.AccountCode, act.Name, customer);

        if ((ds != null && ds.Tables[0].Rows.Count > 0))
        {
            if (ds.Tables[0].AsEnumerable().Select(x => x.Field<string>("ALC").Equals(act.ALC) && x.Field<string>("ACT").Equals(act.AccountCode) && x.Field<string>("NAME").Equals(act.Name)).Count() > 0)
            {
                lblMessage.Visible = true;
            }
            else
            {
                Utilities.AddToCache(act, customer, registration);

                txtRegAccountNumber.Text = string.Empty;
                txtRegAccountName.Text = string.Empty;
                txtAddress1.Text = string.Empty;
                txtAddress2.Text = string.Empty;
                txtCity.Text = string.Empty;
                ddlState.SelectedIndex = 0;
                txtZipCode.Text = string.Empty;
                btnContinue.Enabled = true;
            }
        }
        else
        {
            Utilities.AddToCache(act, customer, registration);

            txtRegAccountNumber.Text = string.Empty;
            txtRegAccountName.Text = string.Empty;
            txtAddress1.Text = string.Empty;
            txtAddress2.Text = string.Empty;
            txtCity.Text = string.Empty;
            ddlState.SelectedIndex = 0;
            txtZipCode.Text = string.Empty;
            btnContinue.Enabled = true;
        }
        BindCart();
    }

    protected void lvAccessAccounts_ItemCreated(object sender, RadListViewItemEventArgs e)
    {
        if (rbtnAccessAccountType.SelectedValue.Equals("ALC"))
        {
            RadListViewDataItem item = e.Item as RadListViewDataItem;

            if (item != null)
            {
                ImageButton editLink = (ImageButton)e.Item.FindControl("ibtnAdd");
                editLink.Attributes["href"] = "#";
                editLink.Attributes["onclick"] = String.Format("return ShowALCAccounts('{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}');", item.GetDataKeyValue("ALC"), item.GetDataKeyValue("ACTCODE"), item.GetDataKeyValue("ADDRCODE"),
                                                                                                                             item.GetDataKeyValue("REGNUM"), item.GetDataKeyValue("NAME"), item.GetDataKeyValue("ADMINNAME"),
                                                                                                                             item.GetDataKeyValue("ADMINEMAIL"), item.GetDataKeyValue("ADMINPHONE"));
            }
        }
    }

    protected void RadAjaxManager1_AjaxRequest(object sender, AjaxRequestEventArgs e)
    {
        BindCart();
    }
}