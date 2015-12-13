using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using YfWeb.Common;
using YfWeb.Models;

namespace YfWeb.Controllers
{
    public class BarcodeController : BaseController
    {
        //
        // GET: /Barcode/

        [HttpPost]
        public ActionResult PostBar(String barcode)
        {
            try
            {
                A_BARCODE data = new A_BARCODE();
                data.BARCODE = barcode;
                db.A_BARCODE.Add(data);
                db.SaveChanges();
                var msg = new
                {
                    status = true,
                    msg = "成功提交到数据库，条码为："+barcode
                };
                return Json(msg, JsonRequestBehavior.AllowGet);
            }
            catch (Exception)
            {
                var msg = new
                {
                    status = false,
                    msg = "保存失败，请检查是否存在对应的表"
                };
                return Json(msg, JsonRequestBehavior.AllowGet);
            }

            
            
        }


        public ActionResult Index()
        {
            return View();
        }

    }
}
