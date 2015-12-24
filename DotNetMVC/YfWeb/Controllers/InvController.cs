using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using YfWeb.Common;
using YfWeb.Models.DataModels;

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
            //try
            //{
            //    if ((MC001 != "") || (string.IsNullOrEmpty(MC001)) == false)
            //    {

            //        var invml = (from ml in erp.INVML
            //                     where ml.ML001 == MC001 && ml.ML002.Contains(MC002) && ml.ML005 != 0
            //                     select ml);
            //        List<INVML> invmlList = invml.ToList();
            //        ViewBag.invml = invmlList;
            //        return PartialView();
            //    }
            //}
            //catch (Exception)
            //{
            //    return PartialView();
            //    throw;
            //}
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
            //    if ((MC001 != "") || (string.IsNullOrEmpty(MC001)) == false)
            //    {
            //        //未交货订单
            //        var coptd = (from td in erp.COPTD
            //                     where td.TD004 == MC001 && td.TD008 + td.TD024 > td.TD009 + td.TD025 + td.TD058 && td.TD016 == "N" && td.TD021 == "Y"
            //                     select td);

            //        ViewBag.sumCOPTD = coptd.Sum(u => u.TD008 - u.TD009);
            //        if (ViewBag.sumCOPTD == null)
            //            ViewBag.sumCOPTD = 0;
            //        //未完成销售预测
            //        var copmf = (from mf in erp.COPMF
            //                     where mf.MF003 == MC001 && mf.MF008 > mf.MF009
            //                     select mf);

            //        ViewBag.sumCOPMF = copmf.Sum(u => u.MF008 - u.MF009);
            //        if (ViewBag.sumCOPMF == null)
            //            ViewBag.sumCOPMF = 0;
            //        //未达成采购
            //        var purtd = (from td in erp.PURTD
            //                     where td.TD004 == MC001 && td.TD016 == "N"
            //                     select td);

            //        ViewBag.sumPURTD = purtd.Sum(u => u.TD008 - u.TD015);
            //        if (ViewBag.sumPURTD == null)
            //            ViewBag.sumPURTD = 0;
            //        //未入库工单
            //        var mocta = (from ta in erp.MOCTA
            //                     where ta.TA006 == MC001 && ta.TA011 != "Y" && ta.TA011 != "y"
            //                     select ta);
            //        ViewBag.sumMOCTA = mocta.Sum(u => u.TA015 - u.TA017);
            //        if (ViewBag.sumMOCTA == null)
            //            ViewBag.sumMOCTA = 0;
            //        //预计领用
            //        var moctb = (from ta in erp.MOCTA
            //                     join tb in erp.MOCTB on ta.TA001 + ta.TA002 equals tb.TB001 + tb.TB002
            //                     where tb.TB003 == MC001 && ta.TA011 != "Y" && ta.TA011 != "y" && tb.TB004 - tb.TB005 > 0
            //                     select tb);
            //        ViewBag.sumMOCTB = moctb.Sum(u => u.TB004 - u.TB005);
            //        if (ViewBag.sumMOCTB == null)
            //            ViewBag.sumMOCTB = 0;
            //        return PartialView();
            //    }
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
