﻿using System;
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
            DSCSYSEntities SYSDb = new DSCSYSEntities();
            string sql = "Select MA001 S1,MA003 S2 FROM DSCMA Where MA001 =@MA001";
            SqlParameter parameter = new SqlParameter("@MA001", SqlDbType.Char, 10) { Value = username };
            PublicDataModuls userModel = SYSDb.Database.SqlQuery<PublicDataModuls>(sql, parameter).FirstOrDefault();
            ResultMsg resultMsg = new ResultMsg();
            if (userModel == null)
            {
                resultMsg.info = "无此用户名";
                return Json(resultMsg, JsonRequestBehavior.AllowGet);
            }
            if (YfUser.Encode7(YfUser.EnUser(username.ToCharArray()),password.ToCharArray()) != userModel.S2)
            {
                resultMsg.info = "密码错误";
                return Json(resultMsg, JsonRequestBehavior.AllowGet);
            }

            resultMsg.info = "成功登录";
            resultMsg.status = true;
            resultMsg.url = "/";
            return Json(resultMsg, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// 增加签名
        /// 
        /// </summary>
        /// <param name="username"></param>
        /// <param name="password"></param>
        /// <returns></returns>

        public ActionResult LoginApi(String username, String password)
        {
            password = decodePass(password);
            DSCSYSEntities SYSDb = new DSCSYSEntities();
            string sql = "Select MA001 S1,MA003 S2 FROM DSCMA Where MA001 =@MA001";
            SqlParameter parameter = new SqlParameter("@MA001", SqlDbType.Char, 10) { Value = username };
            PublicDataModuls userModel = SYSDb.Database.SqlQuery<PublicDataModuls>(sql, parameter).FirstOrDefault();
            ResultMsg resultMsg = new ResultMsg();
            if (userModel == null)
            {
                resultMsg.info = "无此用户名";
                return Json(resultMsg, JsonRequestBehavior.AllowGet);
            }
            if (YfUser.Encode7(YfUser.EnUser(username.ToCharArray()), password.ToCharArray()) != userModel.S2)
            {
                resultMsg.info = "密码错误";
                return Json(resultMsg, JsonRequestBehavior.AllowGet);
            }

            resultMsg.info = "成功登录";
            resultMsg.status = true;
            long saveTicks = DateTime.Now.Ticks;
            resultMsg.signature = GetSignature(saveTicks.ToString(), "1", "A1B2C3D4");
            //保存签名到数据库
            return Json(resultMsg, JsonRequestBehavior.AllowGet);
        }

        //根据时间戳，随机数，用户定义tokon生成加密签名signature 借用微信签名算法
        //加密签名通过SHA1算法加密
        private static string GetSignature(string timestamp, string nonce, string token)
        {
            string[] ArrTmp = { token, timestamp, nonce };
            Array.Sort(ArrTmp);     //字典排序
            string tmpStr = string.Join("", ArrTmp);
            tmpStr = System.Web.Security.FormsAuthentication.HashPasswordForStoringInConfigFile(tmpStr, "SHA1");
            tmpStr = tmpStr.ToLower();
            return tmpStr;
        }

        /// <summary>
        /// 解码传输过来的密码，算法自己实现
        /// </summary>
        /// <param name="password"></param>
        /// <returns></returns>
        private static string decodePass(string password)
        {
            //应该由你实现的密码解密，加密在客户端实现
            return password;
        }

        private class ResultMsg
        {
            public Boolean status;
            public string info;
            public string url;
            public string signature;
            public ResultMsg()
            {
                this.status = false;
                info = "";
                url = "/";
                signature = "";
            }
        }
       

    }
}
