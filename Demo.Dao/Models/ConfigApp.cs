using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Demo.Dao.Models
{
    public class ConfigApp
    {
        public string AppName { get; set; }
        public string OAauth_consumerkey { get; set; }
        public string OAauth_consumersecret { get; set; }
        public string OAauth_version { get; set; }
        public string OAauth_signature_method { get; set; }
        public string Callback_url { get; set; }
        public string AccessToken { get; set; }
        public string CreatedDate { get; set; }
    }
}