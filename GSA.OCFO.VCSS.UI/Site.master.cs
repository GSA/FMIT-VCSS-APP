using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Configuration;
using System.IO;

public partial class SiteMaster : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Page.Header.DataBind();

        InlinePageStyles.InnerHtml += string.Format(WebConfigurationManager.AppSettings["CssPageClass"], ConvertRelativeUrlToAbsoluteUrl(this.Request, ResolveUrl("~/")));

        //if (!IsPostBack)
        //{
        //    if (SessionCache.CheckBrowserCompatibility)
        //    {
        //        //if (!(Request.Browser.Browser.ToUpper().Equals("IE") || Request.Browser.Browser.ToUpper().Equals("FIREFOX")))
        //        if (!Request.Browser.Browser.ToUpper().Equals("IE"))
        //        {
        //            Response.Redirect("~/UnsupportedBrowser.aspx", true);
        //        }
        //    }
        //    else
        //    {
        //        Session.Clear();
        //    }
        //}
    }

    private string ConvertRelativeUrlToAbsoluteUrl(HttpRequest request, string relativeUrl)
    {
        return string.Format("http{2}://{0}{1}", request.Url.Host, System.Web.VirtualPathUtility.ToAbsolute(relativeUrl), request.IsSecureConnection ? "s" : string.Empty);
    }
}
