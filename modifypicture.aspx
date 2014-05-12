<%@ Page Language="C#" AutoEventWireup="true" CodeFile="modifypicture.aspx.cs" Inherits="modifypicture" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%--
    这个网站前端使用bootstrap框架    
    --%>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1"  runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>修改图片</title>
    <%--bootsrap框架需要使用jquery插件--%>
    <script src="js/jquery.min.js"></script>
    <%--导入框架文件--%>
    <script src="js/bootstrap.min.js"></script>
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    
    <link href="css/justified-nav.css" rel="stylesheet">

</head>

<body>
<div class="container">
    <div class="masthead">
        <ul class="nav nav-justified">
        <li><a href="index.aspx">首页</a></li>
        <li><a href="list.aspx">浏览</a></li>
        <li class="active"><a>修改</a></li>
        <li><a href="mailto:cqqccqc@foxmail.com">联系</a></li>
        <li><%if (Session["username"] == null) { Response.Write("<a href='register.aspx'>注册</a>"); } else { Response.Write("<a href='signout.aspx'>登出</a>"); } %></li>
        </ul>
    </div>
    <%  //先判断有没有数据传过来
        if (Request.Form["isbn"] == null) { Response.Redirect("list.aspx"); }
        %>
    <%
        //sqlserver数据库连接
        SqlConnection conn = new SqlConnection("Data Source=localhost;Initial Catalog=bookinfo;User ID=sa;Password=sasasa");
        conn.Open();
        //从form表单中获得数据，声明变量方便使用
        string isbn = Request.Form["isbn"];
        string title = Request.Form["title"];
        string author = Request.Form["author"];
        string content = Request.Form["content"];
        //时间用DateTime.Now.ToString()
        string insertStr = "update bookinfo_book set book_title = '" + title + "' , book_author= '" + author + "' , book_content = '" + content + "' , book_time = '" + DateTime.Now.ToString() + "'  where book_isbn = '" + isbn + "'";
        //Response.Write(insertStr);
        SqlCommand cmd = new SqlCommand(insertStr, conn);
        int recordsAffected = cmd.ExecuteNonQuery();
        if(recordsAffected == 1){
         %>
        
        <div class="jumbotron"> 
            <p>提交成功</p>
            <form id="form1" runat="server" method="post" action="picture.aspx">
                <input type="hidden" name="isbn" value="<%=Request.Form["isbn"] %>" />
                <input type="submit" value="上传图片" />
                
            </form> 
        </div>
    <%  
       }//关闭数据库连接
        conn.Close();
       %>
</div>
</body>
</html>
