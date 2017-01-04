using System;
using System.Collections.Generic;
using System.Web.UI.WebControls;

namespace Viewit
{
    public partial class Album : System.Web.UI.Page
    {
        private const int NR_OF_APPENDED_IMAGES = 3;
        private App_Code.User profileUser;
        private int albumId;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session["LastAppendedImg"] = 0;

                if (Request["user"] == null || Request["album"] == null)
                {
                    Response.Redirect("Login.aspx");
                    return;
                }
                else
                {
                    profileUser = App_Code.SqlUtilities.GetUser(int.Parse(Request["user"]));
                    albumId = int.Parse(Request["album"]);
                    if (Session["username"] != null)
                    {
                        string loggedUser = (string)Session["username"];
                        if (loggedUser == profileUser.Username)
                        {
                            UserGreeting.Text = "My albums";
                        }
                        else
                        {
                            UserGreeting.Text = "Hello, " + loggedUser + ". Welcome to " + profileUser + "'s album";
                        }
                    }
                }
                AddAlbumsToLeftPlaceholder();
                AppendThumbnailsToMainPlaceholder(null, null);
            }
            else
            {
                albumId = int.Parse(Request["album"]);
                profileUser = App_Code.SqlUtilities.GetUser(int.Parse(Request["user"]));
            }
        }
        protected void AppendThumbnailsToMainPlaceholder(object sender, EventArgs e)
        {
            int lastAppendedImage = (int)Session["LastAppendedImg"];
            List<App_Code.Image> images = App_Code.SqlUtilities.GetAlbumImagesOrderedByDate(albumId, 1, lastAppendedImage + NR_OF_APPENDED_IMAGES);

            foreach (App_Code.Image img in images)
            {
                ImageButton currImg = new ImageButton();
                currImg.ID = img.Id.ToString();
                currImg.ImageUrl = img.Path;
                currImg.Height = 600;
                currImg.Width = 500;
                currImg.PostBackUrl = "Image.aspx?id=" + img.Id.ToString();
                currImg.BorderWidth = 20;
                currImg.BorderColor = System.Drawing.Color.White;

                ThumbnailsHolder.Controls.Add(currImg);
            }

            lastAppendedImage += images.Count;
            Session["LastAppendedImg"] = lastAppendedImage;
        }
        private void AddAlbumsToLeftPlaceholder()
        {
            List<App_Code.Album> albums = App_Code.SqlUtilities.GetAlbums(profileUser.Username);
            UserAlbumsList.DisplayMode = BulletedListDisplayMode.HyperLink;

            foreach (App_Code.Album album in albums)
            {
                ListItem li = new ListItem(album.Name, string.Format("Album.aspx?user={0}&album={1}", album.UserId, album.Id));
                UserAlbumsList.Items.Add(li);
            }
        }
    }
}