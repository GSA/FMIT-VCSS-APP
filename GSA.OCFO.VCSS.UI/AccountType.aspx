<%@ Page Title="" Language="C#" MasterPageFile="Site.master" AutoEventWireup="true" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <div style="padding: 0px 20px 0px 20px; margin-top: 35px;">
        <div class="infoblock" id="left" style="width: 48%;">
            <div class="head">
                Vendor Registrations and Access Requests
            </div>
            <div class="content" style="padding-top: 30px;">
                <telerik:RadButton ID="btnVendor" runat="server" Text="Click here if you currently do business with GSA as a Vendor"
                    PostBackUrl="~/Vendor/Step1.aspx" Width="100%" Font-Bold="true" />
                <p>
                    Being in VCSS allows a vendor to create and process real-time invoices electronically
                    and track the status of payments made by GSA. If you wish to participate in VCSS,
                    you must have a valid DUNS/DUNS+4 number and register in the Central Contractor
                    Registration (CCRC) database prior to registering in VCSS.
                </p>
            </div>
        </div>
        <div class="infoblock" id="right" style="width: 48%;">
            <div class="head">
                Customer Registrations and Access Requests
            </div>
            <div class="content" style="padding-top: 30px;">
                <telerik:RadButton ID="btnCustomer" runat="server" Text="Click here if you are a Customer of GSA"
                    PostBackUrl="~/Customer/Step1.aspx" Width="100%" Font-Bold="true" />
                <p>
                    A customer utilizing VCSS will have the capability to view their billing and payment
                    information. You can link to external websites and export billing data to CSV. You
                    can also manage your accounts, review account history and submit correspondence.
                    All customers must register their GSA Account Code formerly known as BOAC or AGBU
                    Codes and IPAC activities must register their Agency Location Codes (ALC).
                </p>
            </div>
        </div>
    </div>
</asp:Content>
