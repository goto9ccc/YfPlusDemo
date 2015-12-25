using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using YfWeb.Common;
using YfWeb.Models.Bean;

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
            string sql = "Select SUM(TB009) AS D1,Right(TB011,2) S1 ,TB011 as S2,Count(TB001) as D2 "
                + " from PURTB Where TB039 = ''N'' AND TB011 Like @TB011 group by TB011";
            if (TB011 == "")
            {
                TB011 = DateTime.Now.ToString("yyyyMM");
            }
            SqlParameter parameter = new SqlParameter("@TB011", TB011 + "%");
            List<PublicDataModuls> data = db.Database.SqlQuery<PublicDataModuls>(sql,parameter).ToList();
            return Json(data, JsonRequestBehavior.AllowGet);            
        }

    }
}
