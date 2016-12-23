using System;
using System.Security.Cryptography;
using System.Text;
using System.Web;

namespace Viewit.App_Code
{
    public class AuthenticationUtilities
    {
        public static bool CheckLogin()
        {
            if(HttpContext.Current.Session["username"] == null || string.IsNullOrEmpty((string)HttpContext.Current.Session["username"]))
            {
                return false;
            }
            return true;
        }
        public static string HashPassword(string password)
        {
            var provider = new SHA256CryptoServiceProvider();
            var encoding = new UnicodeEncoding();
            return Convert.ToBase64String(provider.ComputeHash(encoding.GetBytes(password)));
        }
    }
}