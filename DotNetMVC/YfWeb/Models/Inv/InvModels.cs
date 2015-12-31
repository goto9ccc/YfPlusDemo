using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using YfWeb.Common;
using YfWeb.Models.Bean;

namespace YfWeb.Models.Inv
{
    public class InvModels:BaseModel
    {
        public InvBean getData(string MC001, string MB002, string MB003, string MC002,
            int PageIndex, int pageSize)
        {
            InvBean invBean = new InvBean();

            string sqlStr = "Select MC001,MC002,MB002,MB003,MC007,MC008,MC014 From INVMC "
                        + "inner join INVMB ON MB001 = MC001 "
                        + "Where  MC007 <> 0 AND MC001 Like @MC001"
                        + " AND MC002 like @MC002"
                        + " AND MB002 like @MB002"
                        + " AND MB003 like @MB003"
                        + " ";
            SqlParameter[] para = new SqlParameter[] 
            { 
                new SqlParameter("@MC001","%"+MC001+"%"),
                new SqlParameter("@MC002","%"+MC002+"%"),
                new SqlParameter("@MB002","%"+MB002+"%"),
                new SqlParameter("@MB003","%"+MB003+"%")
            };
            var invmc = db.Database.SqlQuery<INVMC_INVMB>(sqlStr, para);
            int pageCount = 1;
            int rocodeCount = 0;
            //总记录数
            rocodeCount = db.Database.SqlQuery<INVMC_INVMB>(sqlStr, new SqlParameter[] 
            { 
                new SqlParameter("@MC001","%"+MC001+"%"),
                new SqlParameter("@MC002","%"+MC002+"%"),
                new SqlParameter("@MB002","%"+MB002+"%"),
                new SqlParameter("@MB003","%"+MB003+"%")
            }).Count();
            //总页数
            pageCount = Page_Helper.CountPage(pageSize, rocodeCount);
            invBean.pageCount = pageCount;
            invBean.pageIndex = PageIndex;
            invBean.pageSize = pageSize;
            invBean.MC001 = MC001;
            invBean.MB002 = MB002;
            invBean.MB003 = MB003;
            invBean.MC002 = MC002;
            //总记录数量与包装数量 合计
            invBean.MC007Sum = db.Database.SqlQuery<INVMC_INVMB>(sqlStr, new SqlParameter[] 
            { 
                new SqlParameter("@MC001","%"+MC001+"%"),
                new SqlParameter("@MC002","%"+MC002+"%"),
                new SqlParameter("@MB002","%"+MB002+"%"),
                new SqlParameter("@MB003","%"+MB003+"%")
            }).Sum(u => u.MC007);
            invBean.MC014Sum = db.Database.SqlQuery<INVMC_INVMB>(sqlStr, new SqlParameter[] 
            { 
                new SqlParameter("@MC001","%"+MC001+"%"),
                new SqlParameter("@MC002","%"+MC002+"%"),
                new SqlParameter("@MB002","%"+MB002+"%"),
                new SqlParameter("@MB003","%"+MB003+"%")
            }).Sum(u => u.MC014);
            //单页数量与包装数量 小计
            invBean.MC007PageSum = db.Database.SqlQuery<INVMC_INVMB>(sqlStr, new SqlParameter[] 
            { 
                new SqlParameter("@MC001","%"+MC001+"%"),
                new SqlParameter("@MC002","%"+MC002+"%"),
                new SqlParameter("@MB002","%"+MB002+"%"),
                new SqlParameter("@MB003","%"+MB003+"%")
            }).Skip((PageIndex - 1) * pageSize).Take(pageSize).Sum(u => u.MC007);
            invBean.MC014PageSum = db.Database.SqlQuery<INVMC_INVMB>(sqlStr, new SqlParameter[] 
            { 
                new SqlParameter("@MC001","%"+MC001+"%"),
                new SqlParameter("@MC002","%"+MC002+"%"),
                new SqlParameter("@MB002","%"+MB002+"%"),
                new SqlParameter("@MB003","%"+MB003+"%")
            }).Skip((PageIndex - 1) * pageSize).Take(pageSize).Sum(u => u.MC014);
            invBean.invmcList = invmc.Skip((PageIndex - 1) * pageSize).Take(pageSize).ToList();
            return invBean;
        }

        public class InvBean
        {
            public List<INVMC_INVMB> invmcList;
            public int pageCount = 1;
            public int rocodeCount = 0;
            public int pageSize;
            public int pageIndex;
            public String MC001;
            public String MB002;
            public String MB003;
            public String MC002;
            public Decimal MC007Sum;
            public Decimal MC014Sum;
            public Decimal MC007PageSum;
            public Decimal MC014PageSum;
        }


        public List<PublicDataModul> getInvmfData(string MC001, string MC002)
        {
           String sql = "Select MF001 S1,MF002 S2,MF007 S3,"
                + "MF010 D1,MF014 D2 from INVMF "
                + "Where MF001 =@MC001 AND MF002 like @MC002 AND MF010>0";
            SqlParameter[] sqlParameters = new SqlParameter[]
                    {
                        new SqlParameter("@MC001",MC001),
                        new SqlParameter("@MC002","%"+MC002+"%"),
                    };
            return db.Database.SqlQuery<PublicDataModul>(sql, sqlParameters).ToList();
        }

        public List<PublicDataModul> getInvmlData(string MC001, string MC002)
        {
            String sql = "Select ML001 S1,ML002 S2,ML003 S3,ML004 S4"
                    + "ML005 D1,ML006 D2 from INVML "
                    + "Where ML001 =@MC001 AND ML002 like @MC002 AND ML005>0";
            SqlParameter[] sqlParameters = new SqlParameter[]
                    {
                        new SqlParameter("@MC001",MC001),
                        new SqlParameter("@MC002","%"+MC002+"%"),
                    };
            return db.Database.SqlQuery<PublicDataModul>(sql, sqlParameters).ToList();
        }

    }
}