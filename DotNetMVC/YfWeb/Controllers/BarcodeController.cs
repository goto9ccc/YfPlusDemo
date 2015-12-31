using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using YfWeb.Common;
using YfWeb.Models;
using YfWeb.Models.Barcode;
using YfWeb.Models.DB;

namespace YfWeb.Controllers
{
    public class BarcodeController : BaseController
    {
        //
        // GET: /Barcode/

        [HttpPost]
        public ActionResult PostBar(String barcode)
        {   
            return Json(BarcodeModel.postBar(barcode), JsonRequestBehavior.AllowGet); 
        }


        public ActionResult Index()
        {
            return View();
        }

    }
}
