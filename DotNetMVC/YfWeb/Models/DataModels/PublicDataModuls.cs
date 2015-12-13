using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace YfWeb.Models.DataModels
{

    /// <summary>
    /// 通用数据库实体类
    /// 
    /// 可通过 SELECT 字段一 S1,字段二 D1  来生成 避免每条语句都生成实体类 
    /// S字段为字符串型，D字段为数值型
    /// </summary>
    public class PublicDataModuls
    {
        public string S1 { get; set; }
        public string S2 { get; set; }
        public string S3 { get; set; }
        public string S4 { get; set; }
        public string S5 { get; set; }
        public string S6 { get; set; }
        public string S7 { get; set; }
        public string S8 { get; set; }
        public string S9 { get; set; }
        public string S10 { get; set; }

        public decimal D1 { get; set; }
        public decimal D2 { get; set; }
        public decimal D3 { get; set; }
        public decimal D4 { get; set; }
        public decimal D5 { get; set; }
        public decimal D6 { get; set; }

        public decimal D7 { get; set; }
        public decimal D8 { get; set; }
        public decimal D9 { get; set; }
        public decimal D10 { get; set; }

    }
}