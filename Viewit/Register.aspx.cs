using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using Viewit.App_Code;

namespace Viewit
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] != null && !string.IsNullOrEmpty((string)Session["username"]))
            {
                string username = (string)Session["username"];
                Response.Redirect("Profile.aspx?username=" + username);
            }
            if (!IsPostBack)
            {
                Populate_MonthList();
                Populate_YearList();
            }
        }

        public void RegisterSubmitClick(object sender, EventArgs e)
        {
            if (!RegistrationFieldsValid())
            {
                PageMessage.Text = "Registration fields are invalid";
                return;
            }
            if (!UsernameAvailable())
            {
                PageMessage.Text = "Username is already used for an account";
                return;
            }
            if (!EmailAvailable())
            {
                PageMessage.Text = "Email is already user for an account";
                return;
            }

            SqlUtilities.InsertIntoUsers(Username.Text, FirstName.Text, LastName.Text, Email.Text, BirthdayCalendar.SelectedDate, Password.Text, false);

            Session["username"] = Username.Text;
            Session["password"] = Password.Text;

            Response.Redirect(string.Format("Profile.aspx?username={0}", Username.Text));

        }
        #region Validity checks
        private bool UsernameAvailable()
        {
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);

            string selectTxt = "SELECT username FROM users WHERE LOWER(username) LIKE LOWER(@username)";

            SqlCommand selectCmd = new SqlCommand(selectTxt, conn);

            selectCmd.Parameters.Add(new SqlParameter("@username", TypeCode.String));

            selectCmd.Parameters["@username"].Value = Username.Text;

            conn.Open();
            SqlDataReader results = selectCmd.ExecuteReader();

            if (results.Read())
            {
                results.Close();
                conn.Close();
                return false;
            }
            results.Close();
            conn.Close();
            return true;
        }
        private bool EmailAvailable()
        {
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);

            string selectTxt = "SELECT email FROM users WHERE LOWER(email) LIKE LOWER(@email)";

            SqlCommand selectCmd = new SqlCommand(selectTxt, conn);

            selectCmd.Parameters.Add(new SqlParameter("@email", TypeCode.String));

            selectCmd.Parameters["@email"].Value = Email.Text;

            conn.Open();
            SqlDataReader results = selectCmd.ExecuteReader();

            if (results.Read())
            {
                conn.Close();
                return false;
            }

            conn.Close();
            return true;
        }
        private bool RegistrationFieldsValid()
        {

            if (!string.IsNullOrEmpty(Username.Text) && !string.IsNullOrEmpty(Password.Text) &&
            !string.IsNullOrEmpty(PasswordSecond.Text) && !string.IsNullOrEmpty(Email.Text) &&
            !string.IsNullOrEmpty(FirstName.Text) && !string.IsNullOrEmpty(LastName.Text) &&
            PasswordSecond.Text == Password.Text && !string.IsNullOrEmpty(BirthdayCalendar.SelectedDate.ToShortDateString()))
            {
                return true;
            }
            return false;
        }
        #endregion

        #region YearMonthPopulation
        protected void Populate_MonthList()
        {
            //Add each month to the list
            var dtf = System.Globalization.CultureInfo.CurrentCulture.DateTimeFormat;
            for (int i = 1; i <= 12; i++)
                drpCalMonth.Items.Add(new ListItem(dtf.GetMonthName(i), i.ToString()));

            //Make the current month selected item in the list
            drpCalMonth.Items.FindByValue(DateTime.Now.Month.ToString()).Selected = true;
        }


        protected void Populate_YearList()
        {
            //Year list can be changed by changing the lower and upper 
            //limits of the For statement    
            for (int intYear = DateTime.Now.Year - 130; intYear <= DateTime.Now.Year + 20; intYear++)
            {
                drpCalYear.Items.Add(intYear.ToString());
            }

            //Make the current year selected item in the list
            drpCalYear.Items.FindByValue(DateTime.Now.Year.ToString()).Selected = true;
        }

        protected void Set_Calendar(object Sender, EventArgs e)
        {
            int year = int.Parse(drpCalYear.SelectedValue);
            int month = int.Parse(drpCalMonth.SelectedValue);
            BirthdayCalendar.TodaysDate = new DateTime(year, month, 1);
        }
        #endregion
    }
}