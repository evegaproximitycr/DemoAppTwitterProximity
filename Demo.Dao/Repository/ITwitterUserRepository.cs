using Demo.Dao.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Demo.Dao.Repository
{
    public interface ITwitterUserRepository
    {
        TwitterUser Find(string email);
        void Remove(string email);
        TwitterUser Add(TwitterUser user);
    }
}