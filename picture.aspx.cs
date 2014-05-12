using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

public partial class picture : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        string isbn = Request.Form["isbn"];//从之前页面获得的ISBN
 
        try
        {
            if (FileUpload1.PostedFile.FileName == "")
            {
                this.Upload_info.Text = "请选择上传文件！";
            }
            else
            {
                string filepath = FileUpload1.PostedFile.FileName;  //得到的是文件的完整路径,包括文件名       
                string filename = DateTime.Now.Ticks.ToString()+new Random().Next() + "."+filepath.Substring(filepath.LastIndexOf(".") + 1);//文件名使用当前时间戳加一个随机数防止重复
                string serverpath = Server.MapPath("~/image/") + filename;//取得文件在服务器上保存的位置
                FileUpload1.PostedFile.SaveAs(serverpath);//将上传的文件另存为 
                this.Upload_info.Text = "上传成功！" + filename;
                
                /*将文件名称写入数据库*/
                string relativeFileName = "image/" + filename;
                //数据库连接
                SqlConnection conn = new SqlConnection("Data Source=localhost;Initial Catalog=bookinfo;User ID=sa;Password=sasasa");
                conn.Open();
                //修改数据库中的图片路径(默认为ca1.jpg)
                string sql = "update bookinfo_book set book_image = '" + relativeFileName + "' where book_isbn = '" + isbn + "'";
                SqlCommand cmd = new SqlCommand(sql, conn);
                int rs = cmd.ExecuteNonQuery();
                //Response.Write(relativeFileName + rs);
                //如果影响行数大于0的话就写入成功
                if (rs > 0) { this.Upload_info.Text += "数据库写入成功！" ; }
            }
        }
        catch (Exception ex)
        {
            this.Upload_info.Text = "上传发生错误！原因是：" + ex.ToString();
        } 
    }
}