<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["Id"] != null)
        {
            lblErrorCode.Visible = true;
            lblErrorCode.Text = "Error code :  <b>" + Request.QueryString["Id"].ToString() + "</b>";
        }
    }
    
</script>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <p style="text-align: center;">
        An error occured while processing your request.<br />
        <asp:Label runat="server" ID="lblErrorCode" Visible="false" /></p>
    <p style="text-align: center;">
        If problem persists, please contact OCFO Customer Service Desk at 1-866-450-6588.</p>
</asp:Content>
