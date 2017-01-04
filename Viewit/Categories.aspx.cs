using System;
using System.Collections.Generic;
using System.Web.UI.WebControls;

namespace Viewit
{
    public partial class Categories : System.Web.UI.Page
    {
        private int categoryId;
        private const int NR_OF_APPENDED_IMGES = 3;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session["LastAppended"] = 0;
                if (Request["id"] == null || string.IsNullOrEmpty(Request["id"]))
                {
                    Response.Redirect("Default.aspx");
                    return;
                }
                else
                {
                    categoryId = int.Parse(Request["id"]);
                }
                AppendCategoriesToLeftPlaceholder();
                AppendThumbnailsToMainPlaceholder(null, null);
            }
            else
            {
                categoryId = int.Parse(Request["id"]);
            }
        }

        private void AppendCategoriesToLeftPlaceholder()
        {
            List<App_Code.Category> categories = App_Code.SqlUtilities.GetCategoriesNames();
            CategoriesList.DisplayMode = BulletedListDisplayMode.HyperLink;

            foreach (App_Code.Category category in categories)
            {
                ListItem li = new ListItem(category.Name, string.Format("Categories.aspx?id={0}", category.Id));
                CategoriesList.Items.Add(li);
            }
        }

        protected void AppendThumbnailsToMainPlaceholder(object sender, EventArgs e)
        {
            App_Code.Category category = App_Code.SqlUtilities.GetCategory(categoryId);
            int lastAppendedImg = (int)Session["LastAppended"];
            lastAppendedImg += NR_OF_APPENDED_IMGES;

            int appendedImage = 0;

            for (; category != null && appendedImage < lastAppendedImg && appendedImage < category.Images.Count; ++appendedImage)
            {
                App_Code.Image img = category.Images[appendedImage];
                ImageButton currImg = new ImageButton();
                currImg.ID = img.Id.ToString();
                currImg.ImageUrl = img.Path;
                currImg.Height = 600;
                currImg.Width = 500;
                currImg.PostBackUrl = "Image.asp?id=" + img.Id.ToString();
                currImg.BorderWidth = 20;
                currImg.BorderColor = System.Drawing.Color.White;

                ThumbnailsHolder.Controls.Add(currImg);
            }


            Session["LastAppended"] = appendedImage;
        }
    }
}