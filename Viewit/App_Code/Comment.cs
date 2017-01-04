using System;

namespace Viewit.App_Code
{
    public class Comment
    {
        public int Id { get; set; }
        public int UserId { get; set; }
        public int ImageId { get; set; }
        public string Content { get; set; }
        public DateTime Date { get; set; }

        public Comment(int id, int userId, int imgId, string content, DateTime date)
        {
            Id = id;
            UserId = userId;
            ImageId = imgId;
            Content = content;
            Date = date;
        }
    }
}