<%@ Page Title="" Language="C#" MasterPageFile="~/Viewit.Master" AutoEventWireup="true" CodeBehind="Image.aspx.cs" Inherits="Viewit.Image"  MaintainScrollPositionOnPostback="true"%>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Top" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Left" runat="server">
    <asp:Button ID="SharpenImage" runat="server" Text="Apply sharpen filter" OnClick="SharpenImage_Click" />
    <asp:Button ID="HorizontalBlurImage" runat="server" Text="Apply horizontal blur filter" OnClick="HorizontalBlurImage_Click"/>
    <asp:Button ID="VerticalBlurImage" runat="server" Text="Apply vertical blur filter" OnClick="VerticalBlurImage_Click" />
    <asp:Button ID="EnhanceImage" runat="server" Text="Enhance image" OnClick="EnhanceImage_Click" />
    <asp:Panel ID="DeleteSaveButtonsHolder" runat="server"></asp:Panel>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="Main" runat="server">
    <asp:Panel ID="ThumbnailsHolder" runat="server" HorizontalAlign="Center">
    </asp:Panel>
    <asp:Panel ID="ImageDescriptionHolder" runat="server" HorizontalAlign="Center"></asp:Panel>
    <asp:Panel ID="CommentPanel" runat="server" HorizontalAlign="Center">
        <asp:TextBox ID="CommentHolder" runat="server" placeholder="Insert comment here" TextMode="MultiLine" Columns="70" Rows="5" HorizontalAlign="Center" ></asp:TextBox>
        <br />
    </asp:Panel>    
    <asp:Table ID="CommentsHolder" runat="server" HorizontalAlign="Center">
    </asp:Table>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="Right" runat="server">
    <a href="Profile.aspx">My profile</a>
    <asp:Label ID="PageMessage" runat="server"></asp:Label>
</asp:Content>
