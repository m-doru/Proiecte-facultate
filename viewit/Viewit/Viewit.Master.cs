using System;
using System.Collections.Generic;
using System.Text;
using System.Web.UI.WebControls;

namespace Viewit
{
    public partial class Viewit : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(Session["username"] != null || !string.IsNullOrEmpty((string)Session["username"]))
            {
                ShowLoggedButtons();
                if (new App_Code.User(App_Code.SqlUtilities.GetUserId(Session["username"] as string)).IsAdmin)
                {
                    RegisterButton.Visible = true;
                }
            }
            else
            {
                ShowUnloggedinButtons();
            }
        }
        #region Moving around buttons
        private void ShowLoggedButtons()
        {
            LogoutButton.Visible = true;
            MyProfileButton.Visible = true;
        }
        private void ShowUnloggedinButtons()
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

        protected void MyProfileButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("Profile.aspx");
        }

        protected void FrontPage_Click(object sender, EventArgs e)
        {
            Response.Redirect("Default.aspx");
        }
        #endregion
        #region Search
        protected void SearchButton_Click(object sender, EventArgs e)
        {
            Dictionary<string, string> args = ParseSearchQuerry(SearchTextBox.Text);
            StringBuilder redirect = new StringBuilder();
            redirect.Append("Search.aspx");
            foreach(KeyValuePair<string, string> entry in args)
            {
                AddKeyword(redirect, entry.Key, entry.Value);
            }
            Response.Redirect(redirect.ToString());

        }
        private Dictionary<string, string> ParseSearchQuerry(string querry)
        {
            Dictionary<string, string> args = new Dictionary<string, string>();
            foreach(string keyvalue in querry.Split(' '))
            {
                string[] arg = keyvalue.Split(':');
                args[arg[0]] = arg[1];
            }
            return args;
        }
        private void AddKeyword(StringBuilder redirect, string keyword, string value)
        {
            if (redirect.ToString().StartsWith("Search.aspx?"))
            {
                redirect.Append("&" + keyword + "=" + value);
            }
            else
            {
                redirect.Append("?" + keyword + "=" + value);
            }
        }
        #endregion
    }
}