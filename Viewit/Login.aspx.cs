using System;
using System.Configuration;
using System.Data.SqlClient;
using Viewit.App_Code;

namespace Viewit
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            PageMessage.Text = "Welcome";
        }
        public void LoginSubmitClick(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(Username.Text) || string.IsNullOrEmpty(Password.Text))
            {
                PageMessage.Text = "Credentials are invalid. Insert something!";
                return;
            }
            LoginResult result = UsernameRegistered();
            if (result == LoginResult.Unregistered)
            {
                PageMessage.Text = "Username does not belong to an account. Create one!";
                return;
            }
            if (result == LoginResult.WrongPassword)
            {
                PageMessage.Text = "Password is incorrect.";
                return;
            }
            Session["username"] = Username.Text;
            Response.Redirect(string.Format("Profile.aspx?username={0}", Username.Text));

        }
        private enum LoginResult { Unregistered, WrongPassword, Success }

        private LoginResult UsernameRegistered()
        {
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
            string selectTxt = "SELECT id FROM users WHERE LOWER(username) LIKE LOWER(@user)";

            conn.Open();

            SqlCommand cmd = new SqlCommand(selectTxt, conn);

            cmd.Parameters.Add(new SqlParameter("@user", TypeCode.String));
            cmd.Parameters["@user"].Value = Username.Text;

            SqlDataReader result = cmd.ExecuteReader();

            if (!result.Read())
            {
                conn.Close();
                return LoginResult.Unregistered;
            }
            result.Close();
            selectTxt += " AND password like @pass";

            cmd = new SqlCommand(selectTxt, conn);
            string hashedPassword = AuthenticationUtilities.HashPassword(Password.Text);

            cmd.Parameters.Add(new SqlParameter("@user", TypeCode.String));
            cmd.Parameters.Add(new SqlParameter("@pass", TypeCode.String));
            cmd.Parameters["@user"].Value = Username.Text;
            cmd.Parameters["@pass"].Value = hashedPassword;

            result = cmd.ExecuteReader();

            if (result.Read())
            {
                conn.Close();
                return LoginResult.Success;
            }

            conn.Close();
            return LoginResult.WrongPassword;
        }
    }



}