using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Mvc;
using YfWeb.Common;
using YfWeb.Models;
using YfWeb.Models.Bean;
using YfWeb.Models.Service;

namespace YfWeb.Controllers
{
    public class ServiceController : BaseController
    {


        /// <summary>
        /// 工单查询API
        /// </summary>
        /// <param name="p"></param>
        /// <param name="MC001"></param>
        /// <param name="MC002"></param>
        /// <param name="MB002"></param>
        /// <param name="MB003"></param>
        /// <returns></returns>

        public ActionResult Index(string p, string MC001 = "", string MC002 = "", string MB002 = "", string MB003 = "")
        {
            SqlParameter[] parameters = new SqlParameter[] 
            { 
                new SqlParameter("@MC001","%"+MC001+"%"),
                new SqlParameter("@MC002","%"+MC002+"%"),
                new SqlParameter("@MB002","%"+MB002+"%"),
                new SqlParameter("@MB003","%"+MB003+"%"),

            };
            return Json(ServiceModel.getInvmcList(parameters,p), JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// 
        /// 订单查询API
        /// </summary>
        /// <param name="p"></param>
        /// <param name="TD001"></param>
        /// <param name="TD005"></param>
        /// <param name="TD006"></param>
        /// <returns></returns>
        public ActionResult Order(string p, string TD001 = "", string TD005 = "", string TD006 = "")
        {

            SqlParameter[] parameters = new SqlParameter[] 
            { 
                new SqlParameter("@TD001","%"+TD001+"%"),
                new SqlParameter("@TD005","%"+TD005+"%"),
                new SqlParameter("@TD006","%"+TD006+"%"),

            };

            return Json(ServiceModel.getOrderList(parameters,p), JsonRequestBehavior.AllowGet);

        }


        public ActionResult cmsmv(FormCollection form)
        {
            string sql = "Select TOP 10 MV002  S1,"
                         + "MV016 S2,MV020 S3,ME002 S4 "
                         + " FROM CMSMV INNER JOIN CMSME ON ME001 = MV004 "
                         + "";
            List<PublicDataModul> data = db.Database.SqlQuery<PublicDataModul>(sql).ToList();
            return Json(data, JsonRequestBehavior.AllowGet);
        }

    }
}
