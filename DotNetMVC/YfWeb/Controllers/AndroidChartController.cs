using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using YfWeb.Common;
using YfWeb.Models.Android;
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
            return Json(AndroidChartModel.saleLine(), JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// 
        /// 生成业务员销售饼图
        /// </summary>
        /// <returns></returns>

        public ActionResult salerPie()
        {

            return Json(AndroidChartModel.salerPie(), JsonRequestBehavior.AllowGet);
        }

    }
}
