using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Viewit
{
    public partial class Default : System.Web.UI.Page
    {
        private const int NR_OF_IMAGES_PER_CATEGORY = 5;
        protected void Page_Load(object sender, EventArgs e)
        {
            AppendCategoriesToLeftPlaceholder();
            AddImagesToMainPlaceholder();
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
        private void AddImagesToMainPlaceholder()
        {
            ContentPlaceHolder maincph = (ContentPlaceHolder)this.Master.FindControl("Main");

            List<App_Code.Category> categories = App_Code.SqlUtilities.GetCategoriesNames();

            foreach (App_Code.Category category in categories)
            {
                App_Code.Category categ = App_Code.SqlUtilities.GetCategory(category.Id);

                if(categ == null)
                {
                    continue;
                }

                Panel imagesHolder = new Panel();
                imagesHolder.ID = category.Name + "Holder";
                imagesHolder.BorderColor = System.Drawing.Color.Black;
                imagesHolder.BorderWidth = 3;
                imagesHolder.HorizontalAlign = HorizontalAlign.Center;
                maincph.Controls.Add(imagesHolder);

                Label categName = new Label();
                categName.Text = category.Name;
                categName.Font.Size = 15;
                imagesHolder.Controls.Add(categName);
                imagesHolder.Controls.Add(new LiteralControl("<br />"));

                for (int i = 0; i < categ.Images.Count && i < NR_OF_IMAGES_PER_CATEGORY; ++i)
                {
                    App_Code.Image img = categ.Images[i];
                    ImageButton currImg = new ImageButton();
                    currImg.ID = category.Name + img.Id.ToString();
                    currImg.ImageUrl = img.Path;
                    currImg.Height = 600;
                    currImg.Width = 500;
                    currImg.PostBackUrl = "Image.aspx?id=" + img.Id.ToString();
                    currImg.BorderWidth = 20;
                    currImg.BorderColor = System.Drawing.Color.White;

                    imagesHolder.Controls.Add(currImg);
                }
            }
        }
    }
}