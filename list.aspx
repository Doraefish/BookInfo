<%@ Page Language="C#" AutoEventWireup="true" CodeFile="list.aspx.cs" Inherits="list" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>浏览</title>
    <%--bootsrap框架需要使用jquery插件--%>
    <script src="js/jquery.min.js"></script>
    <%--导入框架文件--%>
    <script src="js/bootstrap.min.js"></script>
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    
    <link href="css/justified-nav.css" rel="stylesheet">

</head>
<body>
<div class="container">
    <%if (Session["username"] == null) { Response.Redirect("signin.aspx"); } %>
    <div class="masthead">
        <ul class="nav nav-justified">
        <li><a href="index.aspx">首页</a></li>
        <li class="active"><a href="list.aspx">浏览</a></li>
        <li><a href="add.aspx">添加</a></li>
        <li><a href="mailto:cqqccqc@foxmail.com">联系</a></li>
        <li><%if (Session["username"] == null) { Response.Write("<a href='register.aspx'>注册</a>"); } else { Response.Write("<a href='signout.aspx'>登出</a>"); } %></li>
        </ul>
    </div>
    <br />
    <div class="row">
        <div class="col-lg-12">
            <table class="table table-hover">
    <%
        //连接数据库
        SqlConnection conn = new SqlConnection("Data Source=localhost;Initial Catalog=bookinfo;User ID=sa;Password=sasasa");//sqlserver数据库连接
        conn.Open();
        //搜索最新添加的两本书的信息
        SqlCommand cmd = new SqlCommand("select book_isbn, book_title, book_author from bookinfo_book order by book_time desc", conn);
        //循环输出信息
        SqlDataReader myReader = cmd.ExecuteReader();
        while (myReader.Read()) {           
      %>

            <tr>
                <td width="90%"><%=myReader.GetString(1)%></td>
                <td width="10%"><a class="btn btn-primary" href="detail.aspx?isbn=<%=myReader.GetString(0) %>">详细信息 &raquo;</a></td>
            </tr>
        
    <% }
       //关闭数据库连接
        myReader.Close();
        conn.Close();
       %>
          </table>
        </div>
    </div>
</div>

</body>
</html>
