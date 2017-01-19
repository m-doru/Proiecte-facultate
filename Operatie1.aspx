<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Operatie1.aspx.cs" Inherits="Operatie1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    Url<asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
    <br />
    Tara<asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
    <br />
    <asp:Button ID="Button1" runat="server" Text="Search" OnClick="Button1_Click" />
    <br />
    <asp:SqlDataSource ID="SqlDataSource1" 
        runat="server" 
        ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
        SelectCommand="SELECT p.url url, v.ip ip, v.data data, v.browser browser, v.tara tara FROM 
                        pagina p JOIN vizita v ON p.id = v.idpagina WHERE p.url = @url OR v.tara = @tara">
        <SelectParameters>
            <asp:Parameter Name="url" Type="String" DefaultValue="" />
            <asp:Parameter Name="tara" Type="String" DefaultValue="" />
        </SelectParameters>
    </asp:SqlDataSource>
    


    <table>
        <thead>
            <tr>
                <td>Url</td>
                <td>IP</td>
                <td>Data</td>
                <td>Browser</td>
                <td>Tara</td>
            </tr>

        </thead>
        <tbody>

            <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1" >
                <ItemTemplate>
                    <tr>
                        <td><%# Eval("url") %></td>
                        <td><%# Eval("ip") %></td>
                        <td><%# Eval("data") %></td>
                        <td><%# Eval("browser") %></td>
                        <td><%# Eval("tara") %></td>
                    </tr>
                </ItemTemplate>
            </asp:Repeater>

        </tbody>
    </table>
</asp:Content>

