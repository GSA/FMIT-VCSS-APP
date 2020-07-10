<%@ Page Title="" Language="C#" MasterPageFile="Site.master" AutoEventWireup="true" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <script src="Scripts/core.js" type="text/javascript"></script>
    <asp:Xml ID="xmlNotice" runat="server" DocumentSource="~/XmlDatasource/Notice.config"
        TransformSource="~/XmlDatasource/Notice.xslt" />
    <div class="container">
        <div class="button" id="login">
            <telerik:RadButton ID="btnLogin" runat="server" Text="System Login" PostBackUrl="https://phdc-pub.gsa.gov/vssx"
                Width="90%" Font-Bold="true" Target="_blank" />
            <p>
                Use this button if you‘ve already registered for access to use VCSS.</p>
                    <span id="tip"> 
                     <ul>
			<li>Be sure to never use the "back" button of your browser while using VCSS.</li>
			<li>VCSS must be used with the Internet Explorer browser.</li>
		     </ul></span>
        </div>
        <div class="button" id="acttype">
            <telerik:RadButton ID="btnRegistration" runat="server" Text="Registrations & Access Requests"
                PostBackUrl="~/AccountType.aspx" Width="90%" Font-Bold="true" />
            <p>
                Use this button if you are a new user to VCSS and need to:
            </p>
                    <span id="tip"> 
            <ul>
                <li>Register new accounts</li>
                <li>Gain access to existing accounts</li>
            </ul></span>
        </div>
        <div class="button" id="support">
            <telerik:RadButton ID="btnSupportRequest" runat="server" Text="Support Request" PostBackUrl="~/SupportRequest.aspx"
                Width="90%" Font-Bold="true" />
            <p>
                Use this button to create a request that you be removed from an account, or from
                VCSS. You can also change account administrator status.
            </p>
        </div>
    </div>
    <asp:Xml ID="xmlHome" runat="server" DocumentSource="~/XmlDatasource/Home.config"
        TransformSource="~/XmlDatasource/Home.xslt" />
</asp:Content>
