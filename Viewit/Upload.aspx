<%@ Page Title="" Language="C#" MasterPageFile="~/Viewit.Master" AutoEventWireup="true" CodeBehind="Upload.aspx.cs" Inherits="Viewit.Upload" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Top" runat="server">
    <h1>Hei, add a picture :)</h1>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Left" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="Main" runat="server">
    <table>
        <tr>
            <td>Upload</td>
            <td>
                <asp:FileUpload ID="UploadContainer" runat="server" /> 
            </td>
            <td>

                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="UploadContainer" ErrorMessage="Do not forget the file"></asp:RequiredFieldValidator>

            </td>
        </tr>
        <tr>
            <td>
                Add a description
            </td>
            <td>
                <asp:TextBox ID="ImageDescription" runat="server" TextMode="MultiLine"></asp:TextBox>
            </td>
            <td>

                <asp:RequiredFieldValidator ID="ImageDescriptionRequired" runat="server" ControlToValidate="ImageDescription" ErrorMessage="Add a little description"></asp:RequiredFieldValidator>

            </td>
        </tr>
        <tr>
            <td>
                Country:
            </td>
            <td>
                <asp:TextBox ID="ImageCountry" runat="server"></asp:TextBox>
            </td>
            <td>
                City:
            </td>
            <td>
                <asp:TextBox ID="ImageCity" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                Categories:
            </td>
            <td style="border: 1pt solid black">
                <div style="overflow-y:scroll; height:100px">
                <asp:CheckBoxList ID="ImageCategories" runat="server" SelectionMode="Multiple" />
                </div>
            </td>
        </tr>
        <tr>
            <td>
                Albums:
            </td>
            <td style="border:1pt solid black">
                <div style="overflow-y:scroll; height:100px">
                <asp:CheckBoxList ID="UserAlbums" runat="server" SelectionMode="Multiple" Height="26px" />
                </div>
            </td>
            <td>
                <asp:TextBox ID="NewAlbumName" placeholder="New album name" runat="server"/>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Button id="UploadButton" Text="Upload" runat="server" OnClick="UploadImage" />
            </td>
        </tr>
    </table>

    <asp:Label ID="PageMessage" runat="server"/>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="Right" runat="server">
</asp:Content>
