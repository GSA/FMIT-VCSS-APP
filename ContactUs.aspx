﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <link href="/Styles/Site.css" rel="stylesheet" type="text/css" />
    <script src="Scripts/jquery-1.9.1.js" type="text/javascript"></script>
    <script src="Scripts/jquery-ui.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {
            var icons = {
                header: "accordionHeader",
                activeHeader: "accordionHeaderSelected"
            };

            $("#accContacts").accordion({
                icons: icons, header: "h4", collapsible: true, active: false, heightStyle: "content"
            });
        });
    
    </script>
    <div style="padding: 0px 10px 0px 10px">
        <asp:Xml ID="xml" runat="server" DocumentSource="~/XmlDatasource/ContactUs.config" TransformSource="~/XmlDatasource/ContactUs.xslt" />
    </div>
</asp:Content>
