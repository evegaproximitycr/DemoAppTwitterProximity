using Demo.Dao.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DemoAppTwitter.Models
{
    public class TwitterUserModel
    {
        public IList<string> tweets { get; set; }
        public IList<string> tweetsPlaces { get; set; }
        public TwitterUser user { get; set; }
    }
}