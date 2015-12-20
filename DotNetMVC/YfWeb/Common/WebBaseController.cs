using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace YfWeb.Common
{


    /// <summary>
    /// 需要登录验证的控制器应该从此派生
    /// QQ:691415
    /// 作者：宋锦程
    /// </summary>
    [UserAuthorize]
    public class WebBaseController:BaseController
    {
    }
}