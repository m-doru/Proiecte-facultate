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

        string insertTxt = "INSERT INTO ";

        SqlCommand cmd = new SqlCommand(insertTxt, conn);

        //cmd.Parameters.Add(new SqlParameter("@param1", ));
        //cmd.Parameters.Add(new SqlParameter("@param2", ));
        //cmd.Parameters.Add(new SqlParameter("@param3", ));
        //cmd.Parameters.Add(new SqlParameter("@param4", ));

        //cmd.Parameters["@param1"].Value = null;
        //cmd.Parameters["@param2"].Value = null;
        //cmd.Parameters["@param3"].Value = null;
        //cmd.Parameters["@param4"].Value = null;

        cmd.ExecuteNonQuery();

        conn.Close();
    }
}