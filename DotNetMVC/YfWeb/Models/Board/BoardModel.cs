using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using YfWeb.Models.Bean;

namespace YfWeb.Models.Board
{
    public class BoardModel:BaseModel

    {
        public static List<PublicDataModul> Purtb(string TB011) 
        {
            string sql = "Select SUM(TB009) AS D1,Right(TB011,2) S1 ,TB011 as S2,Count(TB001) as D2 "
                    + " from PURTB Where TB039 = ''N'' AND TB011 Like @TB011 group by TB011";
            if (TB011 == "")
            {
                TB011 = DateTime.Now.ToString("yyyyMM");
            }
            SqlParameter parameter = new SqlParameter("@TB011", TB011 + "%");
            return db.Database.SqlQuery<PublicDataModul>(sql, parameter).ToList();

        }

    }
}