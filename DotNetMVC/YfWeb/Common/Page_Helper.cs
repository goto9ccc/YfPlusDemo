using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace YfWeb.Common
{
    public static class Page_Helper
    {
        /// <summary>
        /// 计算总页数
        /// </summary>
        /// <param name="pageSize">每页记录数</param>
        /// <param name="rocodeCount">总记录数</param>
        /// <returns>页数</returns>
        public static int CountPage(int pageSize, int rocodeCount)
        {
            int pageCount = 0;
            if ((rocodeCount % pageSize) > 0)
            {
                pageCount = (rocodeCount / pageSize) + 1;
            }
            else
            {
                pageCount = (rocodeCount / pageSize);
            }
            return pageCount;
        }
        /// <summary>
        /// 读取客户cookie并返回客户ID
        /// </summary>
        /// <param name="Request"></param>
        /// <returns></returns>
        public static string ReadCustomerIDCookie(HttpRequestBase Request)
        {
            HttpCookie _cookie = Request.Cookies["Customer"];
            string _userName = _cookie["Customer_ID"];
            return _userName;
        }
        /// <summary>
        /// 在页面加载前输出
        /// </summary>
        public static void pageLoading()
        {
            HttpContext.Current.Response.Write(" <script language=JavaScript type=text/javascript>");
            HttpContext.Current.Response.Write("var t_id = setInterval(animate,20);");
            HttpContext.Current.Response.Write("var pos=0;var dir=2;var len=0;");
            HttpContext.Current.Response.Write("function animate(){");
            HttpContext.Current.Response.Write("var elem = document.getElementByIdx_x_x('progress');");
            HttpContext.Current.Response.Write("if(elem != null) {");
            HttpContext.Current.Response.Write("if (pos==0) len += dir;");
            HttpContext.Current.Response.Write("if (len>32 || pos>79) pos += dir;");
            HttpContext.Current.Response.Write("if (pos>79) len -= dir;");
            HttpContext.Current.Response.Write(" if (pos>79 && len==0) pos=0;");
            HttpContext.Current.Response.Write("elem.style.left = pos;");
            HttpContext.Current.Response.Write("elem.style.width = len;");
            HttpContext.Current.Response.Write("}}");
            HttpContext.Current.Response.Write("function remove_loading() {");
            HttpContext.Current.Response.Write(" this.clearInterval(t_id);");
            HttpContext.Current.Response.Write("var targelem = document.getElementByIdx_x_x('loader_container');");
            HttpContext.Current.Response.Write("targelem.style.display='none';");
            HttpContext.Current.Response.Write("targelem.style.visibility='hidden';");
            HttpContext.Current.Response.Write("}");
            HttpContext.Current.Response.Write("</script>");
            HttpContext.Current.Response.Write("<style>");
            HttpContext.Current.Response.Write("#loader_container {text-align:center; position:absolute; top:40%; width:100%; left: 0;}");
            HttpContext.Current.Response.Write("#loader {font-family:Tahoma, Helvetica, sans; font-size:11.5px; color:#000000; background-color:#FFFFFF; padding:10px 0 16px 0; margin:0 auto; display:block; width:130px; border:1px solid #5a667b; text-align:left; z-index:2;}");
            HttpContext.Current.Response.Write("#progress {height:5px; font-size:1px; width:1px; position:relative; top:1px; left:0px; background-color:#8894a8;}");
            HttpContext.Current.Response.Write("#loader_bg {background-color:#e4e7eb; position:relative; top:8px; left:8px; height:7px; width:113px; font-size:1px;}");
            HttpContext.Current.Response.Write("</style>");
            HttpContext.Current.Response.Write("<div id=loader_container>");
            HttpContext.Current.Response.Write("<div id=loader>");
            HttpContext.Current.Response.Write("<div align=center>查询正在执行中，休息一会 ...</div>");
            HttpContext.Current.Response.Write("<div id=loader_bg><div id=progress> </div></div>");
            HttpContext.Current.Response.Write("</div></div>");
            HttpContext.Current.Response.Flush();
        }

    }
}