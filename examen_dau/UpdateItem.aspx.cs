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
            SqlDataSource1.SelectParameters["id"].DefaultValue = id;
        }
        if (!IsPostBack)
        {
            PopulateControls(id);
        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        string id = Request.QueryString["id"];
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);

        conn.Open();

        string insertTxt = "Update vizita " +
                            "SET idpagina = @param1, ip = @param2, data = @param4, browser = @param5, tara = @param6" +
                            " WHERE id = @id";

        SqlCommand cmd = new SqlCommand(insertTxt, conn);

        cmd.Parameters.Add(new SqlParameter("@id", System.Data.SqlDbType.Int));
        cmd.Parameters.Add(new SqlParameter("@param1", System.Data.SqlDbType.Int));
        cmd.Parameters.Add(new SqlParameter("@param2", TypeCode.String));
        //cmd.Parameters.Add(new SqlParameter("@param3", TypeCode.String));
        cmd.Parameters.Add(new SqlParameter("@param4", System.Data.SqlDbType.Date));
        cmd.Parameters.Add(new SqlParameter("@param5", TypeCode.String));
        cmd.Parameters.Add(new SqlParameter("@param6", TypeCode.String));

        cmd.Parameters["@id"].Value = id;
        cmd.Parameters["@param1"].Value = DropDownList1.SelectedValue;
        cmd.Parameters["@param2"].Value = TextBox1.Text;
        //cmd.Parameters["@param3"].Value = TextBox2.Text;
        cmd.Parameters["@param4"].Value = TextBox3.Text;
        cmd.Parameters["@param5"].Value = TextBox4.Text;
        cmd.Parameters["@param6"].Value = TextBox5.Text;

        cmd.ExecuteNonQuery();

        conn.Close();

        Response.Redirect("~/UpdateItem.aspx?id=" + id);
    }
    private void PopulateControls(string id)
    {
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
        string selectTxt = "SELECT ip, data, browser, tara, p.url url, p.id pid FROM vizita v JOIN pagina p ON v.idpagina = p.id WHERE v.id=@id";

        conn.Open();

        SqlCommand cmd = new SqlCommand(selectTxt, conn);

        cmd.Parameters.Add(new SqlParameter("@id", System.Data.SqlDbType.Int));
        cmd.Parameters["@id"].Value = id;


        SqlDataReader reader = cmd.ExecuteReader();

        if (reader.Read())
        {
            string ip, browser, tara;


            int pid = reader.GetInt32(5);

            DropDownList1.SelectedValue = pid.ToString();

            DateTime date = reader.GetDateTime(1);

            ip = reader.GetString(0);
            browser = reader.GetString(2);
            tara = reader.GetString(3);

            TextBox1.Text = ip;
            TextBox3.Text = date.ToString("yyyy-MM-dd");
            TextBox4.Text = browser;
            TextBox5.Text = tara;
        }

        reader.Close();
        conn.Close();
    }
}