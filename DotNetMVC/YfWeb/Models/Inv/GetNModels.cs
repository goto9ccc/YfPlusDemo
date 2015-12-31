using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using YfWeb.Models.Bean;

namespace YfWeb.Models.Inv
{
    public class GetNModels:BaseModel
    {

  
        private String MC001;

        public GetNModels(String MC001)
        {
            this.MC001 = MC001;
        }


        public NData getData()
        {

            String sql = "";
            PublicDataModul data;
            NData resultData = new NData();
            //未交货订单
            sql = "Select TD004 S1,SUM(TD008-TD009) D1 FROM COPTD "
                + " where TD004 = @MC001 AND TD008+TD024>TD009+TD025+TD058 AND TD016='N'"
                + " AND TD021 = 'Y' GROUP BY TD004";
            data = db.Database.SqlQuery<PublicDataModul>(sql, new SqlParameter("@MC001", MC001)).FirstOrDefault();
            if (data != null)
            {
                resultData.sumCOPTD = data.D1;
            }
            else
            {
                resultData.sumCOPTD = 0;
            }
            data = null;    
            //未完成销售预测
            sql = "Select MF003 S1,SUM(MF008-MF009) D1 FROM COPMF "
                + " where MF003 = @MC001 AND MF008>MF009 GROUP BY MF003";
            data = db.Database.SqlQuery<PublicDataModul>(sql, new SqlParameter("@MC001", MC001)).FirstOrDefault();
            if (data != null)
            {
                resultData.sumCOPMF = data.D1;
            }
            else
            {
                resultData.sumCOPMF = 0;
            }
            data = null;  
            //未达成采购
            sql = "Select TD004 S1,SUM(TD008-TD015) D1 FROM PURTD "
                + " where TD004 = @MC001 AND TD016 = 'N' GROUP BY TD004";
            data = db.Database.SqlQuery<PublicDataModul>(sql, new SqlParameter("@MC001", MC001)).FirstOrDefault();
            if (data != null)
            {
                resultData.sumPURTD = data.D1;
            }
            else
            {
                resultData.sumPURTD = 0;
            }
            data = null;  
            //未入库工单
            sql = "Select TA006 S1,SUM(TA015-TA017) D1 FROM MOCTA "
                + " where TA006 = @MC001 AND TA011 <> 'Y' AND TA011 <>'y' GROUP BY TA006";

            data = db.Database.SqlQuery<PublicDataModul>(sql, new SqlParameter("@MC001", MC001)).FirstOrDefault();
            if (data != null)
            {
                resultData.sumMOCTA = data.D1;
            }
            else
            {
                resultData.sumMOCTA = 0;
            }
            data = null;  
            
            //预计领用
            sql = "Select TB003 S1,SUM(TB004-TB005) D1 FROM MOCTA INNER JOIN MOCTB ON TB001 = TA001 AND TB002 = TA002 "
                 + " where TB003 = @MC001 AND TA011 <> 'Y' AND TA011 <>'y' AND TB004-TB005>0 GROUP BY TB003";
            data = db.Database.SqlQuery<PublicDataModul>(sql, new SqlParameter("@MC001", MC001)).FirstOrDefault();
            if (data != null)
            {
                resultData.sumMOCTB = data.D1;
            }
            else
            {
                resultData.sumMOCTB = 0;
            }
            data = null;  
            return resultData;


            //linq查询示例，由于担心各易飞版本数据库不符，不建实体类了，仅给出示例

            //        
            //        //未完成销售预测
            //        var copmf = (from mf in erp.COPMF
            //                     where mf.MF003 == MC001 && mf.MF008 > mf.MF009
            //                     select mf);

            //        ViewBag.sumCOPMF = copmf.Sum(u => u.MF008 - u.MF009);
            //        if (ViewBag.sumCOPMF == null)
            //            ViewBag.sumCOPMF = 0;
            //        //未达成采购
            //        var purtd = (from td in erp.PURTD
            //                     where td.TD004 == MC001 && td.TD016 == "N"
            //                     select td);

            //        ViewBag.sumPURTD = purtd.Sum(u => u.TD008 - u.TD015);
            //        if (ViewBag.sumPURTD == null)
            //            ViewBag.sumPURTD = 0;
            //        //未入库工单
            //        var mocta = (from ta in erp.MOCTA
            //                     where ta.TA006 == MC001 && ta.TA011 != "Y" && ta.TA011 != "y"
            //                     select ta);
            //        ViewBag.sumMOCTA = mocta.Sum(u => u.TA015 - u.TA017);
            //        if (ViewBag.sumMOCTA == null)
            //            ViewBag.sumMOCTA = 0;
            //        //预计领用
            //        var moctb = (from ta in erp.MOCTA
            //                     join tb in erp.MOCTB on ta.TA001 + ta.TA002 equals tb.TB001 + tb.TB002
            //                     where tb.TB003 == MC001 && ta.TA011 != "Y" && ta.TA011 != "y" && tb.TB004 - tb.TB005 > 0
            //                     select tb);
            //        ViewBag.sumMOCTB = moctb.Sum(u => u.TB004 - u.TB005);
            //        if (ViewBag.sumMOCTB == null)
            //            ViewBag.sumMOCTB = 0;


        }


        public class NData{
            public Decimal sumCOPTD { get; set; }
            public Decimal sumCOPMF { get; set; }
            public Decimal sumPURTD { get; set; }
            public Decimal sumMOCTA { get; set; }
            public Decimal sumMOCTB { get; set; }


        }

    }
}