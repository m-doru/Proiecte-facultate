<%@ Page Title="Login" Language="C#" MasterPageFile="~/Viewit.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Viewit.Login" %>
<asp:Content ID="HeadContent" ContentPlaceHolderID="Head" runat="server">
    
</asp:Content>
<asp:Content ID="TopContent" ContentPlaceHolderID="Top" runat="server">
    <h2>Insert account credentials</h2>
</asp:Content>
<asp:Content ID="MainContent" ContentPlaceHolderID="Main" runat="server">
    <asp:Panel ID="LoginPanel" DefaultButton="LoginSubmitButton" runat="server">
    <table>
       <tr>
             <td>Username</td>
             <td>
                 <asp:TextBox ID="Username" runat="server"></asp:TextBox>
             </td>
             <td>
                 <asp:RequiredFieldValidator ID="UserRequired" runat="server" 
                     ControlToValidate="Username" ErrorMessage="Username not inserted"></asp:RequiredFieldValidator>
             </td>
       </tr>
        
       <tr>
             <td>Password</td>
             <td>
                 <asp:TextBox ID="Password" runat="server" TextMode="Password"></asp:TextBox>
             </td>
             <td>
                 <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" 
                     ControlToValidate="Password" ErrorMessage="Password not inserted"></asp:RequiredFieldValidator>
             </td>
       </tr>
      
       <tr>
             <td></td>
             <td>
                    <asp:Button ID="LoginSubmitButton" runat="server" Text="Login" onclick="LoginSubmitClick" />
                
             </td>
             <td>
                 <asp:ValidationSummary ID="LoginSummery" runat="server" />
             </td>
       </tr>
       <tr>
             <td></td>
             <td>

                 <asp:Label ID="PageMessage" runat="server"></asp:Label>

             </td>
             <td>
             </td>
       </tr>
    </table>
    </asp:Panel>
</asp:Content>
<asp:Content ID="LeftContent" ContentPlaceHolderID="Left" runat="server">
</asp:Content>
<asp:Content ID="RightContent" ContentPlaceHolderID="Right" runat="server">
</asp:Content>
