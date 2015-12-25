using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using YfWeb.Common;
using YfWeb.Models.Bean;

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



        /// <summary>
        /// 生成销售数据图
        /// </summary>
        /// <returns></returns>

        public ActionResult saleline()
        {
            string sql = "Select TG003 S1,sum(TG045)+sum(TG046) D1 from COPTG"
                + " Where TG023 = 'Y' "
                + " Group by TG003 order by TG003 ";
            int count = db.Database.SqlQuery<PublicDataModuls>(sql).Count();
            List<PublicDataModuls> data = db.Database.SqlQuery<PublicDataModuls>(sql).ToList();
            //添加一点测试数据

            for (int i = 1; i < 10; i++)
            {
                data.Add(new PublicDataModuls() {S1 = "201512"+i.ToString("00"),D1 = new Random(i).Next(1000,10000)});
            }

            var result = new
            {
                count,
                data
            };
            return Json(result,JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// 
        /// 生成业务员销售饼图
        /// </summary>
        /// <returns></returns>

        public ActionResult salerPie()
        {
            string sql = "Select MV002  S1,sum(TH013) D1 from COPTH "
                    + " LEFT JOIN COPTG on TH001=TG001 AND TH002=TG002  "
                    + " LEFT JOIN CMSMV ON TG006 = MV001 "
                    + " Where TG003 like left(CONVERT(varchar(100), GETDATE(), 112),6)+'%' "
                    + " Group by MV002 order by sum(TH013) desc ";
            int count = db.Database.SqlQuery<PublicDataModuls>(sql).Count();
            List<PublicDataModuls> data = db.Database.SqlQuery<PublicDataModuls>(sql).ToList();
            //添加一点测试数据


            data.Add(new PublicDataModuls() { S1 = "张大牛", D1 = 1435343.23M });
            data.Add(new PublicDataModuls() { S1 = "张老牛", D1 = 2345343.23M });
            var result = new
            {
                count,
                data
            };
            return Json(result, JsonRequestBehavior.AllowGet);
        }

    }
}
