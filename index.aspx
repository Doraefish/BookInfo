<%@ Page Language="C#" AutoEventWireup="true" CodeFile="index.aspx.cs" Inherits="index" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%--
    这个网站前端使用bootstrap框架
    --%>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>图书管理系统</title>
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
          <li class="active"><a href="index.aspx">首页</a></li>
          <li><a href="list.aspx">浏览</a></li>
          <li><a href="add.aspx">添加</a></li>
          <li><a href="mailto:cqqccqc@foxmail.com">联系</a></li>
          <li><%if (Session["username"] == null) { Response.Write("<a href='register.aspx'>注册</a>"); } else { Response.Write("<a href='signout.aspx'>登出</a>"); } %></li>
        </ul>
      </div>

      <!-- center part -->
      <div class="jumbotron">
        <h1>图书管理系统</h1>
        <p class="lead"></p>
        <p><%if (Session["username"] == null){Response.Write("<a class='btn btn-lg btn-success' href='signin.aspx' role='button'>请登陆</a>");}else{Response.Write("<p class='btn btn-lg btn-success' href='#' role='button'>欢迎"+Session["username"]+"</p>");} %></p>
      </div>
      <div class="row">
          <div class="col-lg-12"><h2 class="btn btn-primary btn-lg btn-block" >以下是最新书籍</h2></div>
      </div>
      <!-- Book row of columns -->
      <div class="row">
        
            <%
                //连接数据库
                SqlConnection conn = new SqlConnection("Data Source=localhost;Initial Catalog=bookinfo;User ID=sa;Password=sasasa");//sqlserver数据库连接
                conn.Open();
                //sql语句根据时间查询最新的三本书
                SqlCommand cmd = new SqlCommand("select top 3 * from bookinfo_book order by book_time desc", conn);
                SqlDataReader myReader = cmd.ExecuteReader();//执行sql语句
                while(myReader.Read()){//循环输出数据库信息
            %>
          <div class="col-lg-4">
            <h2><%Response.Write(myReader.GetString(1));%></h2>
            <img src="<%Response.Write(myReader.GetString(4));%>" width="300" height="300" /><br /><br />
            <p><a class="btn btn-primary" href="detail.aspx?isbn=<%=myReader.GetString(0) %>" role="button">详细信息 &raquo;</a></p>
          </div>

          <%}
              myReader.Close();
              conn.Close();
            %>
      </div>

      <!-- Site footer -->
      <div class="footer">
        <p>&copy; 1121030陈琦 2013</p>
      </div>

    </div> 

  </body>

</html>
