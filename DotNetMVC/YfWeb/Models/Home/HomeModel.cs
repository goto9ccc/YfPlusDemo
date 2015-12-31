using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using YfWeb.Common;
using YfWeb.Models.Bean;
using YfWeb.Models.DB;

namespace YfWeb.Models.Home
{
    public class HomeModel
    {
        public class ResultMsg
        {
            public Boolean status;
            public string info;
            public string url;
            public string signature;
            public ResultMsg()
            {
                this.status = false;
                info = "";
                url = "/";
                signature = "";
            }
        }

        public static ResultMsg login(String username, String password)
        {
            DSCSYSEntities SYSDb = new DSCSYSEntities();
            string sql = "Select MA001 S1,MA003 S2 FROM DSCMA Where MA001 =@MA001";
            SqlParameter parameter = new SqlParameter("@MA001", SqlDbType.Char, 10) { Value = username };
            PublicDataModul userModel = SYSDb.Database.SqlQuery<PublicDataModul>(sql, parameter).FirstOrDefault();
            ResultMsg resultMsg = new ResultMsg();
            if (userModel == null)
            {
                resultMsg.info = "无此用户名";
                return resultMsg;
            }
            if (YfUser.Encode7(YfUser.EnUser(username.ToCharArray()), password.ToCharArray()) != userModel.S2)
            {
                resultMsg.info = "密码错误";
                return resultMsg;
            }

            resultMsg.info = "成功登录";
            resultMsg.status = true;
            resultMsg.url = "/";
            return resultMsg;
        }

    }
}