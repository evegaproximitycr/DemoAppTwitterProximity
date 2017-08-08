using Demo.Dao.Models;
using Demo.Dao.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Demo.Business.Services
{
    public class ConfigAppService
    {
        IConfigAppRepository _repository = new ConfigAppRepository();

        public ConfigApp GetConfigurationForApp(string appName)
        {
            return _repository.Find(appName);
        }
    }
}