using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using YfWeb.Common;
using YfWeb.Models.Bean;
using YfWeb.Models.Board;

namespace YfWeb.Controllers
{
    public class BoardController : BaseController
    {
        //
        // GET: /Board/

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Purtb(String TB011 = "")
        {
            return Json(BoardModel.Purtb(TB011), JsonRequestBehavior.AllowGet);            
        }

    }
}
