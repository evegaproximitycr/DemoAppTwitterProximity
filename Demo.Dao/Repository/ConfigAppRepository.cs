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
    public class ConfigAppRepository : IConfigAppRepository
    {

        private IDbConnection _db = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);


        public ConfigApp Find(string appName)
        {
            return this._db.Query<ConfigApp>("SELECT * FROM ConfigApp WHERE AppName=@AppName", new { appName }).SingleOrDefault();
        }

    }
}