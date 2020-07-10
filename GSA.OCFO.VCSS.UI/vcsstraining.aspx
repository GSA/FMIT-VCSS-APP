<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <div style="padding: 0px 10px 0px 10px">
        <asp:Xml ID="xml" runat="server" DocumentSource="~/XmlDatasource/VCSSTraining.config" TransformSource="~/XmlDatasource/VCSSTraining.xslt" />
    </div>
</asp:Content>
