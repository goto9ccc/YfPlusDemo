using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using YfWeb.Common;
using YfWeb.Models.DataModels;
using YfWeb.Models.Inv;

namespace YfWeb.Controllers
{
    public class InvController : WebBaseController
    {
        //
        // GET: /Inv/

        public ActionResult Index(string MC001 = "", string MB002 = "", string MB003 = "", string MC002 = "",
            int PageIndex = 1, int pageSize = 20, int isFirst = Constant.NO_FIRST)
        {

            if (isFirst == Constant.IS_FIRST)
                return View(new List<INVMC_INVMB>());

            string sqlStr = "Select MC001,MC002,MB002,MB003,MC007,MC008,MC014 From INVMC "
                                    + "inner join INVMB ON MB001 = MC001 "
                                    + "Where  MC007 <> 0 AND MC001 Like @MC001"
                                    + " AND MC002 like @MC002"
                                    + " AND MB002 like @MB002"
                                    + " AND MB003 like @MB003"
                                    + " ";
            SqlParameter[] para = new SqlParameter[] 
            { 
                new SqlParameter("@MC001","%"+MC001+"%"),
                new SqlParameter("@MC002","%"+MC002+"%"),
                new SqlParameter("@MB002","%"+MB002+"%"),
                new SqlParameter("@MB003","%"+MB003+"%")
            };

            var invmc = db.Database.SqlQuery<INVMC_INVMB>(sqlStr, para);
            int pageCount = 1;
            int rocodeCount = 0;
            //总记录数
            rocodeCount = db.Database.SqlQuery<INVMC_INVMB>(sqlStr, new SqlParameter[] 
            { 
                new SqlParameter("@MC001","%"+MC001+"%"),
                new SqlParameter("@MC002","%"+MC002+"%"),
                new SqlParameter("@MB002","%"+MB002+"%"),
                new SqlParameter("@MB003","%"+MB003+"%")
            }).Count();
            //总页数
            pageCount = Page_Helper.CountPage(pageSize, rocodeCount);
            ViewBag.pageCount = pageCount;
            ViewBag.pageIndex = PageIndex;
            ViewBag.pageSize = pageSize;
            ViewBag.MC001 = MC001;
            ViewBag.MB002 = MB002;
            ViewBag.MB003 = MB003;
            ViewBag.MC002 = MC002;
            //总记录数量与包装数量 合计
            ViewBag.MC007Sum = db.Database.SqlQuery<INVMC_INVMB>(sqlStr, new SqlParameter[] 
            { 
                new SqlParameter("@MC001","%"+MC001+"%"),
                new SqlParameter("@MC002","%"+MC002+"%"),
                new SqlParameter("@MB002","%"+MB002+"%"),
                new SqlParameter("@MB003","%"+MB003+"%")
            }).Sum(u => u.MC007);
            ViewBag.MC014Sum = db.Database.SqlQuery<INVMC_INVMB>(sqlStr, new SqlParameter[] 
            { 
                new SqlParameter("@MC001","%"+MC001+"%"),
                new SqlParameter("@MC002","%"+MC002+"%"),
                new SqlParameter("@MB002","%"+MB002+"%"),
                new SqlParameter("@MB003","%"+MB003+"%")
            }).Sum(u => u.MC014);
            //单页数量与包装数量 小计
            ViewBag.MC007PageSum = db.Database.SqlQuery<INVMC_INVMB>(sqlStr, new SqlParameter[] 
            { 
                new SqlParameter("@MC001","%"+MC001+"%"),
                new SqlParameter("@MC002","%"+MC002+"%"),
                new SqlParameter("@MB002","%"+MB002+"%"),
                new SqlParameter("@MB003","%"+MB003+"%")
            }).Skip((PageIndex - 1) * pageSize).Take(pageSize).Sum(u => u.MC007);
            ViewBag.MC014PageSum = db.Database.SqlQuery<INVMC_INVMB>(sqlStr, new SqlParameter[] 
            { 
                new SqlParameter("@MC001","%"+MC001+"%"),
                new SqlParameter("@MC002","%"+MC002+"%"),
                new SqlParameter("@MB002","%"+MB002+"%"),
                new SqlParameter("@MB003","%"+MB003+"%")
            }).Skip((PageIndex - 1) * pageSize).Take(pageSize).Sum(u => u.MC014);
            List<INVMC_INVMB> invmcList = invmc.Skip((PageIndex - 1) * pageSize).Take(pageSize).ToList();
            return View(invmcList);
        }


        /// <summary>
        /// 查批号库存
        /// </summary>
        /// <param name="MC001"></param>
        /// <param name="MC002"></param>
        /// <returns></returns>
        [UserAuthorize]
        public ActionResult Partial_INVMF(string MC001 = "", string MC002 = "")
        {
            try
            {
                if ((MC001 != "") || (string.IsNullOrEmpty(MC001)) == false)
                {
                    String sql = "Select MF001 S1,MF002 S2,MF007 S3,"
                            + "MF010 D1,MF014 D2 from INVMF "
                            + "Where MF001 =@MC001 AND MF002 like @MC002 AND MF010>0";
                    SqlParameter[] sqlParameters = new SqlParameter[]
                    {
                        new SqlParameter("@MC001",MC001),
                        new SqlParameter("@MC002","%"+MC002+"%"),
                    };
                    List<PublicDataModuls> invmfList = db.Database.SqlQuery<PublicDataModuls>(sql, sqlParameters).ToList();
                    ViewBag.invmf = invmfList;
                    return PartialView();
                }
            }
            catch (Exception)
            {
                return PartialView();
                throw;
            }
            return Json("error", JsonRequestBehavior.AllowGet); ;
        }
        /// <summary>
        /// 品号库位查询
        /// </summary>
        /// <param name="MC001"></param>
        /// <param name="MC002"></param>
        /// <returns></returns>
        [UserAuthorize]
        public ActionResult Partial_INVML(string MC001 = "", string MC002 = "")
        {
            try
            {
                if ((MC001 != "") || (string.IsNullOrEmpty(MC001)) == false)
                {
                    String sql = "Select ML001 S1,ML002 S2,ML003 S3,ML004 S4"
                            + "ML005 D1,ML006 D2 from INVML "
                            + "Where ML001 =@MC001 AND ML002 like @MC002 AND ML005>0";
                    SqlParameter[] sqlParameters = new SqlParameter[]
                    {
                        new SqlParameter("@MC001",MC001),
                        new SqlParameter("@MC002","%"+MC002+"%"),
                    };
                    List<PublicDataModuls> invmlList = db.Database.SqlQuery<PublicDataModuls>(sql, sqlParameters).ToList();
                    ViewBag.invml = invmlList;
                    return PartialView();
                }
            }
            catch (Exception)
            {
                return PartialView();
                throw;
            }
            return Json("error", JsonRequestBehavior.AllowGet); ;
        }
        /// <summary>
        /// 品号几大量计算
        /// </summary>
        /// <param name="MC001"></param>
        /// <returns></returns>
        [UserAuthorize]
        public ActionResult Partial_inv_n(string MC001 = "")
        {
            //try
            //{
                if ((MC001 != "") || (string.IsNullOrEmpty(MC001)) == false)
                {
                    var data = new GetNModels(MC001).getData();
                    SqlParameter sqlParameter = new SqlParameter("@MC001", MC001);
                    ViewBag.sumCOPTD = data.sumCOPTD;
                    ViewBag.sumCOPMF = data.sumCOPMF;
                    ViewBag.sumPURTD = data.sumPURTD;
                    ViewBag.sumMOCTA = data.sumMOCTA;
                    ViewBag.sumMOCTB = data.sumMOCTB;
                    return PartialView();
                }
            //}
            //catch (Exception)
            //{
            //    return PartialView();
            //    throw;
            //}
            return Json("error", JsonRequestBehavior.AllowGet); ;
        }


    }
}
