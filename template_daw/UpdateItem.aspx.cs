using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class UpdateItem : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string id = Request.QueryString["id"];
        if (string.IsNullOrEmpty(id))
        {
            Response.Redirect("~/Update.aspx");
        }
        else
        {
            //SqlDataSource1.SelectParameters["id"].DefaultValue = id;
            //Populate controls?
        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        string id = Request.QueryString["id"];
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);

        conn.Open();

        string insertTxt = "Update meciuri " +
                            "SET " +
                            " WHERE id = @id";

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

        Response.Redirect("~/UpdateItem.aspx?id=" + id);
    }
}