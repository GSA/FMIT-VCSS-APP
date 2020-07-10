<%@ Application Language="C#" %>
<%@ Import Namespace="Elmah" %>
<%@ Import Namespace="System.Web.Configuration" %>
<script RunAt="server">
    
    void ErrorLog_Logged(object sender, ErrorLoggedEventArgs args)
    {
        //if (args.Entry.Error.Exception is HandledElmahException)
        //    return;

        var config = WebConfigurationManager.OpenWebConfiguration("~");
        var customErrorsSection = (CustomErrorsSection)config.GetSection("system.web/customErrors");

        if (customErrorsSection != null)
        {
            switch (customErrorsSection.Mode)
            {
                case CustomErrorsMode.Off:
                    break;
                case CustomErrorsMode.On:
                    Response.Redirect(String.Format("{0}?id={1}", customErrorsSection.DefaultRedirect, Server.UrlEncode(args.Entry.Id)), true);
                    break;
                case CustomErrorsMode.RemoteOnly:
                    if (!HttpContext.Current.Request.IsLocal)
                        Response.Redirect(String.Format("{0}?id={1}", customErrorsSection.DefaultRedirect, Server.UrlEncode(args.Entry.Id)), true);
                    break;
                default:
                    break;
            }
        }
    }

    //public class HandledElmahException : Exception
    //{
    //    public HandledElmahException() : base() { }
    //    public HandledElmahException(string message) : base(message) { }
    //    public HandledElmahException(string message, Exception innerException) : base(message, innerException) { }
    //}

    //void FriendlyErrorTransfer(string emlahId, string url)
    //{
    //    Response.Redirect(String.Format("{0}?id={1}", url, Server.UrlEncode(emlahId)), true);
    //}
       
</script>
