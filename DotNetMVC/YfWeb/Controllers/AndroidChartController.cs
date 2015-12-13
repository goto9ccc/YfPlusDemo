using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using YfWeb.Common;
using YfWeb.Models.DataModels;

namespace YfWeb.Controllers
{
    public class AndroidChartController : BaseController
    {
        //
        // GET: /AndroidChart/

        public ActionResult Index()
        {
            return View();
        }


        public ActionResult saleline()
        {
            string sql = "Select TG003 S1,sum(TG045)+sum(TG046) D1 from COPTG"
                + " Where TG023 = 'Y' "
                + " Group by TG003 order by TG003 ";
            int count = db.Database.SqlQuery<PublicDataModuls>(sql).Count();
            List<PublicDataModuls> data = db.Database.SqlQuery<PublicDataModuls>(sql).ToList();
            var result = new
            {
                count,
                data
            };

            return Json(result,JsonRequestBehavior.AllowGet);
        }

    }
}
