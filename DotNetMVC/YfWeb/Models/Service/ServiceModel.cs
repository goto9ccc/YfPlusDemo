using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using YfWeb.Models.Bean;

namespace YfWeb.Models.Service
{
    public class ServiceModel:BaseModel
    {
        public static List<PublicDataModul> getOrderList(SqlParameter[] parameter,string page)
        {
            string sql = "Select  TD001 +'-' + TD002 + '-' +TD003  S1,"
                + "TD004 S2,TD005 S3,TD006 S4,"
                + "TD008 D1,TD009 D2 "
                + " FROM COPTD INNER JOIN COPTC ON TC001 = TD001 AND TC002 = TD002 "
                + " WHERE 1=1 "
                + " AND  TD001+TD002+TD003 like @TD001"
                + " AND TD005 like @TD005"
                + " AND TD006 like @TD006";

            int p = 1;
            try
            {
                p = Int32.Parse(page);
            }
            catch
            {
                p = 1;
            }
            return  db.Database.SqlQuery<PublicDataModul>(sql, parameter).Skip((p - 1) * 10).Take(10).ToList();

        }

        public static List<PublicDataModul> getInvmcList(SqlParameter[] parameter, string page)
        {
            int p;
            try
            {
                p = Int32.Parse(page);
            }
            catch
            {
                p = 1;
            }
            string sql = "select MC001,MC002,MC007,MC008,MC014,MB002,MB003 "
                + " FROM INVMC JOIN INVMB ON MB001 = MC001 "
                + " WHERE MC007>0";
                sql = sql + " and MC001 LIKE @MC001";
                sql = sql + " and MC002 LIKE @MC002";
                sql = sql + " and MB002 LIKE @MB002";
                sql = sql + " and MB003 LIKE @MB003";
          return db.Database.SqlQuery<PublicDataModul>(sql, parameter).Skip((p - 1) * 10).Take(10).ToList();   
        }

    }
}