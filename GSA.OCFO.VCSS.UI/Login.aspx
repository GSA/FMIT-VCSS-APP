<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="Login.aspx.cs" Inherits="Login" %>

<asp:Content ID="HeaderContent" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="Server">
    <script src="Scripts/core.js" type="text/javascript"></script>
    <asp:UpdatePanel ID="UpdatePanel3" runat="server" UpdateMode="Always">
        <ContentTemplate>
            <asp:Label ID="Label1" runat="server" SkinID="Error" Visible="false" Text="Password did not match, Try again." /><br />
            <div style="text-align: center;">
                <asp:Label ID="lblMessage" runat="server" SkinID="Error" Visible="false" Text="Password did not match, Try again." /><br />
                <br />
                <asp:CustomValidator ID="cvUserName" runat="server" Display="None" ValidateEmptyText="true"
                    ControlToValidate="txtUserName" ClientValidationFunction="RequiredField" />
                <asp:CustomValidator ID="cvPassword" runat="server" Display="None" ValidateEmptyText="true"
                    ControlToValidate="txtPassword" ClientValidationFunction="RequiredField" />
                <telerik:RadTextBox runat="server" ID="txtUserName" EmptyMessage="Enter User Name"
                    InputType="Text" Width="200px" />
                <telerik:RadTextBox runat="server" ID="txtPassword" EmptyMessage="Enter Password"
                    InputType="Text" TextMode="Password" Width="200px" />
                &nbsp;<asp:Button ID="btnLogin" runat="server" Text="Login" OnClick="btnLogin_Click" />
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
