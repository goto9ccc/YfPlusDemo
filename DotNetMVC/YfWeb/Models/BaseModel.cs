using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using YfWeb.Models.DB;

namespace YfWeb.Models
{
    public class BaseModel
    {
        protected static DEMOEntities db = new DEMOEntities();

    }
}