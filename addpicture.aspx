<%@ Page Language="C#" AutoEventWireup="true" CodeFile="addpicture.aspx.cs" Inherits="addpicture" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%--
    这个网站前端使用bootstrap框架    
    --%>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head  runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>完成添加</title>
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
        <li class="active"><a href="add.aspx">添加</a></li>
        <li><a href="mailto:cqqccqc@foxmail.com">联系</a></li>
        <li><%if (Session["username"] == null) { Response.Write("<a href='register.aspx'>注册</a>"); } else { Response.Write("<a href='signout.aspx'>登出</a>"); } %></li>
        </ul>
    </div>
    <%  //先判断有没有数据传过来
        if (Request.Form["isbn"] == null) { Response.Redirect("index.aspx"); }
        %>
    <%
        //sqlserver数据库连接
        SqlConnection conn = new SqlConnection("Data Source=localhost;Initial Catalog=bookinfo;User ID=sa;Password=sasasa");
        conn.Open();
        //先查询数据库中有没有这本书的isbn
        SqlCommand cmd = new SqlCommand("select count(*) from bookinfo_book where book_isbn='"+Request.Form["isbn"]+"'", conn);
        int count = (int)cmd.ExecuteScalar();
        //结果不为零的话则书已存在
        if (count != 0) { Response.Write("<center>本书已存在<br /><a href='add.aspx'>返回</a></center>"); }
        //否则则书本不存在，把数据写入数据库
        else{
            //声明变量方便使用
            string isbn = Request.Form["isbn"];
            string title = Request.Form["title"];
            string author = Request.Form["author"];
            string content = Request.Form["content"];
            //时间用DateTime.Now.ToString()
            //图片没有上传的话默认使用car1.gif（暂无图片）
            string insertStr = "INSERT INTO bookinfo_book  VALUES ('" + isbn + "', '" + title + "', '" + author + "', '" + content + "', 'image/car1.gif', '" + DateTime.Now.ToString() + "')";
            cmd = new SqlCommand(insertStr, conn);
            int recordsAffected = cmd.ExecuteNonQuery();
            if(recordsAffected == 1){
         %>

        <div class="jumbotron"> 
            <p>提交成功</p>
            <form id="form1" runat="server" method="post" action="picture.aspx">
                <!--使用隐藏域传递isbn号-->
                <input type="hidden" name="isbn" value="<%=Request.Form["isbn"] %>" />
                <input type="submit" value="上传图片" />
                
            </form> 
        </div>

    <%  }
       }
        conn.Close();
       %>
</div>
</body>
</html>
