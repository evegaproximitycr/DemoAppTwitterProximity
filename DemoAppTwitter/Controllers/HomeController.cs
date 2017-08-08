using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System;
using System.Globalization;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using Microsoft.Owin.Security;
using DemoAppTwitter.Models;
using Microsoft.AspNet.Identity.EntityFramework;
using Demo.Business.Services;
using Demo.Dao.Repository;
using Demo.Dao.Models;
using Thinktecture.IdentityModel.Mvc;

namespace DemoAppTwitter.Controllers
{
    [Authorize]
    public class HomeController : Controller
    {
        private ApplicationUserManager _userManager;
        private ITwitterUserRepository _userRepository = new TwitterUserRepository();
        private OAuthService _oauthService = new OAuthService();
        private TwitterService _twitterService = new TwitterService();

        public ApplicationUserManager UserManager
        {
            get
            {
                return _userManager ?? HttpContext.GetOwinContext().GetUserManager<ApplicationUserManager>();
            }
            private set
            {
                _userManager = value;
            }
        }

        public ActionResult Index()
        {
            return View();
        }

        [ResourceAuthorize("claims_user", "user")]
        public ActionResult UserHomepage()
        {            
            var twitterInfo = new TwitterUserModel();
            twitterInfo.tweetsPlaces = new List<string>();
            var twitterUser = _userRepository.Find(User.Identity.GetUserName());
            if (twitterUser != null)
            {
                twitterInfo.user = twitterUser;
             
                //get tweets
                twitterInfo.tweets = _twitterService.GetTweets(twitterUser.ScreenName, twitterUser.AccessToken);
            }
            else
            {                
                 return RedirectToAction("RegisterTwitter");
            }
            return View(twitterInfo);
        }

        public ActionResult RegisterTwitter(string tweet)
        {
            return View();
        }
            
        public PartialViewResult LoadTweets(string tweet)
        {
            var tweets = new List<string>();
            var twitterUser = _userRepository.Find(User.Identity.GetUserName());
            if (twitterUser != null)
            {

                if (!string.IsNullOrEmpty(tweet))
                {
                    _twitterService.PostTweet(twitterUser.OAuth_Token, twitterUser.OAuth_Token_Secret, tweet);
                }

                //get tweets
                tweets = _twitterService.GetTweets(twitterUser.ScreenName, twitterUser.AccessToken);
            }

            return PartialView("_Partial/_Tweets", tweets);
        }

        public PartialViewResult SearchPlace(string placeId)
        {
            var tweetsPlaces = new List<string>();
            var twitterUser = _userRepository.Find(User.Identity.GetUserName());
            if (twitterUser != null)
            {
                if (!string.IsNullOrEmpty(placeId))
                {
                    tweetsPlaces = _twitterService.SearchByPlaceId(placeId, twitterUser.AccessToken);
                }
            }

            return PartialView("_Partial/_SearchPlace", tweetsPlaces);
        }

        public PartialViewResult PopularTweets(string user, string tag)
        {
            var tweetsPopular = new List<string>();
            var twitterUser = _userRepository.Find(User.Identity.GetUserName());
            if (twitterUser != null)
            {

                if (!string.IsNullOrEmpty(user) && !string.IsNullOrEmpty(tag))
                {
                    tweetsPopular = _twitterService.SearchPopularTweetsFromUser(user,tag, twitterUser.AccessToken);
                }
            }

            return PartialView("_Partial/_SearchPopular", tweetsPopular);
        }


        public ActionResult AddTwitterUser()
        {
            var response = _oauthService.RequestToken();

            var token = HttpUtility.ParseQueryString(response).Get("oauth_token");
            var tokensecret = HttpUtility.ParseQueryString(response).Get("oauth_token_secret");

            return Redirect("https://api.twitter.com/oauth/authorize?oauth_token=" + token);
        }

        [HttpGet]
        public async Task<ActionResult> Success()
        {
            var oauth_verifier = Request.Params.Get("oauth_verifier");
            var oauth_token = Request.Params.Get("oauth_token");
            var response = _oauthService.RequestAccessToken(oauth_verifier, oauth_token);
            var user_oauth_token = HttpUtility.ParseQueryString(response).Get("oauth_token");
            var user_oauth_token_secret = HttpUtility.ParseQueryString(response).Get("oauth_token_secret");
            var user_id = HttpUtility.ParseQueryString(response).Get("user_id");
            var screen_name = HttpUtility.ParseQueryString(response).Get("screen_name");

            string accessToken = await _oauthService.GenerateUserAccessToken();

            var twitterUser = new TwitterUser();
            twitterUser.Email = User.Identity.GetUserName();
            twitterUser.OAuth_Token = user_oauth_token;
            twitterUser.OAuth_Token_Secret = user_oauth_token_secret;
            twitterUser.ScreenName = screen_name;
            twitterUser.UserId = user_id;
            twitterUser.AccessToken = accessToken;

            _userRepository.Add(twitterUser);
            return RedirectToAction("UserHomepage");
        }
    }
}