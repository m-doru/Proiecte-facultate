using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Viewit
{
    public partial class Search : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(Request.QueryString.Count == 0)
            {
                Response.Redirect("Default.aspx");
            }
            NameValueCollection keyvalues = HttpUtility.ParseQueryString(Request.QueryString.ToString());
            List<App_Code.Image> images = App_Code.SqlUtilities.FindImages(keyvalues);

            AppendThumbnailsToMainPlaceholder(images);
        }
        protected void AppendThumbnailsToMainPlaceholder(List<App_Code.Image> images)
        {
            foreach (App_Code.Image img in images)
            {
                ImageButton currImg = new ImageButton();
                currImg.ID = img.Id.ToString();
                currImg.ImageUrl = img.Path;
                currImg.Height = 600;
                currImg.Width = 500;
                currImg.PostBackUrl = "Image.aspx?id=" + img.Id.ToString();
                currImg.BorderWidth = 20;
                currImg.BorderColor = System.Drawing.Color.White;

                ThumbnailsHolder.Controls.Add(currImg);
            }
        }
    }
}