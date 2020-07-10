<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="Admin.aspx.cs" Inherits="Admin" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="Server">
    <script src="Scripts/core.js" type="text/javascript"></script>
    <script language="javascript" type="text/javascript">

        function ValidateForm(sender, args) {
            var requesttype = $find('<%=ddlType.ClientID %>');
            var inputArea = requesttype.get_inputDomElement();
            //            var requesttype = ddlrequesttype.options[ddlrequesttype.selectedIndex];
            var fromdate = $find("<%= txtFromDate.ClientID %>");
            var todate = $find("<%= txtToDate.ClientID %>");
            var firstname = $find("<%= txtFirstName.ClientID %>");
            var lastname = $find("<%= txtLastName.ClientID %>");
            var email = $find("<%= txtEmailAddress.ClientID %>");
            var confirmation = $find("<%= txtConfirmation.ClientID %>");

            if (fromdate.get_selectedDate() == null && todate.get_selectedDate() == null && requesttype.get_value() == "0" && firstname.get_value().length == 0 && lastname.get_value().length == 0 &&
                email.get_value().length == 0 && confirmation.get_value().length == 0) {
                fromdate.get_dateInput()._invalid = todate.get_dateInput()._invalid = firstname._invalid = lastname._invalid = email._invalid = confirmation._invalid = true;
                inputArea.style.backgroundColor = "#FFD9D9"
                args.IsValid = false;
            }
            else {
                fromdate.get_dateInput()._invalid = todate.get_dateInput()._invalid = firstname._invalid = lastname._invalid = email._invalid = confirmation._invalid = false;
                inputArea.style.backgroundColor = "#FFFFFF"
                args.IsValid = true;
            }
            fromdate.get_dateInput().updateCssClass();
            todate.get_dateInput().updateCssClass();
            firstname.updateCssClass();
            lastname.updateCssClass();
            email.updateCssClass();
            confirmation.updateCssClass();
        }

        function ClearForm(sender, args) {
            args.IsValid = true;
            var requesttype = $find('<%=ddlType.ClientID %>');
            var inputArea = requesttype.get_inputDomElement();
            //            var fromdate = $find("<%= txtFromDate.ClientID %>");
            //            var todate = $find("<%= txtToDate.ClientID %>");
            var firstname = $find("<%= txtFirstName.ClientID %>");
            var lastname = $find("<%= txtLastName.ClientID %>");
            var email = $find("<%= txtEmailAddress.ClientID %>");
            var confirmation = $find("<%= txtConfirmation.ClientID %>");
            firstname.set_value("");
            requesttype.set_value(0);
            lastname.set_value("");
            email.set_value("");
            confirmation.set_value("");

            //            fromdate.get_dateInput()._invalid = todate.get_dateInput()._invalid = 
            firstname._invalid = lastname._invalid = email._invalid = confirmation._invalid = false;
            inputArea.style.backgroundColor = "#FFFFFF"
            //            fromdate.get_dateInput().updateCssClass();
            //            todate.get_dateInput().updateCssClass();
            firstname.updateCssClass();
            lastname.updateCssClass();
            email.updateCssClass();
            confirmation.updateCssClass();
        }

        function mngRequestStarted(sender, args) {
            if (args.get_eventTarget().indexOf("ExportToExcelButton") >= 0 ||
                    args.get_eventTarget().indexOf("ExportToWordButton") >= 0 ||
                    args.get_eventTarget().indexOf("ExportToCsvButton") >= 0 ||
                    args.get_eventTarget().indexOf("ExportToPdfButton") >= 0) {
                args.set_enableAjax(false);
            }
        }
    </script>
    <telerik:RadScriptBlock ID="RadCodeBlock1" runat="server">
        <script language="javascript" type="text/javascript">
            function ShowEditForm(id) {
                var grid = $find("<%= gvResults.ClientID %>");
                var rowControl = grid.get_masterTableView().get_dataItems()[rowIndex].get_element();
                grid.get_masterTableView().selectItem(rowControl, true);
                window.radopen("AdminDetails.aspx?ID=" + id, "rwRequestDetails");
                return false;
            }
        </script>
    </telerik:RadScriptBlock>
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <ClientEvents OnRequestStart="mngRequestStarted" />
    </telerik:RadAjaxManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Always">
        <ContentTemplate>
            <telerik:RadToolTipManager ID="RadToolTipManager1" runat="server" SkinID="AutoToolTip" />
            <telerik:RadWindowManager ID="rwmRequestDetails" runat="server" EnableShadow="true"
                Modal="true" EnableViewState="false" Behaviors="Close" Animation="Fade" VisibleStatusbar="false">
                <Windows>
                    <telerik:RadWindow ID="rwRequestDetails" runat="server" Title="Accounts Details"
                        Height="520px" Width="100%" Left="150px" ReloadOnShow="true" ShowContentDuringLoad="false"
                        Behaviors="Maximize">
                    </telerik:RadWindow>
                </Windows>
            </telerik:RadWindowManager>
            <div style="width: 100%; margin-bottom: 20px;">
                <div style="float: left; text-align: center;">
                    <asp:CustomValidator ID="cvValidate" runat="server" Display="Dynamic" ErrorMessage="Please provide atleast one search criteria"
                        ValidateEmptyText="true" ClientValidationFunction="ValidateForm" ValidationGroup="Submit"
                        SkinID="Error" />
                    <asp:CustomValidator ID="cvClearForm" runat="server" Display="None" ValidateEmptyText="true"
                        ClientValidationFunction="ClearForm" ValidationGroup="Clear" />
                </div>
                <div style="float: right;">
                    <asp:LoginView ID="LoginView" runat="server" EnableViewState="false">
                        <LoggedInTemplate>
                            <span>Welcome
                                <asp:LoginName ID="HeadLoginName" runat="server" />
                                !</span>
                            <asp:LoginStatus ID="HeadLoginStatus" runat="server" Style="padding-left: 10px;"
                                LogoutAction="Redirect" LogoutText="Logout" LogoutPageUrl="~/" />
                        </LoggedInTemplate>
                    </asp:LoginView>
                </div>
            </div>
            <div style="width: 100%; padding: 10px 5px 10px 45px;">
                <table>
                    <tr>
                        <td width="33%" style="padding-right: 25px;">
                            From Date :
                            <telerik:RadDatePicker ID="txtFromDate" runat="server" MinDate="2011-08-01" Width="200px"
                                ToolTip="<ul><li>Pick From date</li></ul>" DateInput-DateFormat="MM/dd/yyyy" />
                        </td>
                        <td width="33%" style="padding-right: 25px;">
                            To Date :
                            <telerik:RadDatePicker ID="txtToDate" runat="server" MinDate="2011-08-01" Width="200px"
                                ToolTip="<ul><li>Pick To date</li></ul>" DateInput-DateFormat="MM/dd/yyyy" />
                        </td>
                        <td width="33%" style="padding-right: 25px;">
                            Request Type :
                            <telerik:RadComboBox ID="ddlType" runat="server" ValidationGroup="Submit">
                                <Items>
                                    <telerik:RadComboBoxItem Value="0" Text="--Select--" />
                                    <telerik:RadComboBoxItem Value="VR" Text="VR" />
                                    <telerik:RadComboBoxItem Value="VA" Text="VA" />
                                    <telerik:RadComboBoxItem Value="CR" Text="CR" />
                                    <telerik:RadComboBoxItem Value="CA" Text="CA" />
                                </Items>
                            </telerik:RadComboBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <telerik:RadTextBox runat="server" ID="txtFirstName" EmptyMessage="Ex. John" Label="First Name :"
                                MaxLength="25" ToolTip="<ul><li>Enter alphanumeric characters only</li></ul>"
                                Width="250px" ValidationGroup="Submit">
                                <ClientEvents OnKeyPress="AlphabetsOnly" OnBlur="TitleCase" />
                            </telerik:RadTextBox>
                        </td>
                        <td>
                            <telerik:RadTextBox runat="server" ID="txtLastName" EmptyMessage="Ex. Smith" Label="Last Name :"
                                MaxLength="35" ToolTip="<ul><li>Enter alphanumeric characters only</li></ul>"
                                Width="250px" ValidationGroup="Submit">
                                <ClientEvents OnKeyPress="AlphabetsOnly" OnBlur="TitleCase" />
                            </telerik:RadTextBox>
                        </td>
                        <td>
                            <telerik:RadTextBox runat="server" ID="txtConfirmation" EmptyMessage="Ex. CA001234"
                                Label="Confirmation :" MaxLength="8" ToolTip="<ul><li>Enter alphanumeric characters only</li></ul>"
                                Width="250px" ValidationGroup="Submit">
                                <ClientEvents OnKeyPress="AlphaNumericOnly" />
                            </telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <telerik:RadTextBox runat="server" ID="txtEmailAddress" EmptyMessage="Ex. john.smith@domain.com"
                                Label="Email Address:" MaxLength="60" ToolTip="<ul><li>Enter valid Email</li></ul>"
                                Width="250px" ValidationGroup="Submit">
                                <ClientEvents OnKeyPress="EmailCharactersOnly" />
                            </telerik:RadTextBox>
                        </td>
                        <td>
                        </td>
                        <td>
                        </td>
                    </tr>
                </table>
            </div>
            <br />
            <div style="text-align: center;">
                <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click"
                    ValidationGroup="Submit" Width="100px" />&nbsp;
                <asp:Button ID="btnClear" runat="server" Text="Clear" UseSubmitBehavior="false" ValidationGroup="Clear"
                    Width="100px" />
            </div>
            <br />
            <br />
            <div style="width: 80%; margin: 0px auto 90px auto;">
                <telerik:RadGrid ID="gvResults" runat="server" AutoGenerateColumns="False" ShowFooter="True"
                    GridLines="Both" OnDetailTableDataBind="gvResults_DetailTableDataBind"
                    AllowSorting="True" Visible="false" AllowPaging="True" PageSize="15" OnItemCommand="gvResults_ItemCommand"
                    OnItemCreated="gvResults_ItemCreated">
                    <MasterTableView Name="RequestDetails" DataKeyNames="RQTID">
                        <NestedViewSettings DataSourceID="odsSearchDetails">
                            <ParentTableRelation>
                                <telerik:GridRelationFields DetailKeyField="RQTID" MasterKeyField="RQTID"></telerik:GridRelationFields>
                            </ParentTableRelation>
                        </NestedViewSettings>
                        <%--<NestedViewTemplate>
                            <telerik:RadListView ID="lvAccessAccounts" runat="server" ItemPlaceholderID="EmployeesContainer">
                                <LayoutTemplate>
                                    <fieldset>
                                        <legend>Request Details</legend>
                                        <asp:PlaceHolder ID="EmployeesContainer" runat="server"></asp:PlaceHolder>
                                    </fieldset>
                                </LayoutTemplate>
                                <ItemTemplate>
                                    <fieldset style="float: left; width: 420px;">
                                        <legend>Account Details</legend>
                                        <table cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td colspan="2" style="font-weight: bold;">
                                                    DUNS/BPN:
                                                    <%#Eval("DBNUM")%>
                                                    DUNS+4/BPN+4:
                                                    <%#Eval("DBNUM4")%>
                                                    ALC:
                                                    <%#Eval("ALC")%>
                                                    Account Code:
                                                    <%#Eval("ACT_CDE")%>
                                                    Adddress Code:
                                                    <%#Eval("ADR_CDE")%>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" style="font-weight: bold;">
                                                    Agency/Company :
                                                    <%#Eval("CMPY")%>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" style="font-weight: bold;">
                                                    Address :
                                                    <%# Eval("ADDR1")%>,&nbsp;<%# string.IsNullOrEmpty(Eval("ADDR2").ToString())? string.Empty : Eval("ADDR2") + ","%><%# Eval("CTY")%>,&nbsp;<%# Eval("STE")%>-
                                                    <%# Eval("ZIP")%>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 25%">
                                                    Name:
                                                </td>
                                                <td style="width: 50%">
                                                    <%#Eval("ADMN")%>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    Email Address:
                                                </td>
                                                <td>
                                                    <%#Eval("ADMEML")%>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    Phone Number:
                                                </td>
                                                <td>
                                                    <%# Eval("ADMPHNUM")%>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    Non US Phone Number:
                                                </td>
                                                <td>
                                                    <%# Eval("ADMNPHNUM")%>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    Fax Number:
                                                </td>
                                                <td>
                                                    <%#Eval("ADMFXNUM")%>
                                                </td>
                                            </tr>
                                        </table>
                                    </fieldset>
                                </ItemTemplate>
                            </telerik:RadListView>
                        </NestedViewTemplate>--%>
                        <DetailTables>
                            <telerik:GridTableView Name="RequestDetails" AutoGenerateColumns="false" DataKeyNames="ACTID"
                                GridLines="Both" DataSourceID="odsSearchDetails" Width="100%" runat="server">
                                <ParentTableRelation>
                                    <telerik:GridRelationFields DetailKeyField="RQTID" MasterKeyField="RQTID"></telerik:GridRelationFields>
                                </ParentTableRelation>
                                <Columns>
                                    <telerik:GridBoundColumn DataField="ACTTYPE" HeaderText="Account Type" UniqueName="ACTTYPE"
                                        ItemStyle-HorizontalAlign="Center" />
                                    <telerik:GridBoundColumn DataField="DBNUM" HeaderText="DUNS/BPN" UniqueName="DBNUM" />
                                    <telerik:GridBoundColumn DataField="DBNUM4" HeaderText="DUNS+4/BPN+4" UniqueName="DBNUM4" />
                                    <telerik:GridBoundColumn DataField="ALC" HeaderText="ALC" UniqueName="ALC" />
                                    <telerik:GridBoundColumn DataField="ACT_CDE" HeaderText="Account Code" UniqueName="ACT_CDE"
                                        ItemStyle-HorizontalAlign="Center" />
                                    <telerik:GridBoundColumn DataField="ACR_CDE" HeaderText="Address Code" UniqueName="ACR_CDE"
                                        ItemStyle-HorizontalAlign="Center" />
                                    <telerik:GridBoundColumn DataField="CMPY" HeaderText="Name" UniqueName="CMPY" />
                                    <telerik:GridBoundColumn DataField="ADMN" HeaderText="Administrator Name" UniqueName="ADMN" />
                                    <telerik:GridBoundColumn DataField="ADMEML" HeaderText="Administrator Email" UniqueName="ADMEML" />
                                    <telerik:GridBoundColumn DataField="ADMPHNM" HeaderText="Administrator Phone" UniqueName="ADMPHNM" />
                                    <telerik:GridBoundColumn DataField="ADMNPHNM" HeaderText="Administrator Non US Phone"
                                        UniqueName="ADMNPHNM" ItemStyle-HorizontalAlign="Center" />
                                    <telerik:GridBoundColumn DataField="ADMFXNM" HeaderText="Administrator Fax" UniqueName="ADMFXNM"
                                        ItemStyle-HorizontalAlign="Center" />
                                    <telerik:GridBoundColumn DataField="ADDR1" HeaderText="Address Line 1" UniqueName="ADDR1" />
                                    <telerik:GridBoundColumn DataField="ADDR2" HeaderText="Address Line 2" UniqueName="ADDR2" />
                                    <telerik:GridBoundColumn DataField="CTY" HeaderText="City" UniqueName="CTY" />
                                    <telerik:GridBoundColumn DataField="STE" HeaderText="State" UniqueName="STE" />
                                    <telerik:GridBoundColumn DataField="ZIP" HeaderText="Zip Code" UniqueName="ZIP" />
                                </Columns>
                            </telerik:GridTableView>
                        </DetailTables>
                        <Columns>
                            <telerik:GridBoundColumn DataField="RQTID" HeaderText="Request ID" UniqueName="RQTID"
                                ItemStyle-HorizontalAlign="Center" />
                            <telerik:GridBoundColumn DataField="RQTTYP" HeaderText="Request Type" UniqueName="RQTTYP"
                                ItemStyle-HorizontalAlign="Center" />
                            <telerik:GridBoundColumn DataField="SBRFTNM" HeaderText="First Name" UniqueName="SBRFTNM" />
                            <telerik:GridBoundColumn DataField="SBRLTNM" HeaderText="Last Name" UniqueName="SBRLTNM" />
                            <telerik:GridBoundColumn DataField="SBREML" HeaderText="Email Address" UniqueName="SBREML" />
                            <telerik:GridBoundColumn DataField="SBRPHNM" HeaderText="Phone Number" UniqueName="SBRPHNM"
                                ItemStyle-HorizontalAlign="Center" />
                            <telerik:GridBoundColumn DataField="CTDON" HeaderText="Date" UniqueName="CTDON" ItemStyle-HorizontalAlign="Center" />
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </div>
            <asp:ObjectDataSource ID="odsSearchResults" runat="server" SelectMethod="GetRequests"
                TypeName="DataAccess" OnSelecting="odsSearchResults_Selecting">
                <SelectParameters>
                    <asp:Parameter Name="fromdate" Type="String" />
                    <asp:Parameter Name="todate" Type="String" />
                    <asp:ControlParameter ControlID="txtConfirmation" Name="requestid" PropertyName="Text"
                        Type="String" />
                    <asp:ControlParameter ControlID="ddlType" Name="requesttype" PropertyName="SelectedValue"
                        Type="String" />
                    <asp:ControlParameter ControlID="txtFirstName" Name="firstname" PropertyName="Text"
                        Type="String" />
                    <asp:ControlParameter ControlID="txtLastName" Name="lastname" PropertyName="Text"
                        Type="String" />
                </SelectParameters>
            </asp:ObjectDataSource>
            <asp:ObjectDataSource ID="odsSearchDetails" runat="server" SelectMethod="GetRequestDetails"
                TypeName="DataAccess">
                <SelectParameters>
                    <asp:Parameter Name="fromdate" Type="String" />
                    <asp:Parameter Name="todate" Type="String" />
                    <asp:SessionParameter Name="requestid" SessionField="RQTID" Type="String"></asp:SessionParameter>
                    <asp:Parameter Name="requesttype" Type="String" />
                    <asp:Parameter Name="firstname" Type="String" />
                    <asp:Parameter Name="lastname" Type="String" />
                    <asp:Parameter Name="company" Type="String" />
                    <asp:Parameter Name="email" Type="String" />
                    <asp:Parameter Name="duns" Type="String" />
                    <asp:Parameter Name="duns4" Type="String" />
                    <asp:Parameter Name="alc" Type="String" />
                    <asp:Parameter Name="accountcode" Type="String" />
                    <asp:Parameter Name="addresscode" Type="String" />
                    <asp:Parameter Name="addr1" Type="String" />
                    <asp:Parameter Name="addr2" Type="String" />
                    <asp:Parameter Name="city" Type="String" />
                    <asp:Parameter Name="state" Type="String" />
                    <asp:Parameter Name="zipcode" Type="String" />
                    <asp:Parameter Name="regid" Type="String" />
                </SelectParameters>
            </asp:ObjectDataSource>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
