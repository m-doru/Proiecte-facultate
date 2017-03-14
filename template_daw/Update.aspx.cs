using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Update : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void Update_Click(object sender, EventArgs e)
    {
        Button but = (Button)sender;
        string id = but.CommandArgument;
        Response.Redirect("~/UpdateItem.aspx?id=" + id);
    }
}