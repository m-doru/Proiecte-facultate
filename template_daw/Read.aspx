<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Read.aspx.cs" Inherits="Read" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <br />
    <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
    <br />
    <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Submit" />
    <asp:SqlDataSource ID="SqlDataSource1" 
        runat="server" 
        ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
        SelectCommand="">
        <SelectParameters>
            <asp:Parameter Name="id" Type="Int32" DefaultValue="0" />
        </SelectParameters>
    </asp:SqlDataSource>
    


    <table>
        <thead>
            <tr>
                <td>Nume</td>
                <td>Lungime</td>
                <td>Lagime</td>
                <td>Cost</td>
                <td>Data</td>
            </tr>

        </thead>
        <tbody>

            <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1" >
                <ItemTemplate>
                    <tr>
                        <td><%# Eval("nume") %></td>
                        <td><%# Eval("lungime") %></td>
                        <td><%# Eval("latime") %></td>
                        <td><%# Eval("cost") %></td>
                        <td><%# Eval("data") %></td>
                    </tr>
                </ItemTemplate>
            </asp:Repeater>

        </tbody>
    </table>
</asp:Content>

