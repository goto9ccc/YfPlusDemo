using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Mvc;
using YfWeb.Models;

namespace YfWeb.Common
{
    public class BaseController : Controller
    {
        protected DEMOEntities db = new DEMOEntities();
    }
}
