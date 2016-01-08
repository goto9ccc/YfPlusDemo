using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using YfWeb.Common;
using YfWeb.Models;
using YfWeb.Models.Bean;
using YfWeb.Models.DB;
using YfWeb.Models.Home;

namespace YfWeb.Controllers
{
    public class HomeController : BaseController
    {
        //
        // GET: /Home/
        [UserAuthorize]
        public ActionResult Index()
        {
            return View();
        }

        [UserAuthorize]
        public ActionResult List()
        {
            return View();
        }


        [HttpGet]
        public ActionResult Login()
        {
            return View();
        }

        /// <summary>
        /// 登录，请在内网使用
        /// 如果用于外网，应在客户端加密密码，后端解密
        /// 且访问API应提交签名，后面有简单示例
        /// </summary>
        /// <param name="username"></param>       
        /// <param name="password"></param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult Login(String username,String password)
        {
            HomeModel.ResultMsg resultMsg = HomeModel.login(username, password);
            if (resultMsg.status)
            {
                HttpCookie cookie = new HttpCookie("User");
                cookie.Values.Add("name", username);
                cookie.Values.Add("token", Signature.GetSignature("12345678", "ABCDEFG", username));
                Response.Cookies.Add(cookie);                
            }
            return Json(resultMsg, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// 增加签名演示，DEMO中没有使用
        /// 
        /// </summary>
        /// <param name="username"></param>
        /// <param name="password"></param>
        /// <returns></returns>

        public ActionResult LoginApi(String username, String password)
        {
            password = decodePass(password);
            HomeModel.ResultMsg resultMsg = HomeModel.login(username, password);
            long saveTicks = DateTime.Now.Ticks;
            resultMsg.signature = Signature.GetSignature(saveTicks.ToString(), "1", "A1B2C3D4");
            //保存签名到数据库
            return Json(resultMsg, JsonRequestBehavior.AllowGet);
        }



        /// <summary>
        /// 解码传输过来的密码，算法你去实现
        /// </summary>
        /// <param name="password"></param>
        /// <returns></returns>
        private  string decodePass(string password)
        {
            //应该由你实现的密码解密，加密在客户端实现，避免在客户端明文传输密码
            return password;
        }

       
       

    }
}
