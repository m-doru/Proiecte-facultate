using System.Collections.Generic;

namespace Viewit.App_Code
{
    public class Album
    {
        public int Id { get; }
        public int UserId { get; }
        public string Name { get; }
        private List<Image> Images { get; }

        public Album(int id, int userId, string name)
        {
            Id = id;
            UserId = userId;
            Name = name;
            Images = new List<Image>();
        }

        public void AddImage(Image img)
        {
            Images.Add(img);
        }

    }
}