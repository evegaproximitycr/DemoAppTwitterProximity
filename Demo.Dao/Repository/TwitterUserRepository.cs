using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using Dapper;
using Demo.Dao.Models;

namespace Demo.Dao.Repository
{
    public class TwitterUserRepository : ITwitterUserRepository
    {

        private IDbConnection _db = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);


        public TwitterUser Find(string email)
        {
            return this._db.Query<TwitterUser>("SELECT * FROM TwitterUser WHERE Email=@Email", new { email }).SingleOrDefault();
        }

        public TwitterUser Add(TwitterUser user)
        {
            var sqlQuery = "INSERT INTO TwitterUser (Email,OAuth_Token,OAuth_Token_Secret,UserId,ScreenName,AccessToken) VALUES (@Email,@OAuth_Token,@OAuth_Token_Secret,@UserId,@ScreenName,@AccessToken); " + "SELECT CAST(SCOPE_IDENTITY() as int)";
            var userId = this._db.Query<int>(sqlQuery, user).Single();
            user.ID = userId;
            return user;
        }

        public void Delete(string email)
        {
            var sqlQuery = "DELETE FROM TwitterUser WHERE Email=@Email";
            this._db.Query<int>(sqlQuery, email).Single();
        }

    }
}