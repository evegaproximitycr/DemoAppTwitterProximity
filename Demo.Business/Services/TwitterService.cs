using Demo.Business.Logger;
using Demo.Dao.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Security.Cryptography;
using System.Text;
using System.Web.Script.Serialization;

namespace Demo.Business.Services
{
    public class TwitterService
    {
        #region properties and constructor
        private ConfigApp _configData = null;

        private const string SEARCH_PLACE_URL = "https://api.twitter.com/1.1/search/tweets.json?q=place:{0}&result_type=recent&count={1}";

        private const string GET_TWEETS_URL = "https://api.twitter.com/1.1/statuses/user_timeline.json?count={0}&screen_name={1}&trim_user=1&exclude_replies=1";

        private const string SEARCH_POPULAR_TWEETS_URL = "https://api.twitter.com/1.1/search/tweets.json?q=from:%23{0}%20AND%20%40{1}&result_type=recent&count=5";

        private const string POST_TWEET_URL = "https://api.twitter.com/1.1/statuses/update.json";

        public TwitterService()
        {
            var _configService = new ConfigAppService();
            _configData = _configService.GetConfigurationForApp(ConfigurationManager.AppSettings["AppName"].ToString());
        }
        #endregion

        #region public methods
        public List<string> GetTweets(string userName, string accessToken)
        {
            List<string> tweetsList = new List<string>();
            var count = 10;

            try
            {
                var request = new HttpRequestMessage(HttpMethod.Get,
                string.Format(GET_TWEETS_URL, count, userName));

                request.Headers.Add("Authorization", "Bearer " + accessToken);
                var httpClient = new HttpClient();
                HttpResponseMessage responseUserTimeLine = httpClient.SendAsync(request).Result;
                var serializer = new JavaScriptSerializer();
                dynamic json = serializer.Deserialize<object>( responseUserTimeLine.Content.ReadAsStringAsync().Result);
                var result = (json as IEnumerable<dynamic>);

                if (result != null)
                {
                    tweetsList = result.Select(r => (string)(r["text"].ToString())).ToList();
                }
            }
            catch (Exception ex)
            {
                LogEvent.Log(ex.Message);
            }


            return tweetsList;
        }

        public void PostTweet(string oauth_token, string oauth_token_secret,string tweetText)
        {
            try
            {
                var oauth_nonce = Convert.ToBase64String(new ASCIIEncoding().GetBytes(DateTime.Now.Ticks.ToString()));
                var timeSpan = DateTime.UtcNow - new DateTime(1970, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc);
                var oauth_timestamp = Convert.ToInt64(timeSpan.TotalSeconds).ToString();

                var signatureFormat = "oauth_consumer_key={0}&oauth_nonce={1}&oauth_signature_method={2}" +
                                "&oauth_timestamp={3}&oauth_token={4}&oauth_version={5}&status={6}";

                var baseSignature = string.Format(signatureFormat,
                                            _configData.OAauth_consumerkey,
                                            oauth_nonce,
                                            _configData.OAauth_signature_method,
                                            oauth_timestamp,
                                            oauth_token,
                                            _configData.OAauth_version,
                                            Uri.EscapeDataString(tweetText)
                                            );

                baseSignature = string.Concat("POST&", Uri.EscapeDataString(POST_TWEET_URL), "&", Uri.EscapeDataString(baseSignature));

                var compositeKey = string.Concat(Uri.EscapeDataString(_configData.OAauth_consumersecret),
                                        "&", Uri.EscapeDataString(oauth_token_secret));

                string oauth_signature;
                using (HMACSHA1 hasher = new HMACSHA1(ASCIIEncoding.ASCII.GetBytes(compositeKey)))
                {
                    oauth_signature = Convert.ToBase64String(hasher.ComputeHash(ASCIIEncoding.ASCII.GetBytes(baseSignature)));
                }

                var headerKeys = "OAuth oauth_nonce=\"{0}\", oauth_signature_method=\"{1}\", " +
                                   "oauth_timestamp=\"{2}\", oauth_consumer_key=\"{3}\", " +
                                   "oauth_token=\"{4}\", oauth_signature=\"{5}\", " +
                                   "oauth_version=\"{6}\"";

                var headerValue = string.Format(headerKeys,
                                        Uri.EscapeDataString(oauth_nonce),
                                        Uri.EscapeDataString(_configData.OAauth_signature_method),
                                        Uri.EscapeDataString(oauth_timestamp),
                                        Uri.EscapeDataString(_configData.OAauth_consumerkey),
                                        Uri.EscapeDataString(oauth_token),
                                        Uri.EscapeDataString(oauth_signature),
                                        Uri.EscapeDataString(_configData.OAauth_version)
                                );

                var postBody = "status=" + Uri.EscapeDataString(tweetText);

                HttpWebRequest request = (HttpWebRequest)WebRequest.Create(POST_TWEET_URL);
                request.Headers.Add("Authorization", headerValue);
                request.Method = "POST";
                request.ContentType = "application/x-www-form-urlencoded;charset=UTF-8";
                using (Stream stream = request.GetRequestStream())
                {
                    byte[] content = ASCIIEncoding.ASCII.GetBytes(postBody);
                    stream.Write(content, 0, content.Length);
                }
                WebResponse response = request.GetResponse();
            }
            catch (Exception ex)
            {
                LogEvent.Log(ex.Message);
            }
        }

        public List<string> SearchByPlaceId(string placeID, string accessToken)
        {
            var count = 5;
            var tweetsPlace = new List<string>();

            try
            {
                var request = new HttpRequestMessage(HttpMethod.Get, string.Format(SEARCH_PLACE_URL, placeID, count));

                request.Headers.Add("Authorization", "Bearer " + accessToken);
                var httpClient = new HttpClient();
                HttpResponseMessage responseUserTimeLine = httpClient.SendAsync(request).Result;

                var jsonStr = responseUserTimeLine.Content.ReadAsStringAsync().Result;
                var jss = new JavaScriptSerializer();
                dynamic jsondata = jss.Deserialize<dynamic>(jsonStr);

                IEnumerable<dynamic> statusesList = jsondata["statuses"];
                tweetsPlace = statusesList.Select(r => (string)(r["text"].ToString())).ToList();
            }
            catch (Exception ex)
            {
                LogEvent.Log(ex.Message);
            }

            return tweetsPlace;
        }

        public List<string> SearchPopularTweetsFromUser(string userName, string tag, string accessToken)
        {
            var tweetsPopular = new List<string>();
            var count = 5;

            try
            {
                var url = string.Format(SEARCH_POPULAR_TWEETS_URL, tag, userName, count);
                var request = new HttpRequestMessage(HttpMethod.Get, url);

                request.Headers.Add("Authorization", "Bearer " + accessToken);
                var httpClient = new HttpClient();
                HttpResponseMessage responseUserTimeLine = httpClient.SendAsync(request).Result;
                var jsonStr = responseUserTimeLine.Content.ReadAsStringAsync().Result;
                var jss = new JavaScriptSerializer();
                dynamic jsondata = jss.Deserialize<dynamic>(jsonStr);

                IEnumerable<dynamic> statusesList = jsondata["statuses"];
                tweetsPopular = statusesList.Select(r => (string)(r["text"].ToString())).ToList();
            }
            catch (Exception ex)
            {
                LogEvent.Log(ex.Message);
            }

            return tweetsPopular;
        }
        #endregion
    }
}