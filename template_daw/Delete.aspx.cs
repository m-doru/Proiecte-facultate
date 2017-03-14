using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Delete : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void Delete_Click(object sender, EventArgs e)
    {
        Button but = (Button)sender;
        string id = but.CommandArgument;

        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);

        conn.Open();

        string deleteTxt = "DELETE planificari WHERE id = @id";

        SqlCommand cmd = new SqlCommand(deleteTxt, conn);

        cmd.Parameters.Add(new SqlParameter("@id", System.Data.SqlDbType.Int));
        cmd.Parameters["@id"].Value = id;

        cmd.ExecuteNonQuery();
        conn.Close();

        Response.Redirect("~/Delete.aspx");
    }
}