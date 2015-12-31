using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using YfWeb.Models.Common;
using YfWeb.Models.DB;

namespace YfWeb.Models.Barcode
{
    public class BarcodeModel:BaseModel
    {

       public static Message postBar(String barcode)
        {
            Message msg = new Message();

            try
            {
                A_BARCODE data = new A_BARCODE();
                data.BARCODE = barcode;
                db.A_BARCODE.Add(data);
                db.SaveChanges();
                msg.status = true;
                msg.msg = "成功提交到数据库，条码为：" + barcode;
                return msg;
            }
            catch (Exception)
            {
                msg.status = false;
                msg.msg = "提交数据失败，可能是未创建相关表，条码为：" + barcode;
                return msg;
            }
        }
    }
}