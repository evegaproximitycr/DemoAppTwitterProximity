using Demo.Business.Logger;
using Demo.Dao.Models;
using System;
using System.Configuration;
using System.Globalization;
using System.IO;
using System.Net;
using System.Net.Http;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using System.Web.Script.Serialization;

namespace Demo.Business.Services
{
    public class OAuthService
    {
        #region  properties 
        private ConfigApp _configData = null;
        private static string DEMO_VERSION = "1.0";

        private const string REQUEST_TOKEN = "https://api.twitter.com/oauth/request_token";
        private const string REQUEST_ACCESSTOKEN = "https://api.twitter.com/oauth/access_token";
        private const string OAUTH2_TOKEN = "https://api.twitter.com/oauth2/token";
        #endregion

        public OAuthService()
        {
            var _configService = new ConfigAppService();
            _configData = _configService.GetConfigurationForApp(ConfigurationManager.AppSettings["AppName"].ToString());
        }

        #region public methods
        public string RequestToken()
        {
            var response = string.Empty;

            ServicePointManager.SecurityProtocol = SecurityProtocolType.Ssl3 | SecurityProtocolType.Tls | SecurityProtocolType.Tls | SecurityProtocolType.Tls11 | SecurityProtocolType.Tls12;
            HttpWebRequest webRequest = (HttpWebRequest)WebRequest.Create(REQUEST_TOKEN);

            var headerValue = CreateHeader();
            webRequest.Headers.Add("Authorization", headerValue);
            webRequest.Accept = "application/json";
            webRequest.UserAgent = string.Format("Twitter.AppDemo v{0}", DEMO_VERSION); ;
            webRequest.Host = "api.twitter.com";
            webRequest.Method = "POST";

            try
            {
                var httpResponse = (HttpWebResponse)webRequest.GetResponse();

                Stream dataStream = httpResponse.GetResponseStream();
                StreamReader reader = new StreamReader(dataStream);
                response = reader.ReadToEnd();
            }
            catch (Exception ex)
            {
                LogEvent.Log(ex.Message);
            }

            return response;
        }

        public string RequestAccessToken(string oauth_verifier, string oauth_token)
        {
            var response = string.Empty;

            var authHeader = CreateHeaderAccessToken(oauth_token);
            ServicePointManager.SecurityProtocol = SecurityProtocolType.Ssl3 | SecurityProtocolType.Tls | SecurityProtocolType.Tls | SecurityProtocolType.Tls11 | SecurityProtocolType.Tls12;
            HttpWebRequest webRequest = (HttpWebRequest)WebRequest.Create(REQUEST_ACCESSTOKEN);

            webRequest.Headers.Add("Authorization", authHeader);
            webRequest.Accept = "application/json";
            webRequest.UserAgent = string.Format("Twitter.AppDemo v{0}", DEMO_VERSION); ;
            webRequest.Host = "api.twitter.com";
            webRequest.Method = "POST";

            string postData = "oauth_verifier=" + oauth_verifier;
            ASCIIEncoding encoding = new ASCIIEncoding();
            byte[] byte1 = encoding.GetBytes(postData);

            webRequest.ContentType = "application/x-www-form-urlencoded";

            webRequest.ContentLength = byte1.Length;

            Stream newStream = webRequest.GetRequestStream();

            newStream.Write(byte1, 0, byte1.Length);
            try
            {
                var httpResponse = (HttpWebResponse)webRequest.GetResponse();

                Stream dataStream = httpResponse.GetResponseStream();
                StreamReader reader = new StreamReader(dataStream);
                response = reader.ReadToEnd();
            }
            catch (Exception ex)
            {
                LogEvent.Log(ex.Message);
            }

            return response;
        }

        public async Task<string> GenerateUserAccessToken()
        {

            var bearEncoding = new UTF8Encoding();
            var bear = _configData.OAauth_consumerkey + ":" + _configData.OAauth_consumersecret;
            var bearBytes = bearEncoding.GetBytes(bear.ToCharArray());

            var basic = Convert.ToBase64String(bearBytes);

            var httpClient = new HttpClient();
            var request = new HttpRequestMessage(HttpMethod.Post, OAUTH2_TOKEN);

            request.Headers.Add("Authorization", "Basic " + basic);
            request.Content = new StringContent("grant_type=client_credentials",
                                                    Encoding.UTF8, "application/x-www-form-urlencoded");

            HttpResponseMessage response = await httpClient.SendAsync(request);

            string json = await response.Content.ReadAsStringAsync();
            var serializer = new JavaScriptSerializer();
            dynamic item = serializer.Deserialize<object>(json);
            var access_token = item["access_token"];
            return access_token;
        }

        #endregion

        #region private section
        private string CreateHeader()
        {
            string oauth_nonce = Convert.ToBase64String(new ASCIIEncoding().GetBytes(DateTime.Now.Ticks.ToString()));
            string oauth_timestamp = ((int)DateTime.UtcNow.Subtract(new DateTime(1970, 1, 1)).TotalSeconds).ToString(CultureInfo.InvariantCulture);
            string oauth_nonce_enc = Uri.EscapeDataString(oauth_nonce);

            string oauth_callback_enc = Uri.EscapeDataString(_configData.Callback_url);
            string oauth_signature_method_enc = Uri.EscapeDataString(_configData.OAauth_signature_method);
            string oauth_timestamp_enc = Uri.EscapeDataString(oauth_timestamp);
            string oauth_consumer_key_enc = Uri.EscapeDataString(_configData.OAauth_consumerkey);
            string oauth_version_enc = Uri.EscapeDataString(_configData.OAauth_version);

            string req_url_enc = Uri.EscapeDataString(REQUEST_TOKEN);
            string oauth_signature = "POST" + "&" + req_url_enc + "&" + Uri.EscapeDataString("oauth_consumer_key=" + oauth_consumer_key_enc + 
                                     "&oauth_nonce=" + oauth_nonce + "&oauth_signature_method=" + oauth_signature_method_enc + 
                                     "&oauth_timestamp=" + oauth_timestamp_enc + "&oauth_version=" + oauth_version_enc);

            oauth_signature = CreateHMACSHA1(oauth_signature, _configData.OAauth_consumersecret);

            var headerFormat = @"OAuth oauth_consumer_key=""{0}"", oauth_nonce=""{1}"", oauth_signature=""{2}"", oauth_signature_method=""{3}"", oauth_timestamp=""{4}"", oauth_version=""{5}""";

            var authHeader = string.Format(headerFormat,
                Uri.EscapeDataString(_configData.OAauth_consumerkey),
                Uri.EscapeDataString(oauth_nonce),
                Uri.EscapeDataString(oauth_signature),
                Uri.EscapeDataString(_configData.OAauth_signature_method),
                Uri.EscapeDataString(oauth_timestamp),
                Uri.EscapeDataString(_configData.OAauth_version)
            );

            return authHeader;
        }

        
        private string CreateHeaderAccessToken(string oauth_token)
        {
            string oauth_nonce = Convert.ToBase64String(new ASCIIEncoding().GetBytes(DateTime.Now.Ticks.ToString()));
            string oauthtimestamp = ((int)DateTime.UtcNow.Subtract(new DateTime(1970, 1, 1)).TotalSeconds).ToString(CultureInfo.InvariantCulture);//Convert.ToInt64(timeSpan.TotalSeconds).ToString();
            string oauth_nonce_enc = Uri.EscapeDataString(oauth_nonce);
            string oauth_token_enc = Uri.EscapeDataString(oauth_token);
            string oauth_signature_method_enc = Uri.EscapeDataString(_configData.OAauth_signature_method);
            string oauth_timestamp_enc = Uri.EscapeDataString(oauthtimestamp);
            string oauth_consumer_key_enc = Uri.EscapeDataString(_configData.OAauth_consumerkey);
            string oauth_version_enc = Uri.EscapeDataString(_configData.OAauth_version);
            string req_url_enc = Uri.EscapeDataString(REQUEST_ACCESSTOKEN);
            string oauth_signature = "POST" + "&" + req_url_enc + "&" + Uri.EscapeDataString("oauth_consumer_key=" + oauth_consumer_key_enc + "&oauth_nonce=" + oauth_nonce + "&oauth_signature_method=" + oauth_signature_method_enc + "&oauth_timestamp=" + oauth_timestamp_enc + "&oauth_token=" + oauth_token + "&oauth_version=" + oauth_version_enc);

            oauth_signature = CreateHMACSHA1(oauth_signature, _configData.OAauth_consumersecret);

            var headerFormat = "OAuth oauth_consumer_key=\"{0}\", oauth_nonce=\"{1}\", " +
                                           "oauth_signature=\"{2}\", oauth_signature_method=\"{3}\", " +
                                           "oauth_timestamp=\"{4}\", " +
                                           "oauth_token=\"{5}\", " +
                                           "oauth_version=\"{6}\"";

            var authHeader = string.Format(headerFormat,
                Uri.EscapeDataString(_configData.OAauth_consumerkey),
                Uri.EscapeDataString(oauth_nonce),
                Uri.EscapeDataString(oauth_signature),
                Uri.EscapeDataString(_configData.OAauth_signature_method),
                Uri.EscapeDataString(oauthtimestamp),
                Uri.EscapeDataString(oauth_token),
                Uri.EscapeDataString(_configData.OAauth_version)
            );
            return authHeader;
        }
        private string CreateHMACSHA1(string value, string key)
        {
            key = Uri.EscapeDataString(key) + "&";
            using (var hmac = new HMACSHA1(Encoding.ASCII.GetBytes(key)))
            {
                return Convert.ToBase64String(hmac.ComputeHash(Encoding.ASCII.GetBytes(value)));
            }
        }
        #endregion


    }
}