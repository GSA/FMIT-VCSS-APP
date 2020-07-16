<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="Step2.aspx.cs" Inherits="Customer_Step2" %>

<%@ PreviousPageType VirtualPath="~/Customer/Step1.aspx" %>
<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <script src="../Scripts/core.js" type="text/javascript"></script>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Always">
        <ContentTemplate>
            <table id="progress">
                <tr>
                    <td class="previous">
                        <asp:LinkButton runat="server" ID="lnkStep1" Text="New Requests" PostBackUrl="~/Customer/Step1.aspx" />
                    </td>
                    <td class="current">
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
                <div style="float: left; width: 70%; vertical-align: top;">
                    <telerik:RadDockZone runat="server" ID="rdzAccessRequest" SkinID="Main" Visible="false"
                        CssClass="marginB20">
                        <telerik:RadDock runat="server" ID="rdkAccessRequest" Title="<b>Access Requests</b>">
                            <ContentTemplate>
                                <div style="padding: 10px 0px 10px 0px;">
                                    <telerik:RadListView ID="lvAccessAccounts" runat="server" OnItemCommand="lvAccessAccounts_ItemCommand"
                                        DataKeyNames="RegistrationNumber,AccountCode,AddressCode">
                                        <LayoutTemplate>
                                            <table class="SearchTable" width="100%">
                                                <thead>
                                                    <tr>
                                                        <th width="10%">
                                                            ALC
                                                        </th>
                                                        <th width="10%">
                                                            Account Code
                                                        </th>
                                                        <th width="10%">
                                                            Address Code
                                                        </th>
                                                        <th width="45%">
                                                            Organization
                                                        </th>
                                                        <th width="20%">
                                                            Account Administrator
                                                        </th>
                                                        <th width="5%">
                                                            Remove
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
                                                <td align="center">
                                                    <%# Eval("ALC")%>
                                                </td>
                                                <td align="center">
                                                    <%# Eval("AccountCode")%>
                                                </td>
                                                <td align="center">
                                                    <%# Eval("AddressCode")%>
                                                </td>
                                                <td>
                                                    <%# Eval("NAME")%>
                                                </td>
                                                <td style="text-align: center;">
                                                    <%# Eval("ADMINISTRATOR")%>
                                                </td>
                                                <td width="5%" align="center">
                                                    <asp:ImageButton runat="server" ID="imgRemove" CommandName="Remove" SkinID="Remove" />
                                                </td>
                                            </tr>
                                        </ItemTemplate>
                                        <AlternatingItemTemplate>
                                            <tr class="odd">
                                                <td align="center">
                                                    <%# Eval("ALC")%>
                                                </td>
                                                <td align="center">
                                                    <%# Eval("AccountCode")%>
                                                </td>
                                                <td align="center">
                                                    <%# Eval("AddressCode")%>
                                                </td>
                                                <td>
                                                    <%# Eval("NAME")%>
                                                </td>
                                                <td style="text-align: center;">
                                                    <%# Eval("ADMINISTRATOR")%>
                                                </td>
                                                <td align="center">
                                                    <asp:ImageButton runat="server" ID="imgRemove" CommandName="Remove" SkinID="Remove" />
                                                </td>
                                            </tr>
                                        </AlternatingItemTemplate>
                                    </telerik:RadListView>
                                </div>
                            </ContentTemplate>
                        </telerik:RadDock>
                    </telerik:RadDockZone>
                    <telerik:RadDockZone runat="server" ID="rdzRegistrationRequest" SkinID="Main" Visible="false">
                        <telerik:RadDock runat="server" ID="rdkRegistrationRequest" Title="<b>Registration Requests</b>">
                            <ContentTemplate>
                                <div style="padding: 10px 0px 10px 0px;">
                                    <telerik:RadListView ID="lvRegistrationAccounts" runat="server" OnItemCommand="lvRegistrationAccounts_ItemCommand"
                                        DataKeyNames="Name,ALC,AccountCode">
                                        <LayoutTemplate>
                                            <table class="SearchTable" width="100%">
                                                <thead>
                                                    <tr>
                                                        <th width="20%">
                                                            ALC
                                                        </th>
                                                        <th width="20%">
                                                            Account Code
                                                        </th>
                                                        <th>
                                                            Organization
                                                        </th>
                                                        <th width="10%">
                                                            Remove
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
                                                <td width="15%" align="center">
                                                    <%# Eval("ALC")%>
                                                </td>
                                                <td width="15%" align="center">
                                                    <%# Eval("AccountCode")%>
                                                </td>
                                                <td width="50%">
                                                    <%# Eval("Name")%>
                                                </td>
                                                <td width="5%" align="center">
                                                    <asp:ImageButton runat="server" ID="imgRemove" CommandName="Remove" SkinID="Remove" />
                                                </td>
                                            </tr>
                                        </ItemTemplate>
                                        <AlternatingItemTemplate>
                                            <tr class="odd">
                                                <td width="15%" align="center">
                                                    <%# Eval("ALC")%>
                                                </td>
                                                <td width="15%" align="center">
                                                    <%# Eval("AccountCode")%>
                                                </td>
                                                <td width="50%">
                                                    <%# Eval("Name")%>
                                                </td>
                                                <td width="5%" align="center">
                                                    <asp:ImageButton runat="server" ID="imgRemove" CommandName="Remove" SkinID="Remove" />
                                                </td>
                                            </tr>
                                        </AlternatingItemTemplate>
                                    </telerik:RadListView>
                                </div>
                            </ContentTemplate>
                        </telerik:RadDock>
                    </telerik:RadDockZone>
                </div>
                <div style="float: right; width: 30%;">
                    <telerik:RadDockZone runat="server" ID="rdzUserInfo" Orientation="vertical" Style="border: 0px;">
                        <telerik:RadDock runat="server" ID="rdkUserInfo" Title="User Information" EnableAnimation="true"
                            DockHandle="TitleBar" DockMode="Docked" DefaultCommands="None">
                            <ContentTemplate>
                                <div style="padding-bottom: 10px; padding-top: 10px;">
                                    <telerik:RadTextBox runat="server" ID="txtFirstName" EmptyMessage="Enter First Name"
                                        InputType="Text" CausesValidation="true" MaxLength="25" AutoCompleteType="FirstName"
                                        Width="97%" ToolTip="<ul><li>First Name is required</li><li>Enter Alphabets only</li><li>Must not exceed 25 characters</li></ul>">
                                        <ClientEvents OnKeyPress="AlphabetsOnly" OnBlur="TitleCase" />
                                    </telerik:RadTextBox>
                                    <asp:CustomValidator ID="cvFirstName" runat="server" Display="None" ValidateEmptyText="true"
                                        ControlToValidate="txtFirstName" ClientValidationFunction="RequiredField" ValidationGroup="UserInfo" />
                                </div>
                                <div style="padding-bottom: 10px;">
                                    <telerik:RadTextBox runat="server" ID="txtLastName" EmptyMessage="Enter Last Name"
                                        InputType="Text" CausesValidation="true" MaxLength="35" AutoCompleteType="LastName"
                                        Width="97%" ToolTip="<ul><li>Last Name is required</li><li>Enter Alphabets only</li><li>Must not exceed 35 characters</li></ul>">
                                        <ClientEvents OnKeyPress="AlphabetsOnly" OnBlur="TitleCase" />
                                    </telerik:RadTextBox>
                                    <asp:CustomValidator ID="cvLastName" runat="server" Display="None" ValidateEmptyText="true"
                                        ControlToValidate="txtLastName" ClientValidationFunction="RequiredField " ValidationGroup="UserInfo" />
                                </div>
                                <div style="padding-bottom: 10px;">
                                    <telerik:RadTextBox runat="server" ID="txtEmailAddress" EmptyMessage="Enter Email Address"
                                        InputType="Text" CausesValidation="true" MaxLength="100" AutoCompleteType="Email"
                                        Width="97%" ToolTip="<ul><li>Email Address is required</li><li>Must not exceed 100 characters</li></ul>">
                                        <ClientEvents OnKeyPress="EmailCharactersOnly" />
                                    </telerik:RadTextBox>
                                    <asp:CustomValidator ID="cvEmailAddress" runat="server" Display="None" ValidateEmptyText="true"
                                        ControlToValidate="txtEmailAddress" ClientValidationFunction="RequiredEmail"
                                        ValidationGroup="UserInfo" />
                                </div>
                                <div style="padding-bottom: 10px;">
                                    <telerik:RadTextBox runat="server" ID="txtConfirmEmailAddress" EmptyMessage="Confirm Email Address"
                                        InputType="Text" CausesValidation="true" MaxLength="100" Width="97%" ToolTip="<ul><li>Confirm Email Address is required</li><li>Must match above email address</li></ul>">
                                        <ClientEvents OnKeyPress="EmailCharactersOnly" />
                                    </telerik:RadTextBox>
                                    <asp:CustomValidator ID="cvConfirmEmailAddress" runat="server" Display="None" ValidateEmptyText="true"
                                        ControlToValidate="txtConfirmEmailAddress" ClientValidationFunction="RequiredCompare"
                                        ValidationGroup="UserInfo" />
                                </div>
                                <div style="padding-bottom: 10px;">
                                    <telerik:RadMaskedTextBox runat="server" ID="txtPhoneNumber" Mask="(###) ###-####"
                                        CausesValidation="true" Label="Phone Number" Width="97%" ToolTip="<ul><li>Phone Number is required</li><li>Enter 10 digit Phone Number</li></ul>" />
                                    <asp:CustomValidator ID="cvPhoneNumber" runat="server" Display="None" ValidateEmptyText="true"
                                        ControlToValidate="txtPhoneNumber" ClientValidationFunction="RequiredPhoneNumber"
                                        ValidationGroup="UserInfo" />
                                </div>
                                <div style="padding-bottom: 10px;">
                                    <telerik:RadMaskedTextBox runat="server" ID="txtNonUSPhoneNumber" Mask="(###) ##-##########"
                                        CausesValidation="true" AutoCompleteType="BusinessPhone" Label="Non US Phone Number"
                                        Width="97%" ToolTip="<ul><li>Enter digits only</li></ul>" />
                                </div>
                                <div style="padding-bottom: 10px;">
                                    <telerik:RadMaskedTextBox runat="server" ID="txtFaxNumber" Mask="(###) ###-####"
                                        CausesValidation="true" AutoCompleteType="Pager" Label="Fax Number" Width="97%"
                                        ToolTip="<ul><li>Enter 10 digit Fax Number</li></ul>" />
                                    <asp:CustomValidator ID="cvFaxNumberFormat" runat="server" Display="None" ValidateEmptyText="true"
                                        ControlToValidate="txtFaxNumber" ClientValidationFunction="PhoneNumber" ValidationGroup="UserInfo" />
                                </div>
                                <asp:Button ID="btnContinue" runat="server" Text="Continue" PostBackUrl="~/Customer/Step3.aspx"
                                    OnClick="btnContinue_Click" ValidationGroup="UserInfo" />&nbsp;<asp:LinkButton runat="server"
                                        ID="lbtnBack" Text="Go back" PostBackUrl="~/Customer/Step1.aspx" />
                            </ContentTemplate>
                        </telerik:RadDock>
                    </telerik:RadDockZone>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
