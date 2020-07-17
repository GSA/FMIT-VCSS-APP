<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="Step1.aspx.cs" Inherits="Customer_Step1" %>

<asp:Content ID="HeaderContent" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="Server">
    <script src="../Scripts/core.js" type="text/javascript"></script>
    <script type="text/javascript" language="javascript">

        function AccessValidate(sender, args) {

            if (this.Title != "") {
                var number = $find("<%= txtAccessALC.ClientID %>");
                var name = $find("<%= txtAccessOrganization.ClientID %>");

                var acttype = document.getElementById("<%=rbtnAccessAccountType.ClientID%>");
                var radio = acttype.getElementsByTagName("input");
                var isChecked = false;
                for (var i = 0; i < radio.length; i++) {
                    if (radio[i].checked) {
                        isChecked = true;
                        break;
                    }
                }
                //var cnt = 9;
                args.IsValid = true;
                number._invalid = name._invalid = false;

                if ((number.get_value().length == 0 && !isChecked) && name.get_value().length == 0) {
                    //sender.innerText = "ALC/Account Code or Company is required!"
                    sender.innerText = "Please fill out all the required fields."
                    name._invalid = number._invalid = true;
                    args.IsValid = false;
                    radio[0].parentNode.style.backgroundColor = "#FFD9D9";
                    number.updateCssClass();
                    name.updateCssClass();
                    return;
                }
                else if (name.get_value().length == 0) {
                    if (!isChecked) {
                        sender.innerText = "Account Type is required!"
                        radio[0].parentNode.style.backgroundColor = "#FFD9D9";
                        args.IsValid = false;
                        name.updateCssClass();
                        number.updateCssClass();
                        return;
                    }

                    if (number.get_value().length == 0) {
                        sender.innerText = "ALC/Account Code is required!"
                        radio[0].parentNode.style.backgroundColor = "#FFFFFF";
                        number._invalid = true;
                        args.IsValid = false;
                        name.updateCssClass();
                        number.updateCssClass();
                        return;
                    }
                }
            }
        }

        function ShowALCAccounts(id, actCode, addrCode, regNum, name, adminName, adminEmail, adminPhone) {
            window.radopen("ALCAccounts.aspx?ALC=" + id + "&ActCode=" + actCode + "&AddrCode=" + addrCode + "&RegNum=" + regNum + "&Name=" + name + "&AdminName=" + adminName + "&AdminEmail=" + adminEmail + "&AdminPhone=" + adminPhone, "rwALCAccounts");
            return false;
        }

       function refreshCart() {
            $find("<%= RadAjaxManager1.ClientID %>").ajaxRequest();
        }
    </script>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Always">
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
            <telerik:RadToolTipManager ID="RadToolTipManager1" runat="server" SkinID="AutoToolTip" />
            <div style="width: 100%;">
                <div style="float: left; width: 70%;">
                    <telerik:RadDockZone runat="server" ID="rdzAccessRequst" SkinID="Main" CssClass="marginB20">
                        <telerik:RadDock runat="server" ID="rdkAccessRequst" Title="<b>Access Request</b>">
                            <ContentTemplate>
                                <div style="padding: 10px 10px 10px 0px;">
                                   <div>
                                        <asp:CustomValidator ID="cvCompany" runat="server" Display="Dynamic" ErrorMessage="Please enter Duns or Company"
                                            ValidateEmptyText="true" ClientValidationFunction="AccessValidate" ValidationGroup="Access"
                                            SkinID="Error" /></div>
                                    <p>
                                        What account(s) would you like access to?</p>
                                    <p>
                                        Enter an Account Code (BOAC/AAC)/8-digit ALC (Agency Location Code) <u><b>or</b></u>
                                        Agency Name.
                                    </p>
                                    <div class="controlsWrapper">
                                        <div class="left">
                                            <asp:RadioButtonList ID="rbtnAccessAccountType" runat="server" RepeatDirection="Horizontal"
                                                RepeatLayout="Flow" Style="padding: 1px 5px 1px 5px;">
                                                <asp:ListItem Value="ACT">Account Code (BOAC/AAC)</asp:ListItem>
                                                <asp:ListItem Value="ALC">ALC</asp:ListItem>
                                            </asp:RadioButtonList>
                                            &nbsp;
                                            <telerik:RadTextBox runat="server" ID="txtAccessALC" WrapperCssClass="inlineblock"
                                                EmptyMessage="Ex. 12345678" Width="90px" MaxLength="13" ToolTip="<ul><li>Enter alphanumeric characters and hyphens only</li></ul>">
                                                <ClientEvents OnKeyPress="AlphaNumericAndHyphen" />
                                            </telerik:RadTextBox>&nbsp;&nbsp;
                                            <telerik:RadTextBox runat="server" ID="txtAccessOrganization" WrapperCssClass="inlineblock"
                                                EmptyMessage="Ex. ABC Agency" Label="Organization" Width="200px" MaxLength="60"
                                                ToolTip="<ul><li>Must not exceed 60 characters</li></ul>" />&nbsp;&nbsp;
                                            <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click"
                                                ValidationGroup="Access" Style="display: inline-block;" />
                                        </div>
                                    </div>
                                    <br />
                                    <br />
                                    <div>
                                        <telerik:RadListView ID="lvAccessAccounts" runat="server" AllowPaging="true" OnItemCommand="lvAccessAccounts_ItemCommand"
                                            DataKeyNames="REGNUM,ACTCODE,ADDRCODE,NAME,ALC,ADMINNAME,ADMINEMAIL,ADMINPHONE"
                                            OnItemCreated="lvAccessAccounts_ItemCreated">
                                            <LayoutTemplate>
                                                <table border="1" class="SearchTable">
                                                    <thead>
                                                        <tr>
                                                            <th width="15%">
                                                                ALC
                                                            </th>
                                                            <th width="15%">
                                                                Account Code
                                                            </th>
                                                            <th width="15%">
                                                                Address Code
                                                            </th>
                                                            <th width="50%">
                                                                Organization
                                                            </th>
                                                            <th width="5%">
                                                                Add
                                                            </th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <tr id="itemPlaceholder" runat="server">
                                                        </tr>
                                                    </tbody>
                                                    <tfoot>
                                                        <tr>
                                                            <td colspan="5">
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
                                                    <td align="center">
                                                        <%# Eval("ALC")%>
                                                    </td>
                                                    <td align="center">
                                                        <%# Eval("ACTCODE")%>
                                                    </td>
                                                    <td align="center">
                                                        <%# Eval("ADDRCODE")%>
                                                    </td>
                                                    <td>
                                                        <%# Eval("NAME")%>
                                                    </td>
                                                    <td align="center">
                                                        <asp:ImageButton runat="server" ID="ibtnAdd" CommandName="Select" SkinID="Add" />
                                                    </td>
                                                </tr>
                                            </AlternatingItemTemplate>
                                            <ItemTemplate>
                                                <tr>
                                                    <td align="center">
                                                        <%# Eval("ALC")%>
                                                    </td>
                                                    <td align="center">
                                                        <%# Eval("ACTCODE")%>
                                                    </td>
                                                    <td align="center">
                                                        <%# Eval("ADDRCODE")%>
                                                    </td>
                                                    <td>
                                                        <%# Eval("NAME")%>
                                                    </td>
                                                    <td align="center">
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
                                        <telerik:RadWindowManager ID="rwmALCAccounts" runat="server" EnableShadow="true"
                                            EnableViewState="false" Behaviors="Close" Animation="Fade" VisibleStatusbar="false">
                                            <Windows>
                                                <telerik:RadWindow ID="rwALCAccounts" runat="server" Title="Accounts with this ALC"
                                                    Height="520px" Width="750px" Left="150px" ReloadOnShow="true" ShowContentDuringLoad="false"
                                                    Modal="true">
                                                </telerik:RadWindow>
                                            </Windows>
                                        </telerik:RadWindowManager>
                                        <asp:ObjectDataSource ID="odsAccessAccounts" runat="server" SelectMethod="GetAccountSearch"
                                            TypeName="DataAccess" OnSelecting="odsAccessAccounts_Selecting">
                                            <SelectParameters>
                                                <asp:Parameter Name="duns" Type="String" DefaultValue="" />
                                                <asp:Parameter Name="duns4" Type="String" DefaultValue="" />
                                                <asp:Parameter Name="alc" Type="String" DefaultValue="" />
                                                <asp:Parameter Name="actcode" Type="String" DefaultValue="" />
                                                <asp:ControlParameter ControlID="txtAccessOrganization" Name="company" PropertyName="Text"
                                                    Type="String" />
                                                <asp:Parameter DefaultValue="C" Name="accounttype" Type="String" />
                                            </SelectParameters>
                                        </asp:ObjectDataSource>
                                    </div>
                            </ContentTemplate>
                        </telerik:RadDock>
                    </telerik:RadDockZone>
                    <telerik:RadDockZone runat="server" ID="rdzRegistrationRequest" SkinID="Main">
                        <telerik:RadDock runat="server" ID="rdkRegistrationRequest" Title="<b>Registration</b>">
                            <ContentTemplate>
                                <div style="padding: 10px 10px 10px 0px;">
                                    <div>
                                        <%--<asp:CustomValidator ID="cvRegistrationAccountType1" runat="server" Display="Dynamic" ValidateEmptyText="true"
                                            ClientValidationFunction="RegistrationValidate" ValidationGroup="Registration"
                                            SkinID="Error" />--%><asp:Label runat="server" ID="lblMessage" Text="Account already exists"
                                                Visible="false" SkinID="Error" />
                                    </div>
                                    <p>
                                        What account(s) would you like to register?</p>
                                    <p>
                                        Enter an Account Code (BOAC/AAC)/8-digit ALC (Agency Location Code) <u><b>and</b></u>
                                        Agency Name.
                                    </p>
                                    <div class="controlsWrapper">
                                        <div class="left">
                                            <asp:RadioButtonList ID="rbltRegistrationAccountType" runat="server" RepeatDirection="Horizontal"
                                                RepeatLayout="Flow" Style="padding: 1px 5px 1px 5px;">
                                                <asp:ListItem Value="ACT">Account Code (BOAC/AAC)</asp:ListItem>
                                                <asp:ListItem Value="ALC">ALC</asp:ListItem>
                                            </asp:RadioButtonList>
                                            <asp:CustomValidator ID="cvRegistrationAccountType" runat="server" Display="None"
                                                ValidateEmptyText="true" ControlToValidate="rbltRegistrationAccountType" ClientValidationFunction="RequiredFieldRBTN"
                                                ValidationGroup="Registration" />
                                            &nbsp;
                                            <telerik:RadTextBox runat="server" ID="txtRegAccountNumber" WrapperCssClass="inlineblock"
                                                EmptyMessage="Ex. 12345678" Width="90px" MaxLength="13" ToolTip="<ul><li>ALC/Account Code is Required</li><li>Enter alphanumeric characters and hyphens only</li></ul>">
                                                <ClientEvents OnKeyPress="AlphaNumericAndHyphen" />
                                            </telerik:RadTextBox>
                                            <asp:CustomValidator ID="cvRegAccountNumber" runat="server" Display="None" ValidateEmptyText="true"
                                                ControlToValidate="txtRegAccountNumber" ClientValidationFunction="RequiredFieldCustomerNumber"
                                                ValidationGroup="Registration" />&nbsp;&nbsp;
                                            <telerik:RadTextBox runat="server" ID="txtRegAccountName" WrapperCssClass="inlineblock"
                                                EmptyMessage="Ex. ABC Agency" Label="Organization" Width="200px" MaxLength="60"
                                                ToolTip="<ul><li>Organization Name is Required</li><li>Must not exceed 60 characters</li></ul>" />
                                            <asp:CustomValidator ID="cvRegAccountName" runat="server" Display="None" ValidateEmptyText="true"
                                                ControlToValidate="txtRegAccountName" ClientValidationFunction="RequiredField"
                                                ValidationGroup="Registration" />&nbsp;&nbsp;
                                            <asp:Button ID="btnRegister" runat="server" Text="Register" OnClick="btnRegister_Click"
                                                ValidationGroup="Registration" Style="display: inline-block;" />
                                        </div>
                                    </div>
                                    <fieldset style="width: 85%;">
                                        <legend>Enter Address</legend>
                                        <telerik:RadTextBox runat="server" ID="txtAddress1" WrapperCssClass="inlineblock"
                                            EmptyMessage="Ex. 123 Street" MaxLength="60" Label="Address 1" Width="250px"
                                            ToolTip="<ul><li>Address 1 is Required</li><li>Must not exceed 60 characters</li></ul>" />
                                        <asp:CustomValidator ID="cvAddress1" runat="server" Display="None" ValidateEmptyText="true"
                                            ControlToValidate="txtAddress1" ClientValidationFunction="RequiredField" ValidationGroup="Registration" />&nbsp;&nbsp;&nbsp;
                                        <telerik:RadTextBox runat="server" ID="txtAddress2" WrapperCssClass="inlineblock"
                                            EmptyMessage="Ex. Suite 123" MaxLength="60" Label="Address 2" Width="250px" ToolTip="<ul><li>Must not exceed 60 characters</li></ul>" />
                                        <br />
                                        <br />
                                        <telerik:RadTextBox runat="server" ID="txtCity" WrapperCssClass="inlineblock" EmptyMessage="Ex. ABC City"
                                            Label="City" Width="200px" MaxLength="45" ToolTip="<ul><li>City is Required</li><li>Must not exceed 45 characters</li></ul>" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;State
                                        <asp:CustomValidator ID="cvCity" runat="server" Display="None" ValidateEmptyText="true"
                                            ControlToValidate="txtCity" ClientValidationFunction="RequiredField" ValidationGroup="Registration" />
                                        <asp:CustomValidator ID="cvState" runat="server" Display="None" ValidateEmptyText="true"
                                            ControlToValidate="ddlState" ClientValidationFunction="RequiredFieldComboBox"
                                            ValidationGroup="Registration" />
                                        <telerik:RadComboBox ID="ddlState" runat="server" ExpandDirection="Down" Width="100px"
                                            ToolTip="<ul><li>Select State</li></ul>">
                                            <Items>
                                                <telerik:RadComboBoxItem Value="0" Text="--Select--" />
                                                <telerik:RadComboBoxItem Value="AK" Text="AK" />
                                                <telerik:RadComboBoxItem Value="AL" Text="AL" />
                                                <telerik:RadComboBoxItem Value="AP" Text="AP" />
                                                <telerik:RadComboBoxItem Value="AR" Text="AR" />
                                                <telerik:RadComboBoxItem Value="AZ" Text="AZ" />
                                                <telerik:RadComboBoxItem Value="CA" Text="CA" />
                                                <telerik:RadComboBoxItem Value="CO" Text="CO" />
                                                <telerik:RadComboBoxItem Value="CT" Text="CT" />
                                                <telerik:RadComboBoxItem Value="DE" Text="DE" />
                                                <telerik:RadComboBoxItem Value="DC" Text="DC" />
                                                <telerik:RadComboBoxItem Value="FL" Text="FL" />
                                                <telerik:RadComboBoxItem Value="GA" Text="GA" />
                                                <telerik:RadComboBoxItem Value="HI" Text="HI" />
                                                <telerik:RadComboBoxItem Value="ID" Text="ID" />
                                                <telerik:RadComboBoxItem Value="IL" Text="IL" />
                                                <telerik:RadComboBoxItem Value="IN" Text="IN" />
                                                <telerik:RadComboBoxItem Value="IA" Text="IA" />
                                                <telerik:RadComboBoxItem Value="KS" Text="KS" />
                                                <telerik:RadComboBoxItem Value="KY" Text="KY" />
                                                <telerik:RadComboBoxItem Value="LA" Text="LA" />
                                                <telerik:RadComboBoxItem Value="ME" Text="ME" />
                                                <telerik:RadComboBoxItem Value="MD" Text="MD" />
                                                <telerik:RadComboBoxItem Value="MA" Text="MA" />
                                                <telerik:RadComboBoxItem Value="MI" Text="MI" />
                                                <telerik:RadComboBoxItem Value="MN" Text="MN" />
                                                <telerik:RadComboBoxItem Value="MS" Text="MS" />
                                                <telerik:RadComboBoxItem Value="MO" Text="MO" />
                                                <telerik:RadComboBoxItem Value="MT" Text="MT" />
                                                <telerik:RadComboBoxItem Value="NE" Text="NE" />
                                                <telerik:RadComboBoxItem Value="NV" Text="NV" />
                                                <telerik:RadComboBoxItem Value="NH" Text="NH" />
                                                <telerik:RadComboBoxItem Value="NJ" Text="NJ" />
                                                <telerik:RadComboBoxItem Value="NM" Text="NM" />
                                                <telerik:RadComboBoxItem Value="NY" Text="NY" />
                                                <telerik:RadComboBoxItem Value="NC" Text="NC" />
                                                <telerik:RadComboBoxItem Value="ND" Text="ND" />
                                                <telerik:RadComboBoxItem Value="OH" Text="OH" />
                                                <telerik:RadComboBoxItem Value="OK" Text="OK" />
                                                <telerik:RadComboBoxItem Value="OR" Text="OR" />
                                                <telerik:RadComboBoxItem Value="PA" Text="PA" />
                                                <telerik:RadComboBoxItem Value="PR" Text="PR" />
                                                <telerik:RadComboBoxItem Value="RI" Text="RI" />
                                                <telerik:RadComboBoxItem Value="SC" Text="SC" />
                                                <telerik:RadComboBoxItem Value="SD" Text="SD" />
                                                <telerik:RadComboBoxItem Value="TN" Text="TN" />
                                                <telerik:RadComboBoxItem Value="TX" Text="TX" />
                                                <telerik:RadComboBoxItem Value="UT" Text="UT" />
                                                <telerik:RadComboBoxItem Value="VT" Text="VT" />
                                                <telerik:RadComboBoxItem Value="VA" Text="VA" />
                                                <telerik:RadComboBoxItem Value="WA" Text="WA" />
                                                <telerik:RadComboBoxItem Value="WV" Text="WV" />
                                                <telerik:RadComboBoxItem Value="WI" Text="WI" />
                                                <telerik:RadComboBoxItem Value="WY" Text="WY" />
                                            </Items>
                                        </telerik:RadComboBox>
                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        <telerik:RadTextBox runat="server" ID="txtZipCode" WrapperCssClass="inlineblock"
                                            EmptyMessage="Ex. 12345" Label="Zip Code" Width="150px" MaxLength="5" ToolTip="<ul><li>Zip Code is Required</li><li>Enter digit only</li><li>Must be exactly 5 digits</li></ul>">
                                            <ClientEvents OnKeyPress="IntegersOnly" />
                                        </telerik:RadTextBox>
                                        <asp:CustomValidator ID="cvZipCode" runat="server" Display="None" ValidateEmptyText="true"
                                            ControlToValidate="txtZipCode" ClientValidationFunction="ZipCode" ValidationGroup="Registration" />
                                    </fieldset>
                                </div>
                            </ContentTemplate>
                        </telerik:RadDock>
                    </telerik:RadDockZone>
                </div>
                <div style="float: right; width: 30%;">
                    <telerik:RadDockZone runat="server" ID="rdzCart" Orientation="vertical" SkinID="Cart">
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
                                                            ALC:
                                                            <%# Eval("ALC")%>&nbsp; Account Code:
                                                            <%# Eval("AccountCode")%>&nbsp; Address Code:
                                                            <%# Eval("AddressCode")%></div>
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
                                                            ALC:
                                                            <%# Eval("ALC")%>&nbsp; Account Code:
                                                            <%# Eval("AccountCode")%>&nbsp; Address Code:
                                                            <%# Eval("AddressCode")%></div>
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
                                        DataKeyNames="Name,ALC,AccountCode,Address1,Address2,City,State,ZipCode">
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
                                                        <div class="content" id="div<%# Eval("ALC").ToString().Replace("N/A", string.Empty) %><%# Eval("AccountCode").ToString().Replace("N/A", string.Empty) %><%# Eval("Name").ToString().Replace(" ", string.Empty) %>">
                                                            <%# string.IsNullOrEmpty(Eval("ALC").ToString())? string.Empty : "ALC: "+Eval("ALC") %>
                                                            <%# Eval("AccountCode") == null ? string.Empty : "Account Code: " + Eval("AccountCode")%>
                                                            <br />
                                                            <span style="font-style: italic;">
                                                                <%# Eval("Address1")%>,&nbsp;<%# string.IsNullOrEmpty(Eval("Address2").ToString())? string.Empty : Eval("Address2") + ","%><%# Eval("City")%>,&nbsp;<%# Eval("State")%>-
                                                                <%# Eval("ZipCode")%></span></div>
                                                        <a href="#" class="details" id="<%# Eval("ALC").ToString().Replace("N/A", string.Empty) %><%# Eval("AccountCode").ToString().Replace("N/A", string.Empty) %><%# Eval("Name").ToString().Replace(" ", string.Empty) %>">
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
                                                        <div class="content" id="div<%# Eval("ALC").ToString().Replace("N/A", string.Empty) %><%# Eval("AccountCode").ToString().Replace("N/A", string.Empty) %><%# Eval("Name").ToString().Replace(" ", string.Empty) %>">
                                                            <%# string.IsNullOrEmpty(Eval("ALC").ToString())? string.Empty : "ALC: "+Eval("ALC") %>
                                                            <%# Eval("AccountCode") == null ? string.Empty : "Account Code: " + Eval("AccountCode")%>
                                                            <br />
                                                            <span style="font-style: italic;">
                                                                <%# Eval("Address1")%>,&nbsp;<%# string.IsNullOrEmpty(Eval("Address2").ToString())? string.Empty : Eval("Address2") + ","%><%# Eval("City")%>,&nbsp;<%# Eval("State")%>-
                                                                <%# Eval("ZipCode")%></span></div>
                                                        <a href="#" class="details" id="<%# Eval("ALC").ToString().Replace("N/A", string.Empty) %><%# Eval("AccountCode").ToString().Replace("N/A", string.Empty) %><%# Eval("Name").ToString().Replace(" ", string.Empty) %>">
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
                                        PostBackUrl="~/Customer/Step2.aspx" />
                                </div>
                            </ContentTemplate>
                        </telerik:RadDock>
                    </telerik:RadDockZone>
                </div>
            </div>
            <telerik:RadAjaxManager ID="RadAjaxManager1" Style="display: none;" runat="server"
                OnAjaxRequest="RadAjaxManager1_AjaxRequest">
                <AjaxSettings>
                    <telerik:AjaxSetting AjaxControlID="RadAjaxManager1">
                        <UpdatedControls>
                            <telerik:AjaxUpdatedControl ControlID="lvAccessAccounts"></telerik:AjaxUpdatedControl>
                        </UpdatedControls>
                    </telerik:AjaxSetting>
                    <telerik:AjaxSetting AjaxControlID="lvAccessAccounts">
                        <UpdatedControls>
                            <telerik:AjaxUpdatedControl ControlID="lvAccessAccounts"></telerik:AjaxUpdatedControl>
                        </UpdatedControls>
                    </telerik:AjaxSetting>
                </AjaxSettings>
            </telerik:RadAjaxManager>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
