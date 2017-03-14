﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Viewit.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="Viewit.Profile" MaintainScrollPositionOnPostback="true" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Top" runat="server">
    <br />
    <asp:Label id="UserGreeting" runat="server"></asp:Label>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Left" runat="server" >
    <asp:BulletedList id="UserAlbumsList" runat="server"></asp:BulletedList>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="Main" runat="server">
    <asp:ScriptManager ID="UserImagesScriptManger" runat="server" EnablePartialRendering="true"></asp:ScriptManager>
    <asp:UpdatePanel ID="UserImagesPanel" runat="server">
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
</asp:Content>