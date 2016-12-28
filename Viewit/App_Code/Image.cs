using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Viewit.App_Code
{
    public class Image
    {
        public int Id { get; }
        public int UploaderId { get; }
        public string Path { get; }
        public string City { get; }
        public string Country { get; }
        public DateTime UploadDate { get; }
        public string Description { get; }
        public Image(int id, int uploaderId, string path, string city, string country, DateTime uploadDate, string desc)
        {
            Id = id;
            UploaderId = uploaderId;
            Path = path;
            City = city;
            Country = country;
            UploadDate = uploadDate;
            Description = desc;
        }

        public Image(int id)
        {
            Id = id;

            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString); ;

            string selectTxt = "SELECT uploader_id, path, upload_date, description, city, country FROM images WHERE id = @id";

            SqlCommand cmd = new SqlCommand(selectTxt, conn);

            cmd.Parameters.Add(new SqlParameter("@id", System.Data.SqlDbType.Int));
            cmd.Parameters["@id"].Value = id;

            SqlDataReader reader = cmd.ExecuteReader();

            if (reader.Read())
            {
                UploaderId = reader.GetInt32(0);
                Path = reader.GetString(1);
                UploadDate = reader.GetDateTime(2);
                Description = reader.GetString(3);
                City = reader.GetString(4);
                Country = reader.GetString(5);
            }

            reader.Close();
            conn.Close();

        }
    }
}