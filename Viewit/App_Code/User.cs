using System;
using System.Configuration;
using System.Data.SqlClient;

namespace Viewit.App_Code
{
    public class User
    {
        public int Id { get; }
        public string Username { get; }
        public string FirstName { get; }
        public string LastName { get; }
        public string Email { get; }
        public string Password { get; }
        public DateTime Birthdate { get; }
        public bool IsAdmin { get; }

        public User(int userId)
        {
            Id = userId;
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
            string selectTxt = "SELECT username, first_name, last_name, email, password, birthday, is_admin FROM users WHERE id = @id";

            conn.Open();
            SqlCommand cmd = new SqlCommand(selectTxt, conn);

            cmd.Parameters.Add(new SqlParameter("@id", System.Data.SqlDbType.Int));
            cmd.Parameters["@id"].Value = userId;

            SqlDataReader reader = cmd.ExecuteReader();

            if (reader.Read())
            {
                Username = reader.GetString(0);
                FirstName = reader.GetString(1);
                LastName = reader.GetString(2);
                Email = reader.GetString(3);
                Password = reader.GetString(4);
                Birthdate = reader.GetDateTime(5);
                IsAdmin = reader.GetBoolean(6);
            }
            reader.Close();
            conn.Close();
        }
    }
}