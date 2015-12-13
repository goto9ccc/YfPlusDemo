using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace YfWeb.Common.Chart
{
    public class eChartsBase
    {
        /// <summary>
        /// 图表标题对象
        /// </summary>
        public eChartTitle title { get; set; }
        /// <summary>
        /// 图表工具提示对象
        /// </summary>
        public eCharttooltip tooltip { get; set; }
        /// <summary>
        /// 图例对象
        /// </summary>
        public eChartlegend legend { get; set; }
        /// <summary>
        /// 图表工具箱对象
        /// </summary>
        public eCharttoolbox toolbox { get; set; }
        /// <summary>
        /// 重计算
        /// </summary>
        public bool calculable { get; set; }
        /// <summary>
        /// 默认的构造函数
        /// </summary>
        public eChartsBase()
        {
            title = new eChartTitle() { text = "", subtext = "" };
            tooltip = new eCharttooltip();
            legend = new eChartlegend();
            toolbox = new eCharttoolbox();
        }
    }


    /// <summary>
    /// //图表标题类 X坐标为left center right 默认为left
    /// 所有图表都有此属性
    /// </summary>
    public class eChartTitle
    {
        /// <summary>
        /// 标题文本
        /// </summary>
        public string text { get; set; }
        /// <summary>
        /// 子标题文本
        /// </summary>
        public string subtext { get; set; }
        /// <summary>
        /// 位置对象
        /// </summary>
        public string x { get; set; }
        /// <summary>
        /// 默认构造函数，默认为左边 left
        /// </summary>
        public eChartTitle()
        {
            x = "left";
        }
    }
    /// <summary>
    /// 图表提示类 默认为axis 另外可有item
    /// </summary>

    public class eCharttooltip
    {
        /// <summary>
        /// 
        /// </summary>
        public string trigger { get; set; }
        /// <summary>
        /// 显示
        /// </summary>
        public bool show { get; set; }
        public eCharttooltip()
        {
            trigger = "axis";
            show = true;
            //提示触发类型，可设置为item 默认为axis
        }
    }

    /// <summary>
    /// 图表图例类
    /// </summary>

    public class eChartlegend
    {
        /// <summary>
        /// 
        /// </summary>
        public List<string> data { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public eChartlegend()
        {
            data = new List<string>();
        }
    }

    //图表y轴类
    /// <summary>
    /// 默认y轴为值类型
    /// </summary>
    public class eChartyAxis<T>
    {
        /// <summary>
        /// Y轴类型
        /// </summary>
        public string type { get; set; }
        /// <summary>
        /// 泛型数据
        /// </summary>
        public List<T> data { get; set; }
        /// <summary>
        ///   category    value
        /// </summary>
        public eChartyAxis()
        {
            type = "value";
            data = new List<T>();
        }
    }

    /// <summary>
    /// 图表series类 可用List集合实现多系列，需要对应
    /// 泛型类   这是条形图与折线图系列
    /// 因为系列中data可以是float,int,字符串,JSON对象、多维数组等等
    /// </summary>

    public class eChartSeries<T>
    {
        /// <summary>
        /// 
        /// </summary>
        public string name { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string type { get; set; }
        /// <summary>
        /// 真为平滑，假为折线 取值true false
        /// </summary>

        public bool smooth { get; set; }
        /// <summary>
        /// 堆积标志，当系列标志相同时，进行堆积
        /// </summary>
        public string stack { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public eChartdetail detail { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public List<T> data { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public eChartSeries()
        {
            data = new List<T>();
            detail = new eChartdetail();
        }
    }


    //图表x轴类
    /// <summary>
    /// X轴默认为category,可设置为为value
    /// </summary>
    public class eChartxAxis<T>
    {
        /// <summary>
        /// 类型
        /// </summary>
        public string type { get; set; }
        /// <summary>
        /// 值
        /// </summary>
        public List<T> data { get; set; }
        /// <summary>
        /// 构造函数，默认为category
        /// </summary>
        public eChartxAxis()
        {
            data = new List<T>();
            type = "category";
        }
    }
    /// <summary>
    /// 保存图片按纽 eChartfeature
    /// </summary>
    public class eChartsaveAsImage
    {
        /// <summary>
        /// 
        /// </summary>
        public bool show { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public eChartsaveAsImage()
        {
            show = true;//默认显示保存为图片按纽   
        }
    }
    /// <summary>
    /// 重置标志 eChartfeature
    /// </summary>
    public class eChartrestore
    {
        /// <summary>
        /// 
        /// </summary>
        public bool show { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public eChartrestore()
        {
            show = true;
        }

    }
    /// <summary>
    /// 辅助线标志 eChartfeature中使用  
    /// </summary>
    public class eChartmark
    {
        /// <summary>
        /// 
        /// </summary>
        public bool show { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public eChartmark()
        {
            show = true;
            //默认显示
        }
    }
    /// <summary>
    /// 工具箱是数据视图类，为显示数据按纽,默认为显示
    /// </summary>
    public class eChartdataView
    {
        /// <summary>
        /// 
        /// </summary>
        public bool show { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public bool readOnly { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public eChartdataView()
        {
            show = true;
            readOnly = false; //默认显示，能改写
        }
    }
    /// <summary>
    /// 默认为显示，为工具箱切换按纽，有bar line等值可供选择
    /// </summary>
    public class eChartmagicType
    {
        /// <summary>
        /// 
        /// </summary>
        public bool show { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public List<string> type { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public eChartmagicType()
        {
            type = new List<string>();
            show = true; //默认为显示
        }
    }
    /// <summary>
    /// 工具箱按纽图列  上级类为eCharttoolbox  toolbox
    /// </summary>
    public class eChartfeature
    {
        /// <summary>
        /// magicType，动态类型切换，支持直角系下的折线图、柱状图、堆积、平铺转换，上图icon左数6/7/8/9，分别是切换折线图，切换柱形图，切换为堆积，切换为平铺
        /// type ['line', 'bar', 'stack', 'tiled']
        /// </summary>
        public eChartmagicType magicType { get; set; }
        /// <summary>
        /// 数据视图按纽  数据视图
        /// </summary>
        public eChartdataView dataView { get; set; }
        /// <summary>
        /// 辅助线标志  传入lineStyle（详见lineStyle）控制线条样式
        /// </summary>
        public eChartmark mark { get; set; }
        /// <summary>
        /// 还原，复位原始图表
        /// </summary>
        public eChartrestore restore { get; set; }
        /// <summary>
        /// 保存图片按纽 保存图片（IE8-不支持）
        /// </summary>
        public eChartsaveAsImage saveAsImage { get; set; }
        /// <summary>
        /// 默认的构造函数
        /// </summary>
        public eChartfeature()
        {
            magicType = new eChartmagicType();
            dataView = new eChartdataView();
            mark = new eChartmark();
            restore = new eChartrestore();
            saveAsImage = new eChartsaveAsImage();
        }
    }
    /// <summary>
    /// 工具箱按纽
    /// </summary>
    public class eCharttoolbox
    {
        /// <summary>
        /// 是否显示
        /// </summary>
        public bool show { get; set; }
        /// <summary>
        /// 工具箱
        /// </summary>
        public eChartfeature feature { get; set; }
        /// <summary>
        /// 构造函数
        /// </summary>
        public eCharttoolbox()
        {
            feature = new eChartfeature();
            show = true;//默认为显示
        }
    }
    /// <summary>
    /// 用于饼图 指标图的系列创建数据集 以及其他使用VALUE NAME的
    /// 格式为值，名称
    /// </summary>
    public class pieDate
    {
        /// <summary>
        /// 值
        /// </summary>
        public Double value { get; set; }
        /// <summary>
        /// 名称
        /// </summary>
        public string name { get; set; }
        /// <summary>
        /// 构造函数
        /// </summary>
        public pieDate()
        {

        }
    }
    /// <summary>
    /// 用于明细数据中的格式设置
    /// 如：formatter:'{value}%'
    /// </summary>
    public class eChartdetail
    {
        /// <summary>
        /// 格式
        /// </summary>
        public string formatter { get; set; }
        /// <summary>
        /// 默认构造函数
        /// </summary>
        public eChartdetail() { }
    }
    /// <summary>
    /// 系列下的itemStyle可用
    /// </summary>
    public class areaStyle_C
    {
        /// <summary>
        /// 面积图
        /// </summary>
        public string type { get; set; }
        public areaStyle_C()
        {
            type = "default";
        }
    }

    /// <summary>
    /// 系列下用， itemStyle
    /// </summary>
    public class itemStyle_C
    {
        public areaStyle_C normal { get; set; }
        public itemStyle_C()
        {

        }
    }
}