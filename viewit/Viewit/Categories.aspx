<%@ Page Title="" Language="C#" MasterPageFile="~/Viewit.Master" AutoEventWireup="true" CodeBehind="Categories.aspx.cs" Inherits="Viewit.Categories" MaintainScrollPositionOnPostback="true"%>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Top" runat="server">
    <br />
    <asp:Label id="AlbumName" runat="server" ></asp:Label>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Left" runat="server" >
    <asp:BulletedList id="CategoriesList" runat="server"></asp:BulletedList>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="Main" runat="server">
    <asp:ScriptManager ID="CategoryImagesScriptManger" runat="server" EnablePartialRendering="true"></asp:ScriptManager>
    <asp:UpdatePanel ID="CategoryImagesPanel" runat="server">
        <ContentTemplate>
            <fieldset>
                <asp:Panel id="ThumbnailsHolder" runat="server" HorizontalAlign="Center"></asp:Panel>
                <asp:Button ID="LoadMoreImagesButton" Text="Load more images" runat="server" OnClick="AppendThumbnailsToMainPlaceholder" />
            </fieldset>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="Right" runat="server">
    <a href="Upload.aspx">Upload an image :)</a>
    <br />
    <a href="Profile.aspx">My profile</a>
</asp:Content>
