using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using YfWeb.Common;
using YfWeb.Models.DataModels;

namespace YfWeb.Controllers
{
    public class WebServiceController : BaseController
    {
        //
        // GET: /WebService/

        public ActionResult Index()
        {
            return View();
        }


        public ActionResult day_in_inv(string type = "day")
        {
            string sqlStr = "Select MOCTG.TG001 S1, MOCTG.TG011 D1,MOCTG.TG025 D2 FROM MOCTF "
                                  + " left join MOCTG ON TF001 = TG001 AND TF002 = TG002 "
                                  + " Where TF012 = '"
                                  + DateTime.Now.ToString("yyyyMMdd")
                                  + "' ";
            switch (type)
            {
                default:
                    break;
                case "month": sqlStr = "Select MOCTG.TG001 S1, MOCTG.TG011 D1,MOCTG.TG025 D2 FROM MOCTF "
                                   + " left join MOCTG ON TF001 = TG001 AND TF002 = TG002 "
                                   + " Where TF012 >= '"
                                   + DateTime.Now.ToString("yyyyMM")
                                   + "01' and TF012 <=  '"
                                  + DateTime.Now.ToString("yyyyMMdd")
                                  + "' ";
                    break;
                case "year": sqlStr = "Select MOCTG.TG001 S1, MOCTG.TG011 D1,MOCTG.TG025 D2 FROM MOCTF "
                       + " left join MOCTG ON TF001 = TG001 AND TF002 = TG002 "
                       + " Where TF012 >= '"
                       + DateTime.Now.ToString("yyyy")
                       + "0101' and TF012 <=  '"
                      + DateTime.Now.ToString("yyyyMMdd")
                      + "' ";
                    break;
            }
            try
            {
                var moctgList = db.Database.SqlQuery<PublicDataModuls>(sqlStr);
                var moctgGroup = moctgList.GroupBy(u => u.S1).Select(g => new
                {
                    S1 = g.Key,
                    D1 = g.Sum(x => x.D1),
                    D2 = g.Sum(x => x.D2)
                }).OrderByDescending(U => U.D1);
                return Json(moctgGroup, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(ex.ToString(), JsonRequestBehavior.AllowGet);
                throw;
            }
        }

    }
}
