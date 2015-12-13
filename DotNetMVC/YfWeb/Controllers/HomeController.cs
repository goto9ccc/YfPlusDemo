using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using YfWeb.Common;
using YfWeb.Models;
using YfWeb.Models.DataModels;

namespace YfWeb.Controllers
{
    public class HomeController : BaseController
    {
        //
        // GET: /Home/

        public ActionResult Index()
        {
            return View();
        }


        [HttpGet]
        public ActionResult Login()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Login(String username,String password)
        {


            DSCSYSEntities SYSDb = new DSCSYSEntities();
            string sql = "Select MA001 S1,MA003 S2 FROM DSCMA Where MA001 =@MA001";
            SqlParameter parameter = new SqlParameter("@MA001", SqlDbType.Char, 10) { Value = username };
            PublicDataModuls userModel = SYSDb.Database.SqlQuery<PublicDataModuls>(sql, parameter).FirstOrDefault();
            if (userModel == null)
            {
                var data = new
                {
                    status = false,
                    info = "无此用户名",
                    url = "/"
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            if (YfUser.Encode7(YfUser.EnUser(username.ToCharArray()),password.ToCharArray()) != userModel.S2)
            {
                var data = new
                {
                    status = false,
                    info = "密码错误",
                    url = "/"
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }

            var result = new
            {
                status = true,
                info = "成功登录",
                url = "/"

            };
            return Json(result, JsonRequestBehavior.AllowGet);
            

        }



    }
}
