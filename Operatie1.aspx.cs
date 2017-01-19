using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Operatie1 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        string url = TextBox1.Text;
        string tara = TextBox2.Text;
        if (!string.IsNullOrEmpty(url))
        {
            SqlDataSource1.SelectParameters["url"].DefaultValue = url;
        }
        else
        {
            SqlDataSource1.SelectParameters["url"].DefaultValue = null;
        }
        if (!string.IsNullOrEmpty(tara))
        {
            SqlDataSource1.SelectParameters["tara"].DefaultValue = tara;
        }
        else
        {
            SqlDataSource1.SelectParameters["tara"].DefaultValue = null;
        }
    }
}