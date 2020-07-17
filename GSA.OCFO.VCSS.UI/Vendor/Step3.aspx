<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="Step3.aspx.cs" Inherits="Vendor_Step3" %>

<%@ PreviousPageType VirtualPath="~/Vendor/Step2.aspx" %>
<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <script type="text/javascript" language="javascript">
        function RequiredFieldChkBox(sender, args) {
            var checkBox = document.getElementById('<%=chkAdminResponsibility.ClientID%>')
            checkBox.style.backgroundColor = "#FFFFFF";
            if (checkBox.checked)
            { args.IsValid = true; } else { checkBox.style.backgroundColor = "#FFD9D9"; args.IsValid = false; }
        }
    </script>
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <script src="../Scripts/core.js" type="text/javascript"></script>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Always">
        <ContentTemplate>
            <table id="progress">
                <tr>
                    <td class="previous">
                        <asp:LinkButton runat="server" ID="lnkStep1" Text="New Requests" PostBackUrl="~/Vendor/Step1.aspx" />
                    </td>
                    <td class="previous">
                        <asp:LinkButton runat="server" ID="lnkStep2" Text="User Information" PostBackUrl="~/Vendor/Step2.aspx" />
                    </td>
                    <td class="current">
                        Confirm and Submit
                    </td>
                    <td class="next">
                        Request Complete
                    </td>
                </tr>
            </table>
            <%--<div class="nav-steps">
                <ul>
                    <li class="first"><a href="Step1.aspx">New Requests</a></li>
                    <li class="first"><a href="Step2.aspx">User Information</a></li>
                    <li class="active"><a href="#">Confirm and Submit</a></li>
                    <li><a href="#">Request Complete</a></li>
                </ul>
            </div>--%>
            <h3>
                Confirm your request</h3>
            <div class="marginB10">
                Make sure all details are correct. When you are done, click "Submit"</div>
            <div class="sectionHeader">
                Your Information
            </div>
            <div class="marginB10">
                <telerik:RadListView ID="lvUserInfo" runat="server">
                    <LayoutTemplate>
                        <asp:PlaceHolder ID="itemPlaceholder" runat="server"></asp:PlaceHolder>
                    </LayoutTemplate>
                    <ItemTemplate>
                        <table width="90%">
                            <tr>
                                <td colspan="2">
                                    <b>Name :</b>
                                    <%# Eval("Title")%>
                                    <%# Eval("FirstName")%>
                                    <%# Eval("LastName")%>
                                    <br />
                                    <b>Email :</b>
                                    <%# Eval("EmailAddress")%>
                                    <br />
                                    <b>Phone :</b>
                                    <%# String.Format("{0:(###) ###-####}", long.Parse(Eval("PhoneNumber").ToString()))%>
                                    <br />
                                    <b>Non US Phone :</b>
                                    <%# string.IsNullOrEmpty(Eval("NonUSPhoneNumber").ToString()) ? "N/A" : String.Format("{0:(###) ##-##########}", long.Parse(Eval("NonUSPhoneNumber").ToString()))%>
                                    <br />
                                    <b>Fax :</b>
                                    <%# string.IsNullOrEmpty(Eval("FaxNumber").ToString()) ? "N/A" : String.Format("{0:(###) ###-####}", long.Parse(Eval("FaxNumber").ToString()))%>
                                </td>
                            </tr>
                        </table>
                    </ItemTemplate>
                </telerik:RadListView>
            </div>
            <div class="sectionHeader">
                Account Requests
            </div>
            <div runat="server" id="divAccess" class="marginB10" visible="false">
                <p>
                    <strong>Access Requests</strong></p>
                <telerik:RadListView ID="lvAccountReqestAccounts" runat="server">
                    <LayoutTemplate>
                        <table class="SearchTable" width="80%">
                            <thead>
                                <tr>
                                    <th width="20%">
                                        DUNS
                                    </th>
                                    <th width="10%">
                                        DUNS+4
                                    </th>
                                    <th width="40%">
                                        Company
                                    </th>
                                    <th width="30%">
                                        Account Administrator
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
                                <%# Eval("NUM")%>
                            </td>
                            <td align="center">
                                <%# Eval("NUM4")%>
                            </td>
                            <td>
                                <%# Eval("NAME")%>
                            </td>
                            <td align="center">
                                <%# Eval("ADMINISTRATOR")%>
                            </td>
                        </tr>
                    </ItemTemplate>
                    <AlternatingItemTemplate>
                        <tr class="odd">
                            <td align="center">
                                <%# Eval("NUM")%>
                            </td>
                            <td align="center">
                                <%# Eval("NUM4")%>
                            </td>
                            <td>
                                <%# Eval("NAME")%>
                            </td>
                            <td align="center">
                                <%# Eval("ADMINISTRATOR")%>
                            </td>
                        </tr>
                    </AlternatingItemTemplate>
                </telerik:RadListView>
            </div>
            <div id="divider" runat="server" class="seperator" visible="false" />
            <div runat="server" id="divRegistration" class="marginB10" visible="false">
                <p>
                    <strong>Registration Requests</strong></p>
                <telerik:RadListView ID="lvRegistrationAccounts" runat="server">
                    <LayoutTemplate>
                        <table class="SearchTable" width="50%">
                            <thead>
                                <tr>
                                    <th width="20%">
                                        Duns
                                    </th>
                                    <th>
                                        Company
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
                                <%# Eval("NUM")%>
                            </td>
                            <td>
                                <%# Eval("NAME")%>
                            </td>
                        </tr>
                    </ItemTemplate>
                    <AlternatingItemTemplate>
                        <tr class="odd">
                            <td align="center">
                                <%# Eval("NUM")%>
                            </td>
                            <td>
                                <%# Eval("NAME")%>
                            </td>
                        </tr>
                    </AlternatingItemTemplate>
                </telerik:RadListView>
                <div class="terms">
                    <div class="title">
                        Administrator Responsibility</div>
                    <asp:CustomValidator ID="cvAdminResponsibility" runat="server" ClientValidationFunction="RequiredFieldChkBox"
                        ValidationGroup="Validate" />
                    <asp:CheckBox ID="chkAdminResponsibility" runat="server" Text="I accept this responsibility"
                        ValidationGroup="Validate" />
                    <br />
                    <br />
                    By submitting this request to GSA you are agreeing to accept the responsibility
                    of being the Administrator for this account. Your responsibility will be to approve/disapprove
                    all user access to this account.
                    <br />
                    <br />
                    Additionally, you are agreeing to have your name and email address provided to anyone
                    requesting access to this account.
                </div>
            </div>
            <div class="captchaArea">
                <telerik:RadCaptcha ID="rcptSubmit" runat="server" EnableViewState="true" />
            </div>
            <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click"
                ValidationGroup="Validate" />&nbsp;<asp:LinkButton runat="server" ID="lbtnBack" Text="Go back to edit"
                    PostBackUrl="~/Vendor/Step2.aspx" />
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
