using System;
using System.Collections.Generic;
using System.Web.UI.WebControls;

namespace Viewit
{
    public partial class Profile : System.Web.UI.Page
    {
        private string profileUser;
        private const int NR_OF_APPENDED_IMAGES = 3;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session["LastAppendedImg"] = 0;

                if (Request["username"] == null && Session["username"] == null)
                {
                    Response.Redirect("Login.aspx");
                }
                if (Request["username"] != null)
                {
                    profileUser = (string)Request["username"];
                }
                else
                {
                    profileUser = (string)Session["username"];
                }
                if (Session["username"] != null)
                {
                    string loggedUser = (string)Session["username"];
                    if (loggedUser == profileUser)
                    {
                        UserGreeting.Text = "Hello, " + loggedUser;
                    }
                    else
                    {
                        UserGreeting.Text = "Hello, " + loggedUser + ". Welcome to " + profileUser + "'s profile";
                    }
                }
                AddAlbumsToLeftPlaceholder();
                AppendThumbnailsToMainPlaceholder(null, null);
            }
            else
            {
                if (Request["username"] != null)
                {
                    profileUser = Request["username"];
                }
                else
                {
                    profileUser = (string)Session["username"];
                }
            }

        }
        protected void AppendThumbnailsToMainPlaceholder(object sender, EventArgs e)
        {

            int lastAppendedImage = (int)Session["LastAppendedImg"];
            int profileUserId = App_Code.SqlUtilities.GetUserId(profileUser);
            List<App_Code.Image> images = App_Code.SqlUtilities.GetImagesOrderedByDate(profileUserId, 1, lastAppendedImage + NR_OF_APPENDED_IMAGES);


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
            List<App_Code.Album> albums = App_Code.SqlUtilities.GetAlbums(profileUser);
            UserAlbumsList.DisplayMode = BulletedListDisplayMode.HyperLink;

            foreach (App_Code.Album album in albums)
            {
                ListItem li = new ListItem(album.Name, string.Format("Album.aspx?user={0}&album={1}", album.UserId, album.Id));
                UserAlbumsList.Items.Add(li);
            }
        }
    }
}