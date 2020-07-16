<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="Step1.aspx.cs" Inherits="Vendor_Step1" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <script src="../Scripts/core.js" type="text/javascript"></script>
    <script language="javascript" type="text/javascript">

        function AccessValidate(sender, args) {
            var textbox = $find("<%= txtAccessDuns.ClientID %>");
            var textbox1 = $find("<%= txtAccessCompany.ClientID %>");
            if (textbox.get_value().length == 0 && textbox1.get_value().length == 0) {
                textbox._invalid = textbox1._invalid = true;
                args.IsValid = false;
            }
            else {
                textbox._invalid = textbox1._invalid = false;
                args.IsValid = true;
            }
            textbox.updateCssClass();
            textbox1.updateCssClass();
        }

    </script>
    <asp:UpdatePanel ID="UpdatePanel3" runat="server" UpdateMode="Always">
        <ContentTemplate>
            <table id="progress">
                <tr>
                    <td class="current">
                        New Requests
                    </td>
                    <td class="next">
                        User Information
                    </td>
                    <td class="next">
                        Confirm and Submit
                    </td>
                    <td class="next">
                        Request Complete
                    </td>
                </tr>
            </table>
            <div style="width: 100%;">
                <div style="float: left; width: 70%;">
                    <telerik:RadToolTipManager ID="RadToolTipManager1" runat="server" SkinID="AutoToolTip" />
                    <telerik:RadDockZone runat="server" ID="rdzAccess" SkinID="Main" CssClass="marginB20">
                        <telerik:RadDock runat="server" ID="rdkAccess" Title="<b>Access Request</b>">
                            <ContentTemplate>
                                <div style="padding: 5px 5px 5px 0px;" class="access">
                                    <div>
                                        <asp:CustomValidator ID="cvCompany" runat="server" Display="Dynamic" ErrorMessage="Please enter Duns or Company"
                                            ValidateEmptyText="true" ClientValidationFunction="AccessValidate" ValidationGroup="Access"
                                            SkinID="Error" />
                                    </div>
                                    <p>
                                        What account(s) would you like access to?</p>
                                    <p>
                                        Enter a DUNS Number <u><b>or</b></u> Company Name.
                                    </p>
                                    <div class="controlsWrapper">
                                        <div class="left">
                                            <telerik:RadTextBox runat="server" ID="txtAccessDuns" WrapperCssClass="inlineblock"
                                                EmptyMessage="Ex. 123456789" Label="DUNS" MaxLength="9" Width="150px" ToolTip="<ul><li>Enter digits only</li></ul>">
                                                <ClientEvents OnKeyPress="IntegersOnly" />
                                            </telerik:RadTextBox>
                                            &nbsp;&nbsp;
                                            <telerik:RadTextBox runat="server" ID="txtAccessCompany" WrapperCssClass="inlineblock"
                                                EmptyMessage="Ex. ABC Company" Label="Company" Width="250px" MaxLength="60" ToolTip="<ul><li>Must not exceed 60 characters</li></ul>" />&nbsp;&nbsp;
                                            <asp:Button ID="btnAccessSearch" runat="server" Text="Search" OnClick="btnAccessSearch_Click"
                                                ValidationGroup="Access" Style="display: inline-block;" />
                                        </div>
                                    </div>
                                    <br />
                                    <br />
                                    <div>
                                        <telerik:RadListView ID="lvAccessAccounts" runat="server" AllowPaging="True" OnItemCommand="lvAccessAccounts_ItemCommand"
                                            DataKeyNames="REGNUM,ACTCODE,ADDRCODE,NAME,ACTNUM,ACTNUM4,ALC,ADMINNAME,ADMINEMAIL,ADMINPHONE">
                                            <LayoutTemplate>
                                                <table border="1" class="SearchTable" style="margin: 10px; width: 580px">
                                                    <thead>
                                                        <tr>
                                                            <th width="20%">
                                                                DUNS
                                                            </th>
                                                            <th width="15%">
                                                                DUNS+4
                                                            </th>
                                                            <th>
                                                                Organization
                                                            </th>
                                                            <th width="10%">
                                                                Add
                                                            </th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <tr id="itemPlaceholder" runat="server" onmouseover="this.style.border='2px solid #000000'"
                                                            onmouseout="this.style.border='2px solid #dde6eb'">
                                                        </tr>
                                                    </tbody>
                                                    <tfoot>
                                                        <tr>
                                                            <td colspan="4">
                                                                <telerik:RadDataPager ID="RadDataPager1" runat="server">
                                                                    <Fields>
                                                                        <telerik:RadDataPagerButtonField FieldType="Numeric" />
                                                                    </Fields>
                                                                </telerik:RadDataPager>
                                                            </td>
                                                        </tr>
                                                    </tfoot>
                                                </table>
                                            </LayoutTemplate>
                                            <AlternatingItemTemplate>
                                                <tr class="odd">
                                                    <td style="text-align: center;">
                                                        <%# Eval("ACTNUM")%>
                                                    </td>
                                                    <td style="text-align: center;">
                                                        <%# Eval("ACTNUM4")%>
                                                    </td>
                                                    <td>
                                                        <%# Eval("NAME")%>
                                                    </td>
                                                    <td style="text-align: center;">
                                                        <asp:ImageButton runat="server" ID="ibtnAdd" CommandName="Select" SkinID="Add" />
                                                    </td>
                                                </tr>
                                            </AlternatingItemTemplate>
                                            <ItemTemplate>
                                                <tr>
                                                    <td style="text-align: center;">
                                                        <%# Eval("ACTNUM")%>
                                                    </td>
                                                    <td style="text-align: center;">
                                                        <%# Eval("ACTNUM4")%>
                                                    </td>
                                                    <td>
                                                        <%# Eval("NAME")%>
                                                    </td>
                                                    <td style="text-align: center;">
                                                        <asp:ImageButton runat="server" ID="ibtnAdd" CommandName="Select" SkinID="Add" />
                                                    </td>
                                                </tr>
                                            </ItemTemplate>
                                            <EmptyDataTemplate>
                                                <table style="border: 1px solid gray; background: #F8F8F8">
                                                    <tr>
                                                        <td>
                                                            Your Search returned no records.
                                                        </td>
                                                    </tr>
                                                </table>
                                            </EmptyDataTemplate>
                                        </telerik:RadListView>
                                        <asp:ObjectDataSource ID="odsAccessAccounts" runat="server" SelectMethod="GetAccountSearch"
                                            TypeName="DataAccess">
                                            <SelectParameters>
                                                <asp:ControlParameter ControlID="txtAccessDuns" Name="duns" PropertyName="Text" Type="String" />
                                                <asp:Parameter Name="duns4" Type="String" DefaultValue="" />
                                                <asp:Parameter Name="alc" Type="String" DefaultValue="" />
                                                <asp:Parameter Name="actcode" Type="String" DefaultValue="" />
                                                <asp:ControlParameter ControlID="txtAccessCompany" Name="company" PropertyName="Text"
                                                    Type="String" />
                                                <asp:Parameter DefaultValue="V" Name="accounttype" Type="String" />
                                            </SelectParameters>
                                        </asp:ObjectDataSource>
                                    </div>
                                </div>
                            </ContentTemplate>
                        </telerik:RadDock>
                    </telerik:RadDockZone>
                    <telerik:RadDockZone runat="server" ID="rdzRegistration" SkinID="Main">
                        <telerik:RadDock runat="server" ID="rdkRegistration" Title="<b>Registration</b>">
                            <ContentTemplate>
                                <div style="padding: 5px 5px 5px 0px;" id="registration">
                                    <div>
                                        <asp:CustomValidator ID="cvRegAccountNumber" runat="server" Display="None" ValidateEmptyText="true"
                                            ControlToValidate="txtRegAccountNumber" ClientValidationFunction="DunsNumber"
                                            ValidationGroup="Registration" />
                                        <asp:CustomValidator ID="cvRegAccountName" runat="server" Display="None" ValidateEmptyText="true"
                                            ControlToValidate="txtRegAccountName" ClientValidationFunction="RequiredField"
                                            ValidationGroup="Registration" />
                                        <asp:Label runat="server" ID="lblMessage" Text="Account already exists" Visible="false"
                                            SkinID="Error" /></div>
                                    <p>
                                        What account(s) would you like to register?</p>
                                    <p>
                                        Enter a DUNS Number <u><b>and</b></u> Company Name.
                                    </p>
                                    <div class="controlsWrapper">
                                        <div class="left">
                                            <telerik:RadTextBox runat="server" ID="txtRegAccountNumber" WrapperCssClass="inlineblock"
                                                Label="DUNS" MaxLength="9" EmptyMessage="Ex. 123456789" Width="150px" ToolTip="<ul><li>DUNS is required</li><li>Enter digits only</li><li>Must be exactly 9 digits</li></ul>">
                                                <ClientEvents OnKeyPress="IntegersOnly" />
                                            </telerik:RadTextBox>&nbsp;&nbsp;&nbsp;
                                            <telerik:RadTextBox runat="server" ID="txtRegAccountName" WrapperCssClass="inlineblock"
                                                Label="Company" EmptyMessage="Ex. ABC Company" Width="250px" MaxLength="60" ToolTip="<ul><li>Company Name is required</li><li>Must not exceed 60 characters</li></ul>" />&nbsp;&nbsp;&nbsp;
                                            <asp:Button ID="btnRegistrationSearch" runat="server" Text="Register" OnClick="btnRegistrationSearch_Click"
                                                ValidationGroup="Registration" Style="display: inline-block;" />
                                        </div>
                                    </div>
                                    <br />
                                    <br />
                                </div>
                            </ContentTemplate>
                        </telerik:RadDock>
                    </telerik:RadDockZone>
                </div>
                <div style="float: right; width: 30%;">
                    <telerik:RadDockZone runat="server" ID="rdzCart" SkinID="Cart">
                        <telerik:RadDock runat="server" ID="rdkCart" Title="<b>Accounts</b>">
                            <ContentTemplate>
                                <div style="margin-top: 5px; text-align: center;">
                                    <telerik:RadListView ID="lvAccessRequestsCart" runat="server" OnItemCommand="lvAccessRequestsCart_ItemCommand"
                                        DataKeyNames="RegistrationNumber,AccountCode,AddressCode">
                                        <LayoutTemplate>
                                            <table border="1" class="SearchTable" style="width: 274px;">
                                                <thead>
                                                    <tr>
                                                        <th>
                                                            Access Requests
                                                        </th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr id="itemPlaceholder" runat="server">
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </LayoutTemplate>
                                        <ItemTemplate>
                                            <tr>
                                                <td>
                                                    <div class="cartItem">
                                                        <div class="name">
                                                            <%# Eval("NAME")%></div>
                                                        <div class="delete">
                                                            <asp:ImageButton runat="server" ID="imgDelete" CommandName="Remove" SkinID="Remove" />
                                                        </div>
                                                        <br />
                                                        <div class="content" id="div<%# Eval("RegistrationNumber")%><%# Eval("AccountCode")%><%# Eval("AddressCode") %>">
                                                            DUNS:
                                                            <%# Eval("NUM")%>&nbsp; DUNS+4:
                                                            <%# Eval("NUM4")%></div>
                                                        <a href="#" class="details" id="<%# Eval("RegistrationNumber")%><%# Eval("AccountCode")%><%# Eval("AddressCode") %>">
                                                            + SHOW DETAILS</a>
                                                    </div>
                                                </td>
                                            </tr>
                                        </ItemTemplate>
                                        <AlternatingItemTemplate>
                                            <tr class="odd">
                                                <td>
                                                    <div class="cartItem">
                                                        <div class="name">
                                                            <%# Eval("NAME")%></div>
                                                        <div class="delete">
                                                            <asp:ImageButton runat="server" ID="imgDelete" CommandName="Remove" SkinID="Remove" />
                                                        </div>
                                                        <br />
                                                        <div class="content" id="div<%# Eval("RegistrationNumber")%><%# Eval("AccountCode")%><%# Eval("AddressCode") %>">
                                                            DUNS:
                                                            <%# Eval("NUM")%>&nbsp; DUNS+4:
                                                            <%# Eval("NUM4")%></div>
                                                        <a href="#" class="details" id="<%# Eval("RegistrationNumber")%><%# Eval("AccountCode")%><%# Eval("AddressCode") %>">
                                                            + SHOW DETAILS</a>
                                                    </div>
                                                </td>
                                            </tr>
                                        </AlternatingItemTemplate>
                                        <EmptyDataTemplate>
                                            <table border="1" class="SearchTable" style="width: 274px;">
                                                <thead>
                                                    <tr>
                                                        <th>
                                                            Access Requests
                                                        </th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr id="itemPlaceholder" runat="server">
                                                        <td>
                                                            There are no accounts added.
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </EmptyDataTemplate>
                                    </telerik:RadListView>
                                    <br />
                                    <telerik:RadListView ID="lvRegistrationsRequestsCart" runat="server" OnItemCommand="lvRegistrationsRequestsCart_ItemCommand"
                                        DataKeyNames="Name,Num">
                                        <LayoutTemplate>
                                            <table border="1" class="SearchTable" style="width: 274px;">
                                                <thead>
                                                    <tr>
                                                        <th>
                                                            Registration Requests
                                                        </th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr id="itemPlaceholder" runat="server">
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </LayoutTemplate>
                                        <ItemTemplate>
                                            <tr>
                                                <td>
                                                    <div class="cartItem">
                                                        <div class="name">
                                                            <%# Eval("NAME")%></div>
                                                        <div class="delete">
                                                            <asp:ImageButton runat="server" ID="imgDelete" CommandName="Remove" SkinID="Remove" />
                                                        </div>
                                                        <br />
                                                        <div class="content" id="div<%# Eval("NAME").ToString().Replace(" ", string.Empty)%><%# Eval("NUM")%>">
                                                            DUNS:
                                                            <%# Eval("NUM")%>
                                                        </div>
                                                        <a href="#" class="details" id="<%# Eval("NAME").ToString().Replace(" ", string.Empty)%><%# Eval("NUM")%>">
                                                            + SHOW DETAILS</a>
                                                    </div>
                                                </td>
                                            </tr>
                                        </ItemTemplate>
                                        <AlternatingItemTemplate>
                                            <tr class="odd">
                                                <td>
                                                    <div class="cartItem">
                                                        <div class="name">
                                                            <%# Eval("NAME")%></div>
                                                        <div class="delete">
                                                            <asp:ImageButton runat="server" ID="imgDelete" CommandName="Remove" SkinID="Remove" />
                                                        </div>
                                                        <br />
                                                        <div class="content" id="div<%# Eval("NAME").ToString().Replace(" ", string.Empty)%><%# Eval("NUM")%>">
                                                            DUNS:
                                                            <%# Eval("NUM")%>
                                                        </div>
                                                        <a href="#" class="details" id="<%# Eval("NAME").ToString().Replace(" ", string.Empty)%><%# Eval("NUM")%>">
                                                            + SHOW DETAILS</a>
                                                    </div>
                                                </td>
                                            </tr>
                                        </AlternatingItemTemplate>
                                        <EmptyDataTemplate>
                                            <table border="1" class="SearchTable" style="width: 274px;">
                                                <thead>
                                                    <tr>
                                                        <th>
                                                            Registration Requests
                                                        </th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr id="itemPlaceholder" runat="server">
                                                        <td>
                                                            There are no accounts added.
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </EmptyDataTemplate>
                                    </telerik:RadListView>
                                    <br />
                                    <asp:Button ID="btnContinue" runat="server" Text="Continue" Width="100%" AutoPostBack="true"
                                        Style="font-weight: bold;" PostBackUrl="~/Vendor/Step2.aspx" />
                                </div>
                            </ContentTemplate>
                        </telerik:RadDock>
                    </telerik:RadDockZone>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
