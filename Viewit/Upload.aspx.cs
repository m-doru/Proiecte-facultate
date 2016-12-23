using System;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI.WebControls;
using Viewit.App_Code;
namespace Viewit
{
    public partial class Upload : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                return;
            }

            if (Session["username"] == null)
            {
                Response.Redirect("Login.aspx");
            }
            FillCategories();
            FillUserAlbums();
        }
        public void UploadImage(object sender, EventArgs e)
        {
            if (UploadContainer.HasFile && Session["username"] != null)
            {
                string username = (string)Session["username"];
                string filename = Path.GetFileName(UploadContainer.PostedFile.FileName);
                string serverFilePath = "~/Images/" + username + "/";

                if (!CreateFolderIfNeeded(Server.MapPath(serverFilePath)))
                {
                    PageMessage.Text = "Failed to upload image. Try again later or contact the administrator of the site!";
                    return;
                }

                string randomString = RandomUtils.RandomString(20);

                UploadContainer.PostedFile.SaveAs(Server.MapPath(serverFilePath + randomString));

                SqlUtilities.InsertIntoImages(username, serverFilePath + randomString);

                UpdateSelectedCategories(serverFilePath + randomString);

                Response.Redirect("Image.aspx?username=" + username + "image=" + imgId);
            }
        }
        private void UpdateSelectedCategories(string imgPath)
        {
            int imgId = SqlUtilities.GetImageId(imgPath);

            foreach (ListItem item in ImageCategories.Items)
            {
                int categId;
                if (item.Selected && int.TryParse(item.Value, out categId))
                {
                    SqlUtilities.InsertIntoBelongsTo(imgId, categId);
                }
            }
        }

        private void UpdateSelectedAlbums(string imgPath)
        {
            int imgId = SqlUtilities.GetImageId(imgPath);
            foreach (ListItem item in UserAlbums.Items)
            {
                int albumId;
                if (item.Selected && int.TryParse(item.Value, out albumId))
                {
                    SqlUtilities.InsertIntoIncludedIn(imgId, albumId);
                }
            }
        }
        #region Content fillers
        public void FillCategories()
        {
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
            string selectTxt = "SELECT name,id from CATEGORIES ORDER BY name";

            conn.Open();

            SqlCommand cmd = new SqlCommand(selectTxt, conn);

            SqlDataReader result = cmd.ExecuteReader();

            while (result.Read())
            {
                string category = result.GetValue(0).ToString();
                string id = result.GetValue(1).ToString();
                ListItem item = new ListItem(category, id);
                ImageCategories.Items.Add(item);
            }
            result.Close();
            conn.Close();
        }
        public void FillUserAlbums()
        {
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
            string selectTxt = "SELECT a.name, a.id FROM users u JOIN albums a ON u.id = a.id_user ORDER BY name";

            conn.Open();
            SqlCommand cmd = new SqlCommand(selectTxt, conn);

            SqlDataReader result = cmd.ExecuteReader();

            while (result.Read())
            {
                string album = result.GetValue(0).ToString();
                string id = result.GetValue(1).ToString();
                ListItem item = new ListItem(album, id);
                UserAlbums.Items.Add(item);
            }
            result.Close();
            conn.Close();
            UserAlbums.Items.Add("New album");
        }
        #endregion
        #region Utilities


        private bool CreateFolderIfNeeded(string path)
        {
            bool result = true;
            if (!Directory.Exists(path))
            {
                try
                {
                    Directory.CreateDirectory(path);
                }
                catch (Exception)
                { result = false; }
            }
            return result;
        }
        #endregion
    }
}