using System;
using System.Configuration;
using System.Data.SqlClient;

namespace Viewit.App_Code
{
    public class SqlUtilities
    {
        #region Getters
        public static int GetUserId(string username)
        {
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
            string selectTxt = "SELECT id FROM users WHERE LOWER(username) LIKE LOWER(@user)";

            conn.Open();
            SqlCommand cmd = new SqlCommand(selectTxt, conn);

            cmd.Parameters.Add(new SqlParameter("@user", TypeCode.String));
            cmd.Parameters["@user"].Value = username;
            SqlDataReader result = cmd.ExecuteReader();
            int userId = -1;
            if (result.Read())
            {
                userId = (int)result.GetValue(0);
            }

            result.Close();
            conn.Close();
            return userId;
        }
        public static int GetImageId(string filepath)
        {
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
            string selectTxt = "SELECT id FROM images WHERE LOWER(path) LIKE LOWER(@path)";

            conn.Open();
            SqlCommand cmd = new SqlCommand(selectTxt, conn);

            cmd.Parameters.Add(new SqlParameter("@path", TypeCode.String));
            cmd.Parameters["@path"].Value = filepath;
            SqlDataReader result = cmd.ExecuteReader();
            int imgId = -1;
            if (result.Read())
            {
                imgId = (int)result.GetValue(0);
            }

            result.Close();
            conn.Close();
            return imgId;
        }

        public static int GetAlbumId(string albumName, string username)
        {
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
            string selectTxt = "SELECT id FROM albums WHERE LOWER(name) LIKE LOWER(@name) and id_user = @user";
            int userId = GetUserId(username);

            SqlCommand cmd = new SqlCommand(selectTxt, conn);

            conn.Open();
            cmd.Parameters.Add(new SqlParameter("@name", TypeCode.String));
            cmd.Parameters.Add(new SqlParameter("@user", System.Data.SqlDbType.Int));

            cmd.Parameters["@name"].Value = albumName;
            cmd.Parameters["@user"].Value = userId;

            SqlDataReader reader = cmd.ExecuteReader();

            int albumId = -1;

            if (reader.Read())
            {
                albumId = (int)reader.GetValue(0);
            }

            reader.Close();
            conn.Close();
            return albumId;
        }
        #endregion
        #region Insert
        public static void InsertIntoIncludedIn(int imgId, int albumId)
        {
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
            string insertTxt = "INSERT INTO included_in VALUES(@id_img, @id_album)";

            SqlCommand cmd = new SqlCommand(insertTxt, conn);

            cmd.Parameters.Add(new SqlParameter("@id_img", System.Data.SqlDbType.Int));
            cmd.Parameters.Add(new SqlParameter("@id_album", System.Data.SqlDbType.Int));

            cmd.Parameters["@id_img"].Value = imgId;
            cmd.Parameters["@id_categ"].Value = categId;

            cmd.ExecuteNonQuery();

            conn.Close();
        }
        public static void InsertIntoBelongsTo(int imgId, int categId)
        {
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);

            string insertTxt = "INSERT INTO belongs_to VALUES(@id_img, @id_categ)";
            SqlCommand cmd = new SqlCommand(insertTxt, conn);
            cmd.Parameters.Add(new SqlParameter("@id_img", System.Data.SqlDbType.Int));
            cmd.Parameters.Add(new SqlParameter("@id_categ", System.Data.SqlDbType.Int));

            cmd.Parameters["@id_img"].Value = imgId;
            cmd.Parameters["@id_categ"].Value = categId;

            cmd.ExecuteNonQuery();

            conn.Close();
        }
        public static void InsertIntoImages(string username, string filepath)
        {
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
            //string insertTxt = "INSERT INTO images(uploader_id, path, upload_date, description, city, country) VALUES(@url, @uploader,"
            string insertTxt = "INSERT INTO images VALUES(@uploader, @path, GETDATE(), @desc, @city, @country)";
            SqlCommand cmd = new SqlCommand(insertTxt, conn);
            conn.Open();
            cmd.Parameters.Add(new SqlParameter("@uploader", System.Data.SqlDbType.Int));
            cmd.Parameters.Add(new SqlParameter("@path", TypeCode.String));
            cmd.Parameters.Add(new SqlParameter("@desc", TypeCode.String));
            cmd.Parameters.Add(new SqlParameter("@city", TypeCode.String));
            cmd.Parameters.Add(new SqlParameter("@country", TypeCode.String));

            int userId = SqlUtilities.GetUserId((string)Session["username"]);

            cmd.Parameters["@uploader"].Value = userId;
            cmd.Parameters["@path"].Value = filepath;
            cmd.Parameters["@desc"].Value = ImageDescription.Text;
            cmd.Parameters["@city"].Value = ImageCity.Text;
            cmd.Parameters["@country"].Value = ImageCountry.Text;

            cmd.ExecuteNonQuery();

            conn.Close();
        }
        #endregion
    }
}