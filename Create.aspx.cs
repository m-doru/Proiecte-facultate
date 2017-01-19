using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Create : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);

        conn.Open();

        string insertTxt = "INSERT INTO Vizita VALUES(@param1, @param2, @param3, @param4, @param5, @param6)";

        SqlCommand cmd = new SqlCommand(insertTxt, conn);

        cmd.Parameters.Add(new SqlParameter("@param1", System.Data.SqlDbType.Int));
        cmd.Parameters.Add(new SqlParameter("@param2", TypeCode.String));
        cmd.Parameters.Add(new SqlParameter("@param3", TypeCode.String));
        cmd.Parameters.Add(new SqlParameter("@param4", System.Data.SqlDbType.Date));
        cmd.Parameters.Add(new SqlParameter("@param5", TypeCode.String));
        cmd.Parameters.Add(new SqlParameter("@param6", TypeCode.String));

        cmd.Parameters["@param1"].Value = DropDownList1.SelectedValue;
        cmd.Parameters["@param2"].Value = TextBox1.Text;
        cmd.Parameters["@param3"].Value = TextBox2.Text;
        cmd.Parameters["@param4"].Value = TextBox3.Text;
        cmd.Parameters["@param5"].Value = TextBox4.Text;
        cmd.Parameters["@param6"].Value = TextBox5.Text;

        cmd.ExecuteNonQuery();

        conn.Close();
    }

}