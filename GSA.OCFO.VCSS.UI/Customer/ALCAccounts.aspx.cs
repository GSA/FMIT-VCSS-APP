using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class Customer_ALCAccounts : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //lblALC.Text = "ALC: " + Request.QueryString["ALC"].ToString() + "; ACTCODE: " + Request.QueryString["ActCode"].ToString() + "; AddrCode: " + Request.QueryString["AddrCode"].ToString() +
        //                  "; RegNum: " + Request.QueryString["RegNum"].ToString() + "; Name: " + Request.QueryString["Name"].ToString() + "; AdminName: " + Request.QueryString["AdminName"].ToString() +
        //                  "; AdminEmail: " + Request.QueryString["AdminEmail"].ToString() + "; AdminPhone: " + Request.QueryString["AdminPhone"].ToString();
    }

    protected void btnOK_Click(object sender, EventArgs e)
    {
        AddtoCart();
        ClientScript.RegisterStartupScript(Page.GetType(), "mykey", "CloseAndRebind();", true);
    }

    protected void odsALCAccounts_Selected(object sender, ObjectDataSourceStatusEventArgs e)
    {
        if (e.ReturnValue != null)
        {
            e.AffectedRows = ((DataSet)(e.ReturnValue)).Tables[0].Rows.Count;

            if (e.AffectedRows == 0)
            {
                btnOK_Click(null, null);
                //AddtoCart();
                //string script = "<script language='javascript' type='text/javascript'>Sys.Application.add_load(CloseAndRebind);</script>";
                //ClientScript.RegisterStartupScript(this.GetType(), "Close", script);
            }
        }
    }

    private void AddtoCart()
    {
        Account act = new Account();

        act.ALC = Request.QueryString["ALC"] != null ? Request.QueryString["ALC"].ToString() : string.Empty;
        act.AccountCode = Request.QueryString["ActCode"] != null ? Request.QueryString["ActCode"].ToString() : string.Empty;
        act.AddressCode = Request.QueryString["AddrCode"] != null ? Request.QueryString["AddrCode"].ToString() : string.Empty;
        act.RegistrationNumber = Request.QueryString["RegNum"] != null ? Request.QueryString["RegNum"].ToString() : string.Empty;
        act.Name = Request.QueryString["Name"] != null ? Request.QueryString["Name"].ToString() : string.Empty;
        act.Administrator = Request.QueryString["AdminName"] != null ? Request.QueryString["AdminName"].ToString() : string.Empty;
        act.AdministratorEmail = Request.QueryString["AdminEmail"] != null ? Request.QueryString["AdminEmail"].ToString() : string.Empty;
        act.AdministratorPhone = Request.QueryString["AdminPhone"] != null ? Request.QueryString["AdminPhone"].ToString() : string.Empty;

        Utilities.AddToCache(act, "C", "A");
    }
}