<%@ Page Title="" Language="C#" MasterPageFile="~/Viewit.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="Viewit.Register" %>
<asp:Content ID="HeadContent" ContentPlaceHolderID="Head" runat="server">
    <script language="C#" runat="server">
        void Selection_Change(Object sender, EventArgs e)
        {
            CalendarChanged.Text = BirthdayCalendar.SelectedDate.ToShortDateString();
        }
    </script>
</asp:Content>
<asp:Content ID="TopContent" ContentPlaceHolderID="Top" runat="server">
    <h2 class="center">Fill the following forms to create an account</h2>
    <asp:Label ID="CalendarChanged" runat="server"/>
</asp:Content>
<asp:Content ID="MainContent" ContentPlaceHolderID="Main" runat="server">
    <table>
       <tr>
             <td>Username</td>
             <td>
                 <asp:TextBox ID="User" runat="server"></asp:TextBox>
             </td>
             <td>
                 <asp:RequiredFieldValidator ID="UserRequired" runat="server" 
                     ControlToValidate="User" ErrorMessage="Username not inserted"></asp:RequiredFieldValidator>
             </td>
       </tr>
        <tr>
             <td>First name</td>
             <td>
                 <asp:TextBox ID="FirstName" runat="server"></asp:TextBox>
             </td>
             <td>
                 <asp:RequiredFieldValidator ID="FirstNameRequired" runat="server" 
                     ControlToValidate="FirstName" ErrorMessage="FirstName not inserted"></asp:RequiredFieldValidator>
             </td>
       </tr>
        <tr>
             <td>Last name</td>
             <td>
                 <asp:TextBox ID="LastName" runat="server"></asp:TextBox>
             </td>
             <td>
                 <asp:RequiredFieldValidator ID="LastNameRequired" runat="server" 
                     ControlToValidate="LastName" ErrorMessage="LastName not inserted"></asp:RequiredFieldValidator>
             </td>
       </tr>
       <tr>
             <td>Password</td>
             <td>
                 <asp:TextBox ID="Pass" runat="server" TextMode="Password"></asp:TextBox>
             </td>
             <td>
                 <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" 
                     ControlToValidate="Pass" ErrorMessage="Password not inserted"></asp:RequiredFieldValidator>
             </td>
       </tr>
       <tr>
             <td>Retype password</td>
             <td>
                 <asp:TextBox ID="PassSecond" runat="server" TextMode="Password"></asp:TextBox>
             </td>
             <td>
                 <asp:RequiredFieldValidator ID="PasswordRequiredSecond" runat="server" 
                     ControlToValidate="PassSecond" ErrorMessage="Validation password not inserted"></asp:RequiredFieldValidator>
                 <asp:CompareValidator ID="PasswordsNotMatch" runat="server" 
                     ControlToCompare="Pass" ControlToValidate="PassSecond" 
                     ErrorMessage="Passwords do not match!"></asp:CompareValidator>
             </td>
       </tr>
       <tr>
             <td>Email address</td>
             <td>
                 <asp:TextBox ID="Email" runat="server"></asp:TextBox>
             </td>
             <td>
                 <asp:RequiredFieldValidator ID="EmailRequired" runat="server" 
                     ControlToValidate="Email" 
                     ErrorMessage="Email field not completed"></asp:RequiredFieldValidator>
                 <asp:RegularExpressionValidator ID="InvalidEmail" runat="server" 
                     ControlToValidate="Email" 
                     ErrorMessage="RegularExpressionValidator" 
                     ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">Invalid email address</asp:RegularExpressionValidator>
             </td>
       </tr>
        <tr>
            <td>Birthday</td>
            <td>
                Year
                <asp:DropDownList id="drpCalYear" Runat="Server" OnSelectedIndexChanged="Set_Calendar" AutoPostBack="true"></asp:DropDownList>
                Month
                <asp:DropDownList id="drpCalMonth" Runat="Server" OnSelectedIndexChanged="Set_Calendar" AutoPostBack="true"></asp:DropDownList>

            </td>
            <td>
                <asp:Calendar ID="BirthdayCalendar" runat="server"></asp:Calendar>
            </td>
        </tr>
       <tr>
             <td></td>
             <td>
                 <asp:Button ID="RegisterSubmitButton" runat="server" Text="Submit" onclick="RegisterSubmitClick" />
             </td>
             <td>
                 <asp:ValidationSummary ID="RegisterSummery" runat="server" />
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
</asp:Content>
<asp:Content ID="LeftContent" ContentPlaceHolderID="Left" runat="server">
</asp:Content>
<asp:Content ID="RightContent" ContentPlaceHolderID="Right" runat="server">
</asp:Content>
