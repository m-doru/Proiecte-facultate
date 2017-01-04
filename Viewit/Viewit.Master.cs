using System;
using System.Web.UI.WebControls;

namespace Viewit
{
    public partial class Viewit : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(Session["username"] != null || !string.IsNullOrEmpty((string)Session["username"]))
            {
                ShowLogoutButton();
            }else
            {
                ShowLoginButton();
            }
        }

        private void ShowLogoutButton()
        {
            LogoutButton.Visible = true;
        }
        private void ShowLoginButton()
        {
            LoginButton.Visible = true;
            RegisterButton.Visible = true;
        }

        protected void LogoutButton_Click(object sender, EventArgs e)
        {
            Session["username"] = null;
            Session["password"] = null;
            Response.Redirect("Default.aspx");
        }

        protected void LoginButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("Login.aspx");
        }

        protected void RegisterButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("Register.aspx");
        }
    }
}