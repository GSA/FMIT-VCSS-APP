<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="Step4.aspx.cs" Inherits="Vendor_Step4" %>

<%@ PreviousPageType VirtualPath="~/Vendor/Step3.aspx" %>
<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">    
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <script src="../Scripts/core.js" type="text/javascript"></script>
    <table id="progress">
        <tr>
            <td class="previous">
                New Requests
            </td>
            <td class="previous">
                User Information
            </td>
            <td class="previous">
                Confirm and Submit
            </td>
            <td class="current">
                Request Complete
            </td>
        </tr>
    </table>
    <h3>
        Thank you!</h3>
    <p>
        We have received your request. A email with confirmation code(s) has been sent to
        your mailbox with the below information.</p>
    <p>
        <asp:Label runat="server" ID="lblConfirmation" /></p>
    <asp:Button ID="btnCompleted" runat="server" Text="Complete" PostBackUrl="~/Default.aspx" />
</asp:Content>
