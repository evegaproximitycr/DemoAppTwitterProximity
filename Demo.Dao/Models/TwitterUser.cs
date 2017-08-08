using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Demo.Dao.Models
{
    public class TwitterUser
    {
        public int ID { get; set; }
        public string Email { get; set; }
        public string OAuth_Token { get; set; }
        public string OAuth_Token_Secret { get; set; }
        public string UserId { get; set; }
        public string ScreenName { get; set; }
        public string AccessToken { get; set; }
        public string CreatedDate { get; set; }
    }
}