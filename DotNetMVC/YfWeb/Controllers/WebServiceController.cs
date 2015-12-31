using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using YfWeb.Common;
using YfWeb.Common.Chart;
using YfWeb.Models.Bean;

namespace YfWeb.Controllers
{
    public class WebServiceController : WebBaseController
    {
        //
        // GET: /WebService/

        public ActionResult Index()
        {
            return View();
        }


        public ActionResult day_in_inv(string type = "day")
        {
            string sqlStr = "Select MOCTG.TG001 S1, MOCTG.TG011 D1,MOCTG.TG025 D2 FROM MOCTF "
                                  + " left join MOCTG ON TF001 = TG001 AND TF002 = TG002 "
                                  + " Where TF012 = '"
                                  + DateTime.Now.ToString("yyyyMMdd")
                                  + "' ";
            switch (type)
            {
                default:
                    break;
                case "month": sqlStr = "Select MOCTG.TG001 S1, MOCTG.TG011 D1,MOCTG.TG025 D2 FROM MOCTF "
                                   + " left join MOCTG ON TF001 = TG001 AND TF002 = TG002 "
                                   + " Where TF012 >= '"
                                   + DateTime.Now.ToString("yyyyMM")
                                   + "01' and TF012 <=  '"
                                  + DateTime.Now.ToString("yyyyMMdd")
                                  + "' ";
                    break;
                case "year": sqlStr = "Select MOCTG.TG001 S1, MOCTG.TG011 D1,MOCTG.TG025 D2 FROM MOCTF "
                       + " left join MOCTG ON TF001 = TG001 AND TF002 = TG002 "
                       + " Where TF012 >= '"
                       + DateTime.Now.ToString("yyyy")
                       + "0101' and TF012 <=  '"
                      + DateTime.Now.ToString("yyyyMMdd")
                      + "' ";
                    break;
            }
            try
            {
                var moctgList = db.Database.SqlQuery<PublicDataModul>(sqlStr);
                var moctgGroup = moctgList.GroupBy(u => u.S1).Select(g => new
                {
                    S1 = g.Key,
                    D1 = g.Sum(x => x.D1),
                    D2 = g.Sum(x => x.D2)
                }).OrderByDescending(U => U.D1);
                return Json(moctgGroup, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(ex.ToString(), JsonRequestBehavior.AllowGet);
                throw;
            }
        }
        /// <summary>
        /// 销售柱形图
        /// </summary>
        /// <param name="yyyymm"></param>
        /// <param name="charttype"></param>
        /// <returns></returns>

        public string Sale(string yyyymm = "", string charttype = "bar")
        {

            if (yyyymm == "")
                yyyymm = DateTime.Today.ToString("yyyyMM");

            if (yyyymm.Length != 6)
            {
                return "请用yyyymm格式表示年月";
            }

            // SQL 将日期字符格式化
            String SqlStr = "Select Convert(char(10),Convert(datetime,TG003),120) S1,sum(TH037+TH038) D1,sum(TH008) D2 from COPTH "
                                    + " LEFT JOIN COPTG on TH001=TG001 AND TH002=TG002  "
                                    + " Where TG003 >= '" + yyyymm + "01' "
                                    + " and TG023 = 'Y' "
                                    + " Group by TG003 order by TG003"
                                    + "";
            eChartBarJson<string, double, double> echart = new eChartBarJson<string, double, double>();
            echart.title.text = yyyymm + "月分天销售额图";
            echart.title.subtext = "数据来源：已审核销货单单身本币金额加税额";
            echart.legend.data.Add("本月销售量");
            
            echart.series.Add(new eChartSeries<double>());
            echart.series[0].name = "本月销售量";
            echart.series[0].type = charttype;
            echart.series[0].smooth = true;

            return CreateSingleChartBar(echart, SqlStr);
        }


        /// <summary>
        /// 销售完成比例 指定月份，默认为本月
        /// </summary>
        /// <returns></returns>
        public string COPTD(string yyyymm = "",string LastMonth="FALSE")
        {
            if (yyyymm == "")
                yyyymm = DateTime.Today.ToString("yyyyMM");
            if (yyyymm.Length != 6)
                return "请用yyyymm格式表示年月";
            string strDateend = DateTime.Today.ToString("yyyyMMdd");
            if (yyyymm != DateTime.Today.ToString("yyyyMM"))
            {
                strDateend = yyyymm + "31";
            }
            // SQL 将日期字符格式化
            String SqlStr = " select Count(Distinct TD001+TD002+TD003) as i1"
                                        + " From COPTD "
                                        + " LEFT JOIN COPTH ON TH014=TD001 AND TH015=TD002 AND TH016=TD003 "
                                        + " LEFT JOIN COPTG ON TG001=TH001 AND TG002=TH002 "
                                        + "  Where TG023='Y' AND TG003>= '" + yyyymm + "01' "
                                        + " AND TD021='Y' AND TD013<= '" + strDateend + "' and TG003<='" 
                                        + strDateend + "'";
            String SqlStr2 = " select Count(Distinct TD001+TD002+TD003) as i1"
                                        + " From COPTD "
                                        + " where TD021='Y' AND TD013 >=  '" + yyyymm + "01' "
                                        + " AND TD013<=  '" + strDateend + "'";

            if (LastMonth == "TRUE")
            {
                 SqlStr = " select Count(Distinct TD001+TD002+TD003) as i1"
                                            + " From COPTD "
                                            + " LEFT JOIN COPTH ON TH014=TD001 AND TH015=TD002 AND TH016=TD003 "
                                            + " LEFT JOIN COPTG ON TG001=TH001 AND TG002=TH002 "
                                            + "  Where TG023='Y' AND TG003>= '" + yyyymm + "01' "
                                            + " AND TD021='Y' AND TD013<= '" + strDateend + "' and TG003<='"
                                            + strDateend + "'";
                 SqlStr2 = " select Count(Distinct TD001+TD002+TD003) as i1"
                                            + " From COPTD "
                                            + " where TD021='Y' AND TD013 >=  '" + yyyymm + "01' "
                                            + " AND TD013<=  '" + strDateend + "'";                
            }


            PublicDataModul data = db.Database.SqlQuery<PublicDataModul>(SqlStr).FirstOrDefault();
            int dm = data.i1;
            PublicDataModul data2 = db.Database.SqlQuery<PublicDataModul>(SqlStr2).FirstOrDefault();
            int dm2 = data2.i1;
            decimal dm3;
            try
            {
                dm3 = Math.Round((decimal)dm / dm2, 4) * 100;
            }
            catch (Exception)
            {

                dm3 = 0;
            }

            
            eChartPie echart = new eChartPie();
            echart.title.text = "本月订单及时交付率";
            if (LastMonth == "TRUE")
            {
                 echart.title.text = "上月订单及时交付率";
            }
            echart.toolbox.show = false;
            echart.title.subtext = "数据来源：日期内已审核订单，已审核销货单，交货预计日在范围内";
            echart.series.Add(new eChartSeries<pieDate>());
            echart.series[0].detail.formatter = "{value}%";
            echart.series[0].name = "";
            echart.series[0].type = "gauge";
            echart.series[0].data.Add(new pieDate());
            echart.series[0].data[0].value = (double)dm3;
            echart.series[0].data[0].name = "";
            return JsonConvert.SerializeObject(echart);
        }

        /// <summary>
        /// 私有方法，构造柱形图，传入定义好的echart类和SQL字符串 返回JSON字符串
        /// </summary>
        /// <param name="echart">已构造且定义好的构造类</param>
        /// <param name="SqlStr">SQL查询字符串</param>
        /// <returns>JSON字符串</returns>
        private  string CreateSingleChartBar(eChartBarJson<string, double, double> echart, string SqlStr)
        {
            echart.toolbox.feature.magicType.type.Add("line");
            echart.toolbox.feature.magicType.type.Add("bar");
            echart.xAxis.Add(new eChartxAxis<string>());
            echart.xAxis[0].type = "category";
            echart.yAxis.Add(new eChartyAxis<double>());
            echart.yAxis[0].type = "value";
            var moctgList = db.Database.SqlQuery<PublicDataModul>(SqlStr);
            decimal dm;
            foreach (var item in moctgList)
            {
                echart.xAxis[0].data.Add(item.S1);
                dm = item.D1;
                echart.series[0].data.Add((Double)dm);
            }
            return JsonConvert.SerializeObject(echart);
        }

    }
}
