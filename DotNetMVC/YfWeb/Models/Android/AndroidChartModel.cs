using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using YfWeb.Models.Bean;

namespace YfWeb.Models.Android
{
    public class AndroidChartModel:BaseModel
    {
        public static ResultData saleLine()
        {
            string sql = "Select TG003 S1,sum(TG045)+sum(TG046) D1 from COPTG"
                + " Where TG023 = 'Y' "
                + " Group by TG003 order by TG003 ";
            int count = db.Database.SqlQuery<PublicDataModul>(sql).Count();
            List<PublicDataModul> data = db.Database.SqlQuery<PublicDataModul>(sql).ToList();
            return new ResultData { count = count, data = data, msg = "" };
        }


        public static ResultData salerPie()
        {
            string sql = "Select MV002  S1,sum(TH013) D1 from COPTH "
                + " LEFT JOIN COPTG on TH001=TG001 AND TH002=TG002  "
                + " LEFT JOIN CMSMV ON TG006 = MV001 "
                + " Where TG003 like left(CONVERT(varchar(100), GETDATE(), 112),6)+'%' "
                + " Group by MV002 order by sum(TH013) desc ";
            int count = db.Database.SqlQuery<PublicDataModul>(sql).Count();
            List<PublicDataModul> data = db.Database.SqlQuery<PublicDataModul>(sql).ToList();
            return new ResultData { count = count, data = data, msg = "" };
        }


        public class ResultData
        {
            public int count;
            public List<PublicDataModul> data;
            public string msg;
        }

    }
}