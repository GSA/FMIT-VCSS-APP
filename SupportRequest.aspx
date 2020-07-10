<%@ page title="" language="C#" masterpagefile="~/Site.master" autoeventwireup="true" inherits="SupportRequest" CodeFile="SupportRequest.aspx.cs"  theme="Default" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <script src="Scripts/core.js" type="text/javascript"></script>
    <script type="text/javascript">
        function pageLoad() {
            var listbox = $find('<%=lbTopic.ClientID %>');

            if (listbox != null) {
                if (listbox.get_selectedItems().length > 0) {
                    var topic = listbox.get_selectedItem().get_value();
                }
            }

            if ($('#<%=rbtnAccountType.ClientID %>') != null) {
                var actType = $('#<%=rbtnAccountType.ClientID %> input:checked').val();
            }

            if (topic == "1") {

                $('#changeAdminType').show();

                if (actType == "C") { $('#custact').show(); }
                if (actType == "V") { $('#vendact').show(); }
            }
        }

        function ToggleControls() {
            var listbox = $find('<%=lbTopic.ClientID %>');

            if (listbox.get_selectedItems().length > 0) {
                var topic = listbox.get_selectedItem().get_value();
            }
            var lblMessage = $('#<%=lblNoAccountMessage.ClientID %>');

            if (lblMessage.is(":visible")) {
                lblMessage.hide();
            }
            var actType = $('#<%=rbtnAccountType.ClientID %> input:checked').val();
            var updateType = $('#<%=rbtnUpdateType.ClientID %> input:checked').val();

            if (topic == "1" || topic == "2") {

                if (topic == "1") {
                    $('#changeAdminType').show('fast');
                }
                else {
                    $('#changeAdminType').hide('fast');
                }
                
                $('#utype').hide('fast');
                $('#newemail').hide('fast');

                if (actType == "V") {
                    $('#custact').hide('fast');
                    $('#vendact').show('fast');
                }
                else if (actType == "C") {
                    $('#vendact').hide('fast');
                    $('#custact').show('fast');
                }
            }
            else if (topic == "3") {
                $('#utype').hide('fast');
                $('#vendact').hide('fast');
                $('#custact').hide('fast');
                $('#newemail').hide('fast');
                $('#changeAdminType').hide('fast');
            }
            else if (topic == "4") {
                $('#vendact').hide('fast');
                $('#custact').hide('fast');
                $('#utype').show('fast');
                $('#changeAdminType').hide('fast');

                if (updateType == "E")
                { $('#newemail').show('fast'); }
                else { $('#newemail').hide('fast'); }
            }
        }
    </script>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Always">
        <ContentTemplate>
            <telerik:RadToolTipManager ID="RadToolTipManager1" runat="server" SkinID="AutoToolTip" />
            <telerik:RadToolTip ID="tip" runat="server" TargetControlID="imgHelp" SkinID="HelpIcon"
                ToolTipZoneID="help">
                <asp:Xml ID="xmlToolTip" runat="server" DocumentSource="~/XmlDatasource/HelpToolTip.config"
                    TransformSource="~/XmlDatasource/HelpToolTip.xslt" />
            </telerik:RadToolTip>
            <div runat="server" id="srmain">
                <div style="padding-bottom: 5px;">
                    <b>Topic</b>&nbsp;<asp:CustomValidator ID="cvTopic" runat="server" Text="Select Topic"
                        ControlToValidate="lbTopic" ClientValidationFunction="RequiredFieldLSBX" ValidationGroup="SRRequest"
                        ValidateEmptyText="true" SkinID="Error" /></div>
                <div style="padding-bottom: 15px;">
                    <telerik:RadListBox runat="server" ID="lbTopic" Width="300px" OnClientSelectedIndexChanged="ToggleControls">
                        <Items>
                            <telerik:RadListBoxItem Text="--Select One--" Value="0" />
                            <telerik:RadListBoxItem runat="server" Text="Change Account Administrator" Value="1" />
                            <telerik:RadListBoxItem runat="server" Text="Remove Account Code/BOAC from User Profile" Value="2" />
                            <telerik:RadListBoxItem runat="server" Text="Separated User/Deactivate User Account" Value="3" />
                            <telerik:RadListBoxItem runat="server" Text="Update User Profile" Value="4" />
                        </Items>
                    </telerik:RadListBox>
                    &nbsp;<asp:Image runat="server" ID="imgHelp" SkinID="HelpIcon" />
                </div>
                 <div style="display: none;" id="changeAdminType">
                     <div style="padding-bottom: 5px;">
                        <b>Request type:</b></div>
                    <div style="padding-bottom: 15px;">
                        <asp:RadioButtonList ID="rbtnChangeAccountAdminType" runat="server" RepeatDirection="Horizontal"
                            RepeatLayout="Flow" OnClick="ToggleControls();">
                            <asp:ListItem Value="L">Account Administrator left</asp:ListItem>
                            <asp:ListItem Value="N">New Account Administrator</asp:ListItem>
                        </asp:RadioButtonList>
                        <asp:CustomValidator ID="cvChangeAccountAdminType" runat="server" Display="None" ControlToValidate="rbtnChangeAccountAdminType"
                            ClientValidationFunction="RequiredFieldRBTN" ValidationGroup="SRRequest" ValidateEmptyText="true" />
                    </div>
                </div>
                <div style="padding-bottom: 5px;">
                    <b>I am a:</b></div>
                <div style="padding-bottom: 15px;">
                    <asp:RadioButtonList ID="rbtnAccountType" runat="server" RepeatDirection="Horizontal"
                        RepeatLayout="Flow" OnClick="ToggleControls();">
                        <asp:ListItem Value="V">Vendor</asp:ListItem>
                        <asp:ListItem Value="C">Customer</asp:ListItem>
                    </asp:RadioButtonList>
                    <asp:CustomValidator ID="cvAccountType" runat="server" Display="None" ControlToValidate="rbtnAccountType"
                        ClientValidationFunction="RequiredFieldRBTN" ValidationGroup="SRRequest" ValidateEmptyText="true"
                        class="utype" />
                </div>
                <div style="display: none;" id="utype">
                    <div style="padding-bottom: 5px;">
                        <b>Update type:</b></div>
                    <div style="padding-bottom: 15px;">
                        <asp:RadioButtonList ID="rbtnUpdateType" runat="server" RepeatDirection="Horizontal"
                            RepeatLayout="Flow" OnClick="ToggleControls();">
                            <asp:ListItem Value="E">E-Mail</asp:ListItem>
                            <asp:ListItem Value="P">Phone</asp:ListItem>
                        </asp:RadioButtonList>
                        <asp:CustomValidator ID="cvUpdateType" runat="server" Display="None" ControlToValidate="rbtnUpdateType"
                            ClientValidationFunction="RequiredFieldRBTN" ValidationGroup="SRRequest" ValidateEmptyText="true" />
                    </div>
                </div>
                <div style="padding-bottom: 5px;">
                    <b>Name</b></div>
                <div style="padding-bottom: 15px;">
                    <telerik:RadTextBox runat="server" ID="txtFirstName" EmptyMessage="Enter First Name"
                        InputType="Text" CausesValidation="true" AutoCompleteType="FirstName" ToolTip="<ul><li>First Name is required</li><li>Enter Alphabets only</li></ul>">
                        <ClientEvents OnKeyPress="AlphabetsOnly" OnBlur="TitleCase" />
                    </telerik:RadTextBox>
                    <telerik:RadTextBox runat="server" ID="txtLastName" EmptyMessage="Enter Last Name"
                        InputType="Text" CausesValidation="true" AutoCompleteType="LastName" ToolTip="<ul><li>Last Name is required</li><li>Enter Alphabets only</li></ul>">
                        <ClientEvents OnKeyPress="AlphabetsOnly" OnBlur="TitleCase" />
                    </telerik:RadTextBox>
                    <asp:CustomValidator ID="cvFirstName" runat="server" Display="None" ValidateEmptyText="true"
                        ControlToValidate="txtFirstName" ClientValidationFunction="RequiredField" ValidationGroup="SRRequest" />
                    <asp:CustomValidator ID="cvLastName" runat="server" Display="None" ValidateEmptyText="true"
                        ControlToValidate="txtLastName" ClientValidationFunction="RequiredField " ValidationGroup="SRRequest" />
                </div>
                <div style="padding-bottom: 5px;">
                    <b>Email</b></div>
                <div style="padding-bottom: 15px;">
                    <telerik:RadTextBox runat="server" ID="txtEmailAddress" EmptyMessage="email@domain.com"
                        MaxLength="60" Width="200px" ToolTip="<ul><li>Email is required</li></ul>">
                        <ClientEvents OnKeyPress="EmailCharactersOnly" />
                    </telerik:RadTextBox>
                    <asp:CustomValidator ID="cvEmailAddress" runat="server" Display="None" ValidateEmptyText="true"
                        ControlToValidate="txtEmailAddress" ClientValidationFunction="RequiredEmail"
                        ValidationGroup="SRRequest" />
                </div>
                <div style="display: none;" id="newemail">
                    <div style="padding-bottom: 5px;">
                        <b>New Email</b></div>
                    <div style="padding-bottom: 15px;">
                        <telerik:RadTextBox runat="server" ID="txtUpdatedEmail" EmptyMessage="email@domain.com"
                            MaxLength="60" Width="200px" ToolTip="<ul><li>Email is required</li><li>Should be different from the previous one</li></ul>">
                            <ClientEvents OnKeyPress="EmailCharactersOnly" />
                        </telerik:RadTextBox>
                        <asp:CustomValidator ID="cvUpdatedEmail" runat="server" Display="None" ValidateEmptyText="true"
                            ControlToValidate="txtUpdatedEmail" ClientValidationFunction="RequiredEmail"
                            ValidationGroup="SRRequest" />
                    </div>
                </div>
                <div style="padding-bottom: 5px;">
                    <b>Phone</b></div>
                <div style="padding-bottom: 15px;">
                    <telerik:RadMaskedTextBox runat="server" ID="txtPhoneNumber" Mask="(###) ###-####"
                        CausesValidation="true" ToolTip="<ul><li>Phone Number is required</li><li>Enter Numbers only</li></ul>" />
                    <asp:CustomValidator ID="cvPhoneNumber" runat="server" Display="None" ValidateEmptyText="true"
                        ControlToValidate="txtPhoneNumber" ClientValidationFunction="RequiredField" ValidationGroup="SRRequest" />
                </div>
                <div style="padding-bottom: 5px;">
                    <asp:Label runat="server" ID="lblNoAccountMessage" Text="Account does not exists"
                        Visible="false" SkinID="Error" /></div>
                <div style="display: none;" id="vendact">
                    <div style="padding-bottom: 5px;">
                        <b>DUNS Number</b></div>
                    <div style="padding-bottom: 15px;">
                        <telerik:RadTextBox runat="server" ID="txtDunsNumber" EmptyMessage="Ex. 123456789"
                            Width="100px" MaxLength="9" ToolTip="<ul><li>DUNS is required</li><li>Must be exactly 9 digits</li></ul>">
                            <ClientEvents OnKeyPress="IntegersOnly" />
                        </telerik:RadTextBox>
                        <asp:CustomValidator ID="cvDunsNumber" runat="server" Display="None" ValidateEmptyText="true"
                            ControlToValidate="txtDunsNumber" ClientValidationFunction="DunsNumber" ValidationGroup="SRRequest" />
                    </div>
                    <div style="padding-bottom: 5px;">
                        <b>Company name</b></div>
                    <div style="padding-bottom: 15px;">
                        <telerik:RadTextBox runat="server" ID="txtCompanyName" EmptyMessage="ABC Company"
                            Width="200px" MaxLength="60" ToolTip="<ul><li>Company Name is optional</li><li>Must not exceed 60 characters</li></ul>" />
                        <%--<asp:CustomValidator ID="cvCompanyName" runat="server" Display="None" ValidateEmptyText="true"
                            ControlToValidate="txtCompanyName" ClientValidationFunction="RequiredField" ValidationGroup="SRRequest" />--%>
                    </div>
                </div>
                <div style="display: none;" id="custact">
                    <div style="padding-bottom: 5px;">
                        <b>Account Number</b></div>
                    <div style="padding-bottom: 15px;">
                        <%--<telerik:RadTextBox runat="server" ID="txtALC" EmptyMessage="ALC" Width="100px" />--%>
                        <asp:RadioButtonList ID="rbltCustAccountType" runat="server" RepeatDirection="Horizontal"
                            RepeatLayout="Flow" Style="padding: 1px 5px 1px 5px;">
                            <asp:ListItem Value="ACT">Account Code</asp:ListItem>
                            <asp:ListItem Value="ALC">ALC</asp:ListItem>
                        </asp:RadioButtonList>
                        <asp:CustomValidator ID="cvCustAccountType" runat="server" Display="None" ValidateEmptyText="true"
                            ControlToValidate="rbltCustAccountType" ClientValidationFunction="RequiredFieldRBTN"
                            ValidationGroup="SRRequest" />
                        <telerik:RadTextBox runat="server" ID="txtAccountNumber" EmptyMessage="Ex. 123456789"
                            MaxLength="8" Width="100px" ToolTip="" />
                        <asp:CustomValidator ID="cvAccountNumber" runat="server" Display="None" ValidateEmptyText="true"
                            ControlToValidate="txtAccountNumber" ClientValidationFunction="RequiredFieldCustomerNumber"
                            ValidationGroup="SRRequest" />
                    </div>
                    <%-- <div style="padding-bottom: 5px;">
                        <b>Account Code</b></div>
                    <div style="padding-bottom: 15px;">
                        <telerik:RadTextBox runat="server" ID="txtAccountCode" EmptyMessage="Account Code"
                            Width="100px" />
                    </div>--%>
                    <div style="padding-bottom: 5px;">
                        <b>Organization name</b></div>
                    <div style="padding-bottom: 15px;">
                        <telerik:RadTextBox runat="server" ID="txtOrganizationName" EmptyMessage="ABC Organization"
                            Width="200px" MaxLength="60" ToolTip="<ul><li>Organization Name is optional</li><li>Must not exceed 60 characters</li></ul>" />
                        <%--<asp:CustomValidator ID="cvOrganizationName" runat="server" Display="None" ValidateEmptyText="true"
                            ControlToValidate="txtOrganizationName" ClientValidationFunction="RequiredField"
                            ValidationGroup="SRRequest" />--%>
                    </div>
                </div>
                <%--<div style="padding-bottom: 5px;">
                    <b>Reason for Change:</b></div>
                <div style="padding-bottom: 15px;">
                    <telerik:RadTextBox ID="txtComments" runat="server" TextMode="MultiLine" Rows="5"
                        MaxLength="255" Columns="65" Height="110px" EmptyMessage="Enter comments describing your request"
                        ToolTip="<ul><li>Description is required</li><li>Must not exceed 255 characters</li></ul>" />
                    <asp:CustomValidator ID="cvComments" runat="server" Display="None" ValidateEmptyText="true"
                        ControlToValidate="txtComments" ClientValidationFunction="RequiredField" ValidationGroup="SRRequest" />
                </div>--%>
                <telerik:RadCaptcha ID="rcptSubmit" runat="server" EnableViewState="true" />
                <div style="margin-top: 5px;">
                    <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click"
                        ValidationGroup="SRRequest" OnClientClick="DisableHiddenValidators()" />
                </div>
            </div>
            <div runat="server" id="srconfirmation" visible="false">
                <h3>
                    Thank you!</h3>
                <p>
                    We have received your request. A email has been sent to your mailbox with the below
                    information.</p>
                <p>
                    <asp:Label runat="server" ID="lblConfirmation" /></p>
                <asp:Button ID="btnCompleted" runat="server" Text="Complete" PostBackUrl="~/Default.aspx" />
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
