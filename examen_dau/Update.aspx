<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Update.aspx.cs" Inherits="Update" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <br />
    <asp:SqlDataSource ID="SqlDataSource1" 
        runat="server" 
        ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
        SelectCommand="SELECT v.id id, p.url url, v.ip ip, v.data data, v.browser browser, v.tara tara FROM 
                        pagina p JOIN vizita v ON p.id = v.idpagina ORDER BY v.data ">
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
                        <td><asp:Button runat="server" Text="Update" CommandArgument='<%#Eval("id") %>' OnClick="Update_Click"/></td>
                    </tr>
                </ItemTemplate>
            </asp:Repeater>

        </tbody>
    </table>
</asp:Content>

