using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Configuration;
using System.Data.SqlClient;

namespace Viewit.App_Code
{
    public class SqlUtilities
    {
        #region Get operations
        public static User GetUser(int userId)
        {
            return new User(userId);
        }
        public static List<User> GetAdmins()
        {
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
            string selectTxt = "SELECT id FROM users WHERE is_admin = 1";

            conn.Open();

            SqlCommand cmd = new SqlCommand(selectTxt, conn);

            SqlDataReader reader = cmd.ExecuteReader();

            List<User> admins = null;

            if (reader.Read())
            {
                admins = new List<User>();
                admins.Add(new User(reader.GetInt32(0)));
            }

            while (reader.Read())
            {
                admins.Add(new User(reader.GetInt32(0)));
            }

            reader.Close();
            conn.Close();

            return admins;
        }
        public static Image GetImage(int imgId)
        {
            return new Image(imgId);
        }
        public static int GetUserId(string username)
        {
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
            string selectTxt = "SELECT id FROM users WHERE LOWER(username) LIKE LOWER(@username)";

            conn.Open();
            SqlCommand cmd = new SqlCommand(selectTxt, conn);

            cmd.Parameters.Add(new SqlParameter("@username", TypeCode.String));
            cmd.Parameters["@username"].Value = username;
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
            while (result.Read())
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

        public static List<Album> GetAlbums(string username)
        {
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);

            conn.Open();
            int userId = GetUserId(username);

            string selectTxt = "SELECT id, id_user, name FROM albums WHERE id_user = @user";

            SqlCommand cmd = new SqlCommand(selectTxt, conn);

            cmd.Parameters.Add(new SqlParameter("@user", System.Data.SqlDbType.Int));

            cmd.Parameters["@user"].Value = userId;

            SqlDataReader reader = cmd.ExecuteReader();

            List<Album> albums = new List<Album>();

            while (reader.Read())
            {
                Album album = new Album(reader.GetInt32(0), reader.GetInt32(1), reader.GetString(2));
                albums.Add(album);
            }

            conn.Close();
            return albums;
        }

        public static List<Image> GetImagesOrderedByDate(int userId, int first, int last)
        {
            List<Image> images = new List<Image>();
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString); ;
            conn.Open();
            string selectTxt = "SELECT id, path, upload_date, description, city, country "
                    + " FROM (SELECT ROW_NUMBER() OVER (ORDER BY upload_date) AS RowNum, id, path, upload_date, description, city, country FROM images WHERE uploader_id = @id) i"
                    + " WHERE i.RowNum >= @first AND i.RowNum <= @last";

            SqlCommand cmd = new SqlCommand(selectTxt, conn);

            cmd.Parameters.Add(new SqlParameter("@id", System.Data.SqlDbType.Int));
            cmd.Parameters.Add(new SqlParameter("@first", System.Data.SqlDbType.Int));
            cmd.Parameters.Add(new SqlParameter("@last", System.Data.SqlDbType.Int));

            cmd.Parameters["@id"].Value = userId;
            cmd.Parameters["@first"].Value = first;
            cmd.Parameters["@last"].Value = last;

            SqlDataReader reader = cmd.ExecuteReader();

            while (reader.Read())
            {
                Image img = new Image(reader.GetInt32(0), userId, reader.GetString(1), reader.GetString(4), reader.GetString(5), reader.GetDateTime(2), reader.GetString(3));
                images.Add(img);
            }

            reader.Close();
            conn.Close();
            return images;
        }

        public static List<Image> GetAlbumImagesOrderedByDate(int albumId, int first, int last)
        {
            List<Image> images = new List<Image>();
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString); ;
            conn.Open();
            string selectTxt = "SELECT id, path, upload_date, description, city, country "
                + " FROM (SELECT ROW_NUMBER() OVER(ORDER BY upload_date) AS RowNum, id, path, upload_date, description, city, country"
                + " FROM images im JOIN included_in inc ON im.id = inc.id_image"
                + " WHERE inc.id_album = @id) imgs"
                + " WHERE imgs.RowNum >= @first AND imgs.RowNum <= @last";

            SqlCommand cmd = new SqlCommand(selectTxt, conn);

            cmd.Parameters.Add(new SqlParameter("@id", System.Data.SqlDbType.Int));
            cmd.Parameters.Add(new SqlParameter("@first", System.Data.SqlDbType.Int));
            cmd.Parameters.Add(new SqlParameter("@last", System.Data.SqlDbType.Int));

            cmd.Parameters["@id"].Value = albumId;
            cmd.Parameters["@first"].Value = first;
            cmd.Parameters["@last"].Value = last;

            SqlDataReader reader = cmd.ExecuteReader();

            while (reader.Read())
            {
                Image img = new Image(reader.GetInt32(0), albumId, reader.GetString(1), reader.GetString(4), reader.GetString(5), reader.GetDateTime(2), reader.GetString(3));
                images.Add(img);
            }

            reader.Close();
            conn.Close();
            return images;
        }
        public static List<Category> GetCategoriesNames()
        {
            List<Category> categories = new List<Category>();
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);

            conn.Open();

            string selectTxt = "SELECT id, name FROM categories ORDER BY name";

            SqlCommand cmd = new SqlCommand(selectTxt, conn);

            SqlDataReader reader = cmd.ExecuteReader();

            while (reader.Read())
            {
                Category categ = new Category(reader.GetString(1), reader.GetInt32(0));
                categories.Add(categ);
            }

            reader.Close();
            conn.Close();

            return categories;
        }
        public static Category GetCategory(int id)
        {
            Category category = null;
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);

            conn.Open();

            string selectTxt = "SELECT id_image, name, i.upload_date FROM categories c JOIN belongs_to b  ON c.id = b.id_category JOIN images i on b.id_image = i.id WHERE c.id = @id ORDER BY i.upload_date DESC";

            SqlCommand cmd = new SqlCommand(selectTxt, conn);

            cmd.Parameters.Add(new SqlParameter("@id", System.Data.SqlDbType.Int));

            cmd.Parameters["@id"].Value = id;

            SqlDataReader reader = cmd.ExecuteReader();

            if (reader.Read())
            {
                int imgId = reader.GetInt32(0);
                category = new Category(reader.GetString(1), id);

                Image img = GetImage(imgId);

                category.Images.Add(img);
            }

            while (reader.Read())
            {
                int imgId = reader.GetInt32(0);

                Image img = GetImage(imgId);

                category.Images.Add(img);
            }


            reader.Close();
            conn.Close();

            return category;
        }

        public static List<Comment> GetComments(int imageId)
        {
            List<Comment> comments = new List<Comment>();
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);

            string selectTxt = "SELECT c.id, user_id, image_id, content, date FROM comments c JOIN images i ON c.image_id = i.id WHERE i.id = @id";

            conn.Open();

            SqlCommand cmd = new SqlCommand(selectTxt, conn);

            cmd.Parameters.Add(new SqlParameter("@id", System.Data.SqlDbType.Int));

            cmd.Parameters["@id"].Value = imageId;

            SqlDataReader reader = cmd.ExecuteReader();

            while (reader.Read())
            {
                Comment comm = new Comment(reader.GetInt32(0), reader.GetInt32(1), reader.GetInt32(2), reader.GetString(3), (DateTime) reader.GetValue(4));
                comments.Add(comm);
            }

            reader.Close();
            conn.Close();
            return comments;
        }
        public static int GetEditedAlbumId(int userId)
        {
            int id;
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
            conn.Open();
            string selectTxt = "SELECT id FROM ALBUMS where LOWER(name) LIKE 'edited' AND id_user = @id";

            SqlCommand cmd = new SqlCommand(selectTxt, conn);

            cmd.Parameters.Add(new SqlParameter("@id", System.Data.SqlDbType.Int));
            cmd.Parameters["@id"].Value = userId;

            SqlDataReader reader = cmd.ExecuteReader();

            if (reader.Read())
            {
                id = reader.GetInt32(0);
            }
            else
            {
                try
                {
                    CreateEditedAlbum(userId);
                    conn.Close();
                    id =  GetEditedAlbumId(userId);
                }
                catch(Exception)
                {
                    id = -1;
                }
                
            }
            return id;
        }
        private static void CreateEditedAlbum(int userId)
        {
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
            conn.Open();

            string insertTxt = "INSERT INTO albums VALUES(@id, 'edited')";

            SqlCommand cmd = new SqlCommand(insertTxt, conn);

            cmd.Parameters.Add(new SqlParameter("@id", System.Data.SqlDbType.Int));
            cmd.Parameters["@id"].Value = userId;

            cmd.ExecuteNonQuery();

            conn.Close();
        }

        public static List<Image> FindImages(NameValueCollection queryParams)
        {
            List<Image> images = new List<Image>();
            DbImagesSearchQuerry imageQuerry = new DbImagesSearchQuerry();
            foreach(string key in queryParams.AllKeys)
            {
                if(key.ToLower() == "album")
                {
                    imageQuerry.AddAlbum();
                }
                if(key.ToLower() == "category")
                {
                    imageQuerry.AddCategory();
                }
            }
            foreach(string key in queryParams.AllKeys)
            {
                string actualKey = key;
                if (key.ToLower() == "category" || key.ToLower() == "album")
                    actualKey = "name";
                imageQuerry.AddCondition(actualKey, queryParams[key]);
            }

            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
            conn.Open();

            SqlCommand cmd = imageQuerry.GetSqlCommand();
            cmd.Connection = conn;

            SqlDataReader reader = cmd.ExecuteReader();

            while (reader.Read())
            {
                int id = reader.GetInt32(0);
                Image img = new Image(id);
                images.Add(img);
            }

            conn.Close();

            return images;
        }
        #endregion
        #region Insert
        public static void InsertIntoUsers(string username, string firstName, string lastName, string email, DateTime birthdate, string password, bool isAdmin)
        {

            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
            string insertTxt = "insert into users(username, first_name, last_name, email, password, birthday, is_admin) " +
                "values(@User, @First, @Last, @Email, @Pass, @Birth, @IsAdmin)";

            SqlCommand insertCmd = new SqlCommand(insertTxt, conn);

            insertCmd.Parameters.Add(new SqlParameter("@User", TypeCode.String));
            insertCmd.Parameters.Add(new SqlParameter("@First", TypeCode.String));
            insertCmd.Parameters.Add(new SqlParameter("@Last", TypeCode.String));
            insertCmd.Parameters.Add(new SqlParameter("@Email", TypeCode.String));
            insertCmd.Parameters.Add(new SqlParameter("@Pass", TypeCode.String));
            insertCmd.Parameters.Add(new SqlParameter("@Birth", TypeCode.DateTime));
            insertCmd.Parameters.Add(new SqlParameter("@IsAdmin", System.Data.SqlDbType.Bit));

            insertCmd.Parameters["@User"].Value = username;
            insertCmd.Parameters["@First"].Value = firstName;
            insertCmd.Parameters["@Last"].Value = lastName;
            insertCmd.Parameters["@Email"].Value = email;
            insertCmd.Parameters["@Pass"].Value = AuthenticationUtilities.HashPassword(password);
            insertCmd.Parameters["@Birth"].Value = birthdate;
            if (isAdmin)
                insertCmd.Parameters["@IsAdmin"].Value = 1;
            else
                insertCmd.Parameters["@IsAdmin"].Value = 0;

            conn.Open();

            insertCmd.ExecuteNonQuery();

            conn.Close();
        }
        public static int InsertIntoAlbums(string albumName, string username)
        {
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
            conn.Open();

            string insertTxt = "INSERT INTO albums VALUES(@id_user,@album_name)";

            int userId = GetUserId(username);

            SqlCommand cmd = new SqlCommand(insertTxt, conn);

            cmd.Parameters.Add(new SqlParameter("@id_user", System.Data.SqlDbType.Int));
            cmd.Parameters.Add(new SqlParameter("@album_name", TypeCode.String));

            cmd.Parameters["@id_user"].Value = userId;
            cmd.Parameters["@album_name"].Value = albumName;

            cmd.ExecuteNonQuery();

            conn.Close();

            return GetAlbumId(albumName, username);
        }
        public static void InsertIntoIncludedIn(int imgId, int albumId)
        {
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
            conn.Open();
            string insertTxt = "INSERT INTO included_in VALUES(@id_img, @id_album)";

            SqlCommand cmd = new SqlCommand(insertTxt, conn);

            cmd.Parameters.Add(new SqlParameter("@id_img", System.Data.SqlDbType.Int));
            cmd.Parameters.Add(new SqlParameter("@id_album", System.Data.SqlDbType.Int));

            cmd.Parameters["@id_img"].Value = imgId;
            cmd.Parameters["@id_album"].Value = albumId;

            cmd.ExecuteNonQuery();

            conn.Close();
        }
        public static void InsertIntoBelongsTo(int imgId, int categId)
        {
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
            conn.Open();

            string insertTxt = "INSERT INTO belongs_to VALUES(@id_img, @id_categ)";
            SqlCommand cmd = new SqlCommand(insertTxt, conn);
            cmd.Parameters.Add(new SqlParameter("@id_img", System.Data.SqlDbType.Int));
            cmd.Parameters.Add(new SqlParameter("@id_categ", System.Data.SqlDbType.Int));

            cmd.Parameters["@id_img"].Value = imgId;
            cmd.Parameters["@id_categ"].Value = categId;

            cmd.ExecuteNonQuery();

            conn.Close();
        }
        public static int InsertIntoImages(string username, string filepath, string description, string city, string country)
        {
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
            string insertTxt = "INSERT INTO images VALUES(@uploader, @path, GETDATE(), @desc, @city, @country)";
            SqlCommand cmd = new SqlCommand(insertTxt, conn);
            conn.Open();
            cmd.Parameters.Add(new SqlParameter("@uploader", System.Data.SqlDbType.Int));
            cmd.Parameters.Add(new SqlParameter("@path", TypeCode.String));
            cmd.Parameters.Add(new SqlParameter("@desc", TypeCode.String));
            cmd.Parameters.Add(new SqlParameter("@city", TypeCode.String));
            cmd.Parameters.Add(new SqlParameter("@country", TypeCode.String));

            int userId = SqlUtilities.GetUserId(username);

            cmd.Parameters["@uploader"].Value = userId;
            cmd.Parameters["@path"].Value = filepath;
            cmd.Parameters["@desc"].Value = description;
            cmd.Parameters["@city"].Value = city;
            cmd.Parameters["@country"].Value = country;

            cmd.ExecuteNonQuery();

            conn.Close();

            return GetImageId(filepath);
        }

        public static void InsertIntoComments(int imgId, int userId, string content)
        {
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);

            string insertTxt = "INSERT INTO comments VALUES(@id_user, @id_img, @content, SYSDATETIME())";

            SqlCommand cmd = new SqlCommand(insertTxt, conn);

            cmd.Parameters.Add(new SqlParameter("@id_user", System.Data.SqlDbType.Int));
            cmd.Parameters.Add(new SqlParameter("@id_img", System.Data.SqlDbType.Int));
            cmd.Parameters.Add(new SqlParameter("@content", TypeCode.String));

            cmd.Parameters["@id_user"].Value = userId;
            cmd.Parameters["@id_img"].Value = imgId;
            cmd.Parameters["@content"].Value = content;

            conn.Open();

            cmd.ExecuteNonQuery();

            conn.Close();
        }

        public static void InsertIntoEdited(int imageId, int userId)
        {
            int editedAlbumId = GetEditedAlbumId(userId);
            if(editedAlbumId == -1)
            {
                return;
            }
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
            conn.Open();
            string insertTxt = "INSERT INTO included_in VALUES(@id_img, @id_album)";

            SqlCommand cmd = new SqlCommand(insertTxt, conn);

            cmd.Parameters.Add(new SqlParameter("@id_img", System.Data.SqlDbType.Int));
            cmd.Parameters.Add(new SqlParameter("@id_album", System.Data.SqlDbType.Int));
            cmd.Parameters["@id_img"].Value = imageId;
            cmd.Parameters["@id_album"].Value = editedAlbumId;

            cmd.ExecuteNonQuery();

            conn.Close();
        }
        #endregion
        #region Delete
        public static void RemoveComment(int id)
        {
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);

            string deleteTxt = "DELETE FROM comments WHERE id=@id";

            SqlCommand cmd = new SqlCommand(deleteTxt, conn);

            cmd.Parameters.Add(new SqlParameter("@id", System.Data.SqlDbType.Int));
            cmd.Parameters["@id"].Value = id;

            conn.Open();

            cmd.ExecuteNonQuery();

            conn.Close();
        }

        public static void RemoveImage(int id)
        {
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);

            conn.Open();

            string delteTxt = "DELETE FROM belongs_to WHERE id_image = @id";

            SqlCommand cmd = new SqlCommand(delteTxt, conn);

            cmd.Parameters.Add(new SqlParameter("@id", System.Data.SqlDbType.Int));
            cmd.Parameters["@id"].Value = id;
            cmd.ExecuteNonQuery();

            cmd.CommandText = "DELETE FROM included_in WHERE id_image = @id";
            cmd.ExecuteNonQuery();

            cmd.CommandText = "DELETE FROM comments WHERE image_id = @id";
            cmd.ExecuteNonQuery();

            cmd.CommandText = "DELETE FROM images WHERE id = @id";
            cmd.ExecuteNonQuery();

            conn.Close();
        }
        #endregion
    }
}