using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace YfWeb.Common
{
    public class Constant
    {
        /// <summary>
        /// 下架
        /// </summary>
        public const int UNDER = 0;
        /// <summary>
        /// 上架
        /// </summary>
        public const int GORUND = 1;
        /// <summary>
        /// 显示
        /// </summary>
        public const int SHOW = 1;
        /// <summary>
        /// 隐藏
        /// </summary>
        public const int HIDE = 0;
        /// <summary>
        /// 第一次打开链接
        /// </summary>

        public const int IS_FIRST = 1;
        /// <summary>
        ///非第一次打开链接
        /// </summary>

        public const int NO_FIRST = 0;
    }

}