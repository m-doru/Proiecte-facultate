using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;

namespace Viewit.App_Code
{
    public class DbImagesSearchQuerry
    {
        public StringBuilder Query { get; }
        private SqlCommand SqlCmd;
        public DbImagesSearchQuerry()
        {
            Query = new StringBuilder();
            Query.Append("SELECT im.id FROM images im");
            SqlCmd = new SqlCommand();

        }
        public void AddAlbum()
        {
            Query.Append(" JOIN included_in inc ON im.id = inc.id_image JOIN albums ab ON ab.id = inc.id_album");
        }

        public void AddCategory()
        {
            Query.Append(" JOIN belongs_to blg ON im.id = blg.id_image JOIN categories categ ON categ.id = blg.id_category");
        }

        public void AddCondition(string key, string value)
        {
            if (Query.ToString().Contains("WHERE"))
            {
                Query.Append(" AND " + key + "=" + "@" + key);
            }
            else
            {
                Query.Append(" WHERE " + key + "=" + "@" + key);
            }
            SqlCmd.Parameters.Add(new SqlParameter("@" + key, TypeCode.String));
            SqlCmd.Parameters["@" + key].Value = value;
        }
        public SqlCommand GetSqlCommand()
        {
            if(SqlCmd.CommandText == null || string.IsNullOrEmpty(SqlCmd.CommandText))
            {
                SqlCmd.CommandText = Query.ToString();
            }
            return SqlCmd;
        }
    }
}