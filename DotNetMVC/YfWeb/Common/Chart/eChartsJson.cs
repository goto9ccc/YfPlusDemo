using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace YfWeb.Common.Chart
{
    /// <summary>
    /// echart  bar 标准柱形图 的实例类 ,从 eChartsBase中继承
    /// 两个泛型参数,第一个泛型类参数为X轴，第二个为Y轴
    /// </summary>
    #region 竖形条图与横道图类
    public class eChartBarJson<T, V, S> : eChartsBase
    {
        /// <summary>
        /// X轴
        /// </summary>
        public List<eChartxAxis<T>> xAxis { get; set; }
        /// <summary>E:\SVN\dotnetYf\YfWeb\YfWeb\Views\Web.config
        /// Y轴
        /// </summary>
        public List<eChartyAxis<V>> yAxis { get; set; }
        /// <summary>
        /// 系列
        /// </summary>
        public List<eChartSeries<S>> series { get; set; }
        /// <summary>
        /// 构造函数
        /// </summary>
        public eChartBarJson()
        {
            xAxis = new List<eChartxAxis<T>>();
            yAxis = new List<eChartyAxis<V>>();
            series = new List<eChartSeries<S>>();
        }

    }
    #endregion
    /// <summary>
    /// 饼图与指标图类
    /// 请将系列的type设置为pie 或 gauge
    /// </summary>
    #region 2、饼图与指标图类
    public class eChartPie : eChartsBase
    {
        /// <summary>
        /// 系列  饼图系列与其他系列不同
        /// </summary>
        public List<eChartSeries<pieDate>> series { get; set; }
        /// <summary>
        /// 构造函数
        /// </summary>
        public eChartPie()
        {
            series = new List<eChartSeries<pieDate>>();
        }

    }
    #endregion

}