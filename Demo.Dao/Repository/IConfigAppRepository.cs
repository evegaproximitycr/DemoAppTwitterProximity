using Demo.Dao.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Demo.Dao.Repository
{
    public interface IConfigAppRepository
    {
        ConfigApp Find(string appName);
    }
}