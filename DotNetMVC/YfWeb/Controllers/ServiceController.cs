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
            int page;
            try
            {
                page = Int32.Parse(p);
            }
            catch
            {
                page = 1;
            }
            string sql = "select MC001,MC002,MC007,MC008,MC014,MB002,MB003 "
                + " FROM INVMC JOIN INVMB ON MB001 = MC001 "
                + " WHERE MC007>0";


            if (MC001 != "")
            {
                sql = sql + " and MC001 LIKE @MC001";
            }

            if (MC002 != "")
            {
                sql = sql + " and MC002 LIKE @MC002";
            }

            if (MB002 != "")
            {
                sql = sql + " and MB002 LIKE @MB002";
            }

            if (MB003 != "")
            {
                sql = sql + " and MB003 LIKE @MB003";
            }
            SqlParameter[] parameters = new SqlParameter[] 
            { 
                new SqlParameter("@MC001","%"+MC001+"%"),
                new SqlParameter("@MC002","%"+MC002+"%"),
                new SqlParameter("@MB002","%"+MB002+"%"),
                new SqlParameter("@MB003","%"+MB003+"%"),

            };
            List<Invmc> data = db.Database.SqlQuery<Invmc>(sql, parameters).Skip((page - 1) * 30).Take(30).ToList();
            return Json(data, JsonRequestBehavior.AllowGet);
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
            int page = 1;
            try
            {
                page = Int32.Parse(p);
            }
            catch
            {
                page = 1;
            }

            string sql = "Select  TD001 +'-' + TD002 + '-' +TD003  S1,"
                         + "TD004 S2,TD005 S3,TD006 S4,"
                         + "TD008 D1,TD009 D2 "
                         + " FROM COPTD INNER JOIN COPTC ON TC001 = TD001 AND TC002 = TD002 "
                         + " WHERE 1=1 "
                         + " AND  TD001+TD002+TD003 like @TD001"
                         + " AND TD005 like @TD005"
                         + " AND TD006 like @TD006";
            SqlParameter[] parameters = new SqlParameter[] 
            { 
                new SqlParameter("@TD001","%"+TD001+"%"),
                new SqlParameter("@TD005","%"+TD005+"%"),
                new SqlParameter("@TD006","%"+TD006+"%"),

            };
            List<PublicDataModuls> data = db.Database.SqlQuery<PublicDataModuls>(sql, parameters).Skip((page - 1) * 10).Take(10).ToList();
            return Json(data, JsonRequestBehavior.AllowGet);

        }


        public ActionResult cmsmv(FormCollection form)
        {
            string sql = "Select TOP 10 MV002  S1,"
                         + "MV016 S2,MV020 S3,ME002 S4 "
                         + " FROM CMSMV INNER JOIN CMSME ON ME001 = MV004 "
                         + "";
            List<PublicDataModuls> data = db.Database.SqlQuery<PublicDataModuls>(sql).ToList();
            return Json(data, JsonRequestBehavior.AllowGet);
        }

    }
}
