using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

public partial class Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (User.Identity.IsAuthenticated)
        {
            Response.Redirect("Admin.aspx");
        }   
    }

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        string username = txtUserName.Text.Trim();
        string password = txtPassword.Text.Trim();
        if (FormsAuthentication.Authenticate(username.ToUpper(), password))
        {
            if (Request.QueryString["ReturnUrl"] != null)
            {
                FormsAuthentication.RedirectFromLoginPage(username, false);
            }
            else
            {
                FormsAuthentication.SetAuthCookie(username, false);
                Response.Redirect("Admin.aspx", true);
            }
        }
        else
        {
            lblMessage.Visible = true;
        }        
    }
}