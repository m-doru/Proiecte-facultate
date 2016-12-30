using System.Collections.Generic;

namespace Viewit.App_Code
{
    public class Category
    {
        public string Name { get; set; }
        public int Id { get; set; }
        public List<Image> Images { get; }
        public Category(string name, int id)
        {
            Name = name;
            Id = id;
            Images = new List<Image>();
        }
    }
}