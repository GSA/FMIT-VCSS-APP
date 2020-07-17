<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ALCAccounts.aspx.cs" Inherits="Customer_ALCAccounts" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../Styles/Site.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <telerik:RadFormDecorator runat="server" ID="RadFormDecorator1" DecoratedControls="Buttons"
        Skin="Vista" />
    <ajaxToolkit:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server" />
    <script type="text/javascript">
        function CloseAndRebind() {
            GetRadWindow().BrowserWindow.refreshCart();
            GetRadWindow().close();
        }

        function GetRadWindow() {
            var oWindow = null;
            if (window.radWindow) oWindow = window.radWindow;
            else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;

            return oWindow;
        }

        function CancelEdit() {
            GetRadWindow().close();
        }
    </script>
    <div>
        The ALC you selected has accounts associated with it, Requesting access to this
        ALC will grant access to all the Accounts listed below. If you do not need access
        to all the account below click Cancel and request access to individual accounts
        using Account Code Option.
        <br />
        <div style="min-height: 50px; overflow-y: auto; max-height: 300px; width: 80%; margin: 20px auto 10px auto;">
            <telerik:RadListView ID="lvAlcAccounts" runat="server" DataSourceID="odsALCAccounts"
                Width="100%">
                <LayoutTemplate>
                    <table border="1" class="SearchTable">
                        <thead>
                            <tr>
                                <th width="25%">
                                    Account Code
                                </th>
                                <th width="25%">
                                    Address Code
                                </th>
                                <th width="50%">
                                    Organization
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr id="itemPlaceholder" runat="server">
                            </tr>
                        </tbody>
                    </table>
                </LayoutTemplate>
                <AlternatingItemTemplate>
                    <tr class="odd">
                        <td align="center">
                            <%# Eval("ACTCODE")%>
                        </td>
                        <td align="center">
                            <%# Eval("ADDRCODE")%>
                        </td>
                        <td>
                            <%# Eval("NAME")%>
                        </td>
                    </tr>
                </AlternatingItemTemplate>
                <ItemTemplate>
                    <tr>
                        <td align="center">
                            <%# Eval("ACTCODE")%>
                        </td>
                        <td align="center">
                            <%# Eval("ADDRCODE")%>
                        </td>
                        <td>
                            <%# Eval("NAME")%>
                        </td>
                    </tr>
                </ItemTemplate>
                <EmptyDataTemplate>
                    <table style="border: 1px solid gray; background: #F8F8F8">
                        <tr>
                            <td>
                                No Accounts with this ALC.
                            </td>
                        </tr>
                    </table>
                </EmptyDataTemplate>
            </telerik:RadListView>
        </div>
        <asp:ObjectDataSource ID="odsALCAccounts" runat="server" SelectMethod="GetALCAccounts"
            TypeName="DataAccess">
            <SelectParameters>
                <asp:QueryStringParameter Name="alc" QueryStringField="ALC" Type="String" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <br />
        <div style="text-align: center;">
            <asp:Button runat="server" ID="btnOK" Text="Grant Access to all" OnClick="btnOK_Click"
                Width="120px" />&nbsp;
            <asp:Button runat="server" ID="btnCancel" Text="Cancel" OnClientClick="CancelEdit();"
                Width="120px" />
        </div>
    </div>
    </form>
</body>
</html>
