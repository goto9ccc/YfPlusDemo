using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using YfWeb.Common;
using YfWeb.Models.Bean;
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
            InvModels invModels = new InvModels();
            InvModels.InvBean invBean = invModels.getData(MC001, MB002, MB003, MC002, PageIndex, pageSize);
            ViewBag.pageCount = invBean.pageCount;
            ViewBag.pageIndex = invBean.pageIndex;
            ViewBag.pageSize = invBean.pageSize;
            ViewBag.MC001 = invBean.MC001;
            ViewBag.MB002 = invBean.MB002;
            ViewBag.MB003 = invBean.MB003;
            ViewBag.MC002 = invBean.MC002;
            //总记录数量与包装数量 合计
            ViewBag.MC007Sum = invBean.MC007Sum;
            ViewBag.MC014Sum = invBean.MC014Sum;
            ViewBag.MC007PageSum = invBean.MC007PageSum;
            ViewBag.MC014PageSum = invBean.MC014PageSum;
            return View(invBean.invmcList);
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

                    ViewBag.invmf = new InvModels().getInvmfData(MC001,MC002);
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

                    ViewBag.invml = new InvModels().getInvmlData(MC001, MC002);
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
