using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace YfWeb.Common
{

    //作者：宋锦程
    //QQ:691415
    /// <summary>
    /// 用户验证控制类 可以写在基类控制器里
    /// 用户，角色权限控制可以扩充此类来实现
    /// </summary>
    public class UserAuthorizeAttribute : AuthorizeAttribute
    {

        protected override bool AuthorizeCore(HttpContextBase httpContext)
        {

            if (httpContext.Request.Cookies["User"] == null)
            {
                httpContext.Response.StatusCode = 403;
                return false;
            }

            HttpCookie cookie = httpContext.Request.Cookies["User"];
            string userName = cookie["name"];
            string token = cookie["token"];
            if (userName == "")
            {
                httpContext.Response.StatusCode = 403;
                return false;
            }
            if (token != Signature.GetSignature("12345678", "ABCDEFG", userName))
            {
                httpContext.Response.StatusCode = 403;
                return false;
            }
            
            return true;
        }


        public override void OnAuthorization(AuthorizationContext filterContext)
        {

            base.OnAuthorization(filterContext);
            if (filterContext.HttpContext.Response.StatusCode == 403)
                filterContext.Result = new RedirectResult("/home/login");
        }

    }
}