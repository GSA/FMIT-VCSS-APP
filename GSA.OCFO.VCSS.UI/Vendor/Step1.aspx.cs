using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Data;
using System.Xml.Linq;
using Oracle.DataAccess.Client;

public partial class Vendor_Step1 : System.Web.UI.Page
{
    private string vendor = "V";
    private string access = "A";
    private string registration = "R";
    Account act = new Account();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)            
        BindCart();
    }

    protected void btnAccessSearch_Click(object sender, EventArgs e)
    {
        lvAccessAccounts.DataSourceID = "odsAccessAccounts";
    }

    protected void lvAccessAccounts_ItemCommand(object sender, Telerik.Web.UI.RadListViewCommandEventArgs e)
    {
        RadListViewDataItem item = e.ListViewItem as RadListViewDataItem;

        act.Num = item.GetDataKeyValue("ACTNUM").ToString();
        act.Num4 = item.GetDataKeyValue("ACTNUM4").ToString();
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
            Utilities.AddToCache(act, vendor, access);
        }
        BindCart();
    }

    protected void lvAccessRequestsCart_ItemCommand(object sender, RadListViewCommandEventArgs e)
    {
        RadListViewDataItem item = e.ListViewItem as RadListViewDataItem;
        act.AccountCode = item.GetDataKeyValue("AccountCode").ToString();
        act.AddressCode = item.GetDataKeyValue("AddressCode").ToString();
        act.RegistrationNumber = item.GetDataKeyValue("RegistrationNumber").ToString();

        if (e.CommandName == "Remove")
        {
            Utilities.RemoveFromCache(act, vendor, access);
        }
        BindCart();
    }

    protected void lvRegistrationsRequestsCart_ItemCommand(object sender, RadListViewCommandEventArgs e)
    {
        RadListViewDataItem item = e.ListViewItem as RadListViewDataItem;
        act.Num = item.GetDataKeyValue("Num").ToString();
        act.Name = item.GetDataKeyValue("Name").ToString();

        if (e.CommandName == "Remove")
        {
            Utilities.RemoveFromCache(act, vendor, registration);
        }
        BindCart();
    }

    private void BindCart()
    {
        List<Account> acts = new List<Account>();
        lvAccessRequestsCart.DataSource = CacheHelper.Exists<List<Account>>(SessionCache.VACacheKey) ? CacheHelper.Get<List<Account>>(SessionCache.VACacheKey) : acts;
        lvRegistrationsRequestsCart.DataSource = CacheHelper.Exists<List<Account>>(SessionCache.VRCacheKey) ? CacheHelper.Get<List<Account>>(SessionCache.VRCacheKey) : acts;
    }

    protected void btnRegistrationSearch_Click(object sender, EventArgs e)
    {
        lblMessage.Visible = false;
        act.Num = txtRegAccountNumber.Text.Trim();
        act.Name = txtRegAccountName.Text.Trim();
        DataSet ds = new DataSet();

        OracleDataReader oraReader;
        DataTable dtReader = new DataTable("Records");

        //ds = DataAccess.GetAccountSearch(act.Num, string.Empty, string.Empty, string.Empty, act.Name, vendor);

        dtReader = DataAccess.GetAccountSearch(act.Num, string.Empty, string.Empty, string.Empty, act.Name, vendor);

        ////Create a new DataTable.
        //DataTable dtReader = new DataTable("Records");

        ////Load DataReader into the DataTable.
        //dtReader.Load(oraReader);

        //now, convert to DataSet
        ds.Tables.Add(dtReader);


        if (ds == null && ds.Tables.Count == 0)
        {
            Utilities.AddToCache(act, vendor, registration);
            txtRegAccountNumber.Text = string.Empty;
            txtRegAccountName.Text = string.Empty;
        }
        else
        {
            if (ds.Tables[0].AsEnumerable().Select(x => x.Field<string>("ACTNUM").Equals(act.Num) && x.Field<string>("NAME").Equals(act.Name)).Count() > 0)
            {
                lblMessage.Visible = true;
            }
            else
            {
                Utilities.AddToCache(act, vendor, registration);
                txtRegAccountNumber.Text = string.Empty;
                txtRegAccountName.Text = string.Empty;
            }
        }
        BindCart();
    }
}