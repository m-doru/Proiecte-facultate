<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Operatie2.aspx.cs" Inherits="Operatie2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    Url<asp:TextBox ID="TextBox1" runat="server" AutoPostBack="true"></asp:TextBox>
    <br />
    Tara<asp:TextBox ID="TextBox2" runat="server" AutoPostBack="true"></asp:TextBox>
    <br />
    <%--<asp:Button ID="Button1" runat="server" Text="Search" AutoPostBack ="true"/>--%>
    <br />
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1">
        <Columns>
            <asp:BoundField DataField="url" HeaderText="url" SortExpression="url" />
            <asp:BoundField DataField="ip" HeaderText="ip" SortExpression="ip" />
            <asp:BoundField DataField="data" HeaderText="data" SortExpression="data" />
            <asp:BoundField DataField="browser" HeaderText="browser" SortExpression="browser" />
            <asp:BoundField DataField="tara" HeaderText="tara" SortExpression="tara" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT p.url url, v.ip ip, v.data data, v.browser browser, v.tara tara FROM 
pagina p JOIN vizita v ON p.id = v.idpagina WHERE p.url LIKE CONCAT('%',@url,'%') OR v.tara LIKE CONCAT('%',@tara,'%')">
        <SelectParameters>
            <asp:ControlParameter ControlID="TextBox1" DefaultValue="&quot;&quot;" Name="url" PropertyName="Text" />
            <asp:ControlParameter ControlID="TextBox2" DefaultValue="&quot;&quot;" Name="tara" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br />
</asp:Content>

