using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace YfWeb.Common
{
    public class Signature
    {
        //根据时间戳，随机数，用户定义tokon生成加密签名signature 借用微信签名算法
        //加密签名通过SHA1算法加密
        public static string GetSignature(string timestamp, string nonce, string token)
        {
            string[] ArrTmp = { token, timestamp, nonce };
            Array.Sort(ArrTmp);     //字典排序
            string tmpStr = string.Join("", ArrTmp);
            tmpStr = System.Web.Security.FormsAuthentication.HashPasswordForStoringInConfigFile(tmpStr, "SHA1");
            tmpStr = tmpStr.ToLower();
            return tmpStr;
        }
    }
}