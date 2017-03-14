<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="UpdateItem.aspx.cs" Inherits="UpdateItem" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:SqlDataSource ID="SqlDataSource1" 
        runat="server" 
        ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
        SelectCommand="SELECT v.id id, p.url url, v.ip ip, v.data data, v.browser browser, v.tara tara FROM 
                        pagina p JOIN vizita v ON p.id = v.idpagina WHERE v.id = @id">
        <SelectParameters>
            <asp:Parameter Name="id" Type="Int32" DefaultValue="0" />
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
    url<asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource2" DataTextField="URL" DataValueField="Id">
    </asp:DropDownList>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Pagina]"></asp:SqlDataSource>
    <br />
    ip<asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBox1" ErrorMessage="Acest parametru este necesar"></asp:RequiredFieldValidator>
    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="TextBox1" ErrorMessage="Ip invalid" ValidationExpression="^(?:[0-9]{1,3}\.){3}[0-9]{1,3}$"></asp:RegularExpressionValidator>
    <br />
    <%--pagina<asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TextBox2" ErrorMessage="Acest parametru este necesar"></asp:RequiredFieldValidator>
    <br />--%>
    data<asp:TextBox ID="TextBox3" runat="server" TextMode="Date"></asp:TextBox>
    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="TextBox3" ErrorMessage="Acest parametru este necesar"></asp:RequiredFieldValidator>
    <br />
    browser<asp:TextBox ID="TextBox4" runat="server"></asp:TextBox>
    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="TextBox4" ErrorMessage="Acest parametru este necesar"></asp:RequiredFieldValidator>
    <br />
    tara<asp:TextBox ID="TextBox5" runat="server" ></asp:TextBox>
    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="TextBox5" ErrorMessage="Acest parametru este necesar"></asp:RequiredFieldValidator>
    <br />
    <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Submit" />
</asp:Content>

