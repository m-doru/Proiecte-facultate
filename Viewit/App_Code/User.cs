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
            string selectTxt = "SELECT username, first_name, last_name, email, password, birthday, is_admin FROM users id = @userId";

            conn.Open();
            SqlCommand cmd = new SqlCommand(selectTxt, conn);

            cmd.Parameters.Add(new SqlParameter("@username", TypeCode.String));
            cmd.Parameters["@userId"].Value = userId;
            SqlDataReader result = cmd.ExecuteReader();

            if (result.Read())
            {
                Username = result.GetString(0);
                FirstName = result.GetString(1);
                LastName = result.GetString(2);
                Email = result.GetString(3);
                Password = result.GetString(4);
                Birthdate = result.GetDateTime(5);
                IsAdmin = Convert.ToBoolean((int)result.GetValue(6));
            }
            result.Close();
            conn.Close();
        }
    }
}