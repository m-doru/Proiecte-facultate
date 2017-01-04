using System;
using System.Collections.Generic;
using System.IO;
using System.Web.UI.WebControls;

namespace Viewit
{
    public partial class Image : System.Web.UI.Page
    {
        private int imageId;
        private string loggedUsername = null;
        private string imageUploader = null;
        private const string MATLAB_FUNCTIONS_FOLDER = "~/MatlabFunctions";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request["id"] == null || string.IsNullOrEmpty(Request["id"]))
            {
                if (Request.UrlReferrer != null)
                {
                    Response.Redirect(Request.UrlReferrer.ToString());
                }
                else
                {
                    Response.Redirect("Default.aspx");
                }
            }
            else
            {
                imageId = int.Parse(Request["id"]);
                imageUploader = App_Code.SqlUtilities.GetUser(App_Code.SqlUtilities.GetImage(imageId).UploaderId).Username;

                if (Session["username"] != null || !string.IsNullOrEmpty((string)Session["username"]))
                {
                    loggedUsername = (string)Session["username"];
                }
                AddImage();
                PopulateComments();
                AddCommentSubmitButtonIfLoggedIn();
                AddSaveDeleteButtons();
                
            }
        }
        private void AddImage()
        {
            App_Code.Image image = new App_Code.Image(imageId);

            System.Web.UI.WebControls.Image imageControl = new System.Web.UI.WebControls.Image();
            imageControl.ImageUrl = image.Path;
            imageControl.ID = imageId.ToString();
            imageControl.ImageAlign = ImageAlign.Middle;

            ThumbnailsHolder.Controls.Add(imageControl);

            Label imageDescription = new Label();
            imageDescription.Text = image.Description;
            imageDescription.Font.Bold = true;
            imageDescription.Font.Size = 15;
            ImageDescriptionHolder.Controls.Add(imageDescription);
            ImageDescriptionHolder.BorderWidth = 15;
            ImageDescriptionHolder.BorderColor = System.Drawing.Color.White;
        }
        #region Comments
        private void AddCommentSubmitButtonIfLoggedIn()
        {
            if (loggedUsername == null)
            {
                return;
            }

            Button submitComment = new Button();
            submitComment.Text = "Submit comment";
            submitComment.Click += SubmitCommentClicked;
            CommentPanel.Controls.Add(submitComment);
        }
        protected void SubmitCommentClicked(object sender, EventArgs e)
        {
            string comment = CommentHolder.Text;
            string commenter = loggedUsername;
            int imgId = int.Parse(Request["id"]);
            int userId = App_Code.SqlUtilities.GetUserId(commenter);

            App_Code.SqlUtilities.InsertIntoComments(imgId, userId, comment);

            Response.Redirect("Image.aspx?id=" + imgId.ToString());
        }
        private void PopulateComments()
        {
            List<App_Code.Comment> comments = App_Code.SqlUtilities.GetComments(imageId);
            foreach (var comment in comments)
            {
                TableRow tr = new TableRow();

                TableCell user = new TableCell();
                user.Text = App_Code.SqlUtilities.GetUser(comment.UserId).Username;
                user.BorderWidth = 10;
                user.BorderColor = System.Drawing.Color.White;
                tr.Cells.Add(user);

                TableCell date = new TableCell();
                date.Text = comment.Date.ToShortDateString();
                date.BorderWidth = 10;
                date.BorderColor = System.Drawing.Color.White;
                tr.Cells.Add(date);

                TableCell hour = new TableCell();
                hour.Text = comment.Date.ToLongTimeString();
                hour.BorderWidth = 10;
                hour.BorderColor = System.Drawing.Color.White;
                tr.Cells.Add(hour);

                TableCell content = new TableCell();
                content.Text = comment.Content;
                content.BorderWidth = 10;
                content.BorderColor = System.Drawing.Color.White;
                tr.Cells.Add(content);

                if (loggedUsername != null && loggedUsername == imageUploader)
                {
                    TableCell remove = new TableCell();
                    remove.BorderWidth = 10;
                    remove.BorderColor = System.Drawing.Color.White;
                    Button removeButton = new Button();
                    removeButton.Text = "Remove comment";
                    removeButton.Click += RemoveComment;
                    removeButton.ID = comment.Id.ToString();

                    remove.Controls.Add(removeButton);
                    tr.Cells.Add(remove);
                }
                CommentsHolder.Rows.Add(tr);
            }
        }
        protected void RemoveComment(object sender, EventArgs e)
        {
            Button button = (Button)sender;

            App_Code.SqlUtilities.RemoveComment(int.Parse(button.ID));

            Response.Redirect("Image.aspx?id=" + Request["id"]);
        }
        #endregion
        #region Image editing
        protected void SharpenImage_Click(object sender, EventArgs e)
        {
            MLApp.MLApp matlab = new MLApp.MLApp();

            string path = Server.MapPath(MATLAB_FUNCTIONS_FOLDER);

            matlab.Execute("cd " + Server.MapPath(MATLAB_FUNCTIONS_FOLDER));

            App_Code.Image image = App_Code.SqlUtilities.GetImage(int.Parse(Request["id"]));

            string[] temp = image.Path.Split('/');
            string imageName = temp[temp.Length - 1];

            object result = null;

            matlab.Feval("sharpen", 1, out result, Server.MapPath(image.Path), imageName, loggedUsername);

            object[] res = result as object[];

            string resultPath = "~/Images/" + loggedUsername + "/" + (string)res[0];


            System.Web.UI.WebControls.Image imageControl = (System.Web.UI.WebControls.Image)ThumbnailsHolder.Controls[1];

            imageControl.ImageUrl = resultPath;

            if(ViewState["editedImagePath"] != null)
            {
                DeleteImage(null, null);
            }
            ViewState["editedImagePath"] = resultPath;

            AddSaveDeleteButtons();

        }
        protected void HorizontalBlurImage_Click(object sender, EventArgs e)
        {
            MLApp.MLApp matlab = new MLApp.MLApp();

            matlab.Execute("cd " + Server.MapPath(MATLAB_FUNCTIONS_FOLDER));

            object result = null;

            App_Code.Image image = App_Code.SqlUtilities.GetImage(int.Parse(Request["id"]));

            string[] temp = image.Path.Split('/');
            string imageName = temp[temp.Length - 1];

            matlab.Feval("horizontalBlur", 1, out result, Server.MapPath(image.Path), imageName, loggedUsername);

            object[] res = result as object[];

            string resultPath = "~/Images/" + loggedUsername + "/" + (string)res[0];


            System.Web.UI.WebControls.Image imageControl = (System.Web.UI.WebControls.Image)ThumbnailsHolder.Controls[1];

            imageControl.ImageUrl = resultPath;
            if (ViewState["editedImagePath"] != null)
            {
                DeleteImage(null, null);
            }
            ViewState["editedImagePath"] = resultPath;

            AddSaveDeleteButtons();
        }

        protected void VerticalBlurImage_Click(object sender, EventArgs e)
        {
            MLApp.MLApp matlab = new MLApp.MLApp();

            matlab.Execute("cd " + Server.MapPath(MATLAB_FUNCTIONS_FOLDER));

            object result = null;

            App_Code.Image image = App_Code.SqlUtilities.GetImage(int.Parse(Request["id"]));

            string[] temp = image.Path.Split('/');
            string imageName = temp[temp.Length - 1];

            matlab.Feval("verticalBlur", 1, out result, Server.MapPath(image.Path), imageName, loggedUsername);

            object[] res = result as object[];

            string resultPath = "~/Images/" + loggedUsername + "/" + (string)res[0];

            System.Web.UI.WebControls.Image imageControl = (System.Web.UI.WebControls.Image)ThumbnailsHolder.Controls[1];

            imageControl.ImageUrl = resultPath;

            if (ViewState["editedImagePath"] != null)
            {
                DeleteImage(null, null);
            }
            ViewState["editedImagePath"] = resultPath;

            AddSaveDeleteButtons();
        }
        protected void EnhanceImage_Click(object sender, EventArgs e)
        {
            MLApp.MLApp matlab = new MLApp.MLApp();

            matlab.Execute("cd " + Server.MapPath(MATLAB_FUNCTIONS_FOLDER));

            object result = null;

            App_Code.Image image = App_Code.SqlUtilities.GetImage(int.Parse(Request["id"]));

            string[] temp = image.Path.Split('/');
            string imageName = temp[temp.Length - 1];

            matlab.Feval("enhance", 1, out result, Server.MapPath(image.Path), imageName, loggedUsername);

            object[] res = result as object[];

            string resultPath = "~/Images/" + loggedUsername + "/" + (string)res[0];

            System.Web.UI.WebControls.Image imageControl = (System.Web.UI.WebControls.Image)ThumbnailsHolder.Controls[1];

            imageControl.ImageUrl = resultPath;

            if (ViewState["editedImagePath"] != null)
            {
                DeleteImage(null, null);
            }
            ViewState["editedImagePath"] = resultPath;

            AddSaveDeleteButtons();
        }
        #endregion
        #region SaveDelete
        protected void AddSaveDeleteButtons()
        {
            if (loggedUsername != null)
            {
                int loggedUserId = App_Code.SqlUtilities.GetUserId(loggedUsername);
                App_Code.User loggedUsr = new App_Code.User(loggedUserId);
                App_Code.Image img = new App_Code.Image(imageId);
                if ((img.UploaderId == loggedUserId || loggedUsr.IsAdmin) && DeleteSaveButtonsHolder.Controls.Count < 1)
                {
                    Button deleteImage = new Button();
                    deleteImage.ID = "DeteleImageButton";
                    deleteImage.Text = "Delete Image";
                    deleteImage.Click += DeleteImage;
                    DeleteSaveButtonsHolder.Controls.Add(deleteImage);
                }
                if (ViewState["editedImagePath"] != null && DeleteSaveButtonsHolder.Controls.Count < 2)
                {
                    Button saveImage = new Button();
                    saveImage.ID = "SaveImageButton";
                    saveImage.Click += SaveImage;
                    saveImage.Text = "Save image";
                    DeleteSaveButtonsHolder.Controls.Add(saveImage);
                }
            }
        }
        protected void SaveImage(object sender, EventArgs e)
        {
            if(loggedUsername != null)
            {
                string path = (string)ViewState["editedImagePath"];

                // check if the same image has not been saved before
                if(App_Code.SqlUtilities.GetImageId(path) != -1)
                {
                    return;
                }
                App_Code.Image img = new App_Code.Image(imageId);
                int userId = App_Code.SqlUtilities.GetUserId(loggedUsername);
                if(img.UploaderId != userId)
                {
                    PageMessage.Text = "You cannot save this image as you are not the owner of it.";
                    return;
                }
                App_Code.SqlUtilities.InsertIntoImages(loggedUsername, path, img.Description, img.City, img.Country);
                int imgId = App_Code.SqlUtilities.GetImageId(path);
                App_Code.SqlUtilities.InsertIntoEdited(imgId, userId);
            }
        }

        protected void DeleteImage(object sender, EventArgs e)
        {
            if(ViewState["editedImagePath"] != null)
            {
                string path = (string)ViewState["editedImagePath"];
                File.Delete(Server.MapPath(path));
                if(sender != null && e != null)
                {
                    Response.Redirect(Request.Url.AbsolutePath);
                }
            }
            else
            {
                App_Code.Image image = new App_Code.Image(imageId);
                App_Code.SqlUtilities.RemoveImage(imageId);
                File.Delete(Server.MapPath(image.Path));
                Response.Redirect("Profile.aspx");
            }
        }
        #endregion
    }
}