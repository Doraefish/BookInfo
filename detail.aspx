<%@ Page Language="C#" AutoEventWireup="true" CodeFile="detail.aspx.cs" Inherits="detail" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
    <!--判断有没有登录-->
<%if (Session["username"] == null) { Response.Redirect("signin.aspx"); } %>
<%
    //判断有没有数据传送过来
    if (Request.QueryString["isbn"] == null) { Response.Redirect("list.aspx"); }
    string isbn = Request.QueryString["isbn"];
    //连接数据库
    SqlConnection conn = new SqlConnection("Data Source=localhost;Initial Catalog=bookinfo;User ID=sa;Password=sasasa");//sqlserver数据库连接
    conn.Open();
    //搜索书本信息，用来填充默认界面
    SqlCommand cmd = new SqlCommand("select * from bookinfo_book where book_isbn='"+isbn+"'",conn);
    //使用myReader读取数据
    SqlDataReader myReader = cmd.ExecuteReader();
    myReader.Read();
     %>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link href="css/jumbotron-narrow.css" rel="stylesheet" />
    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <title>详细信息--<%=myReader.GetString(1) %></title>
    
</head>
  <body>
      <!--默认的值是数据库中读取出来的-->
    <div class="container">
      <a class="btn btn-primary" href="list.aspx">&laquo;  返回 </a><br />
       
      <div class="jumbotron">
        <h1 class="lead"><%=myReader.GetString(1) %></h1>
        <h1><img src="<%=myReader.GetString(4) %>" width="300" height="300" /></h1>
         <p><a class="btn btn-lg btn-info" href="modify.aspx?isbn=<%=myReader.GetString(0) %>">更新</a>
             <!--判断是否删除-->
            <a  onclick="return confirm('确定要删除吗？');" class="btn btn-lg btn-warning" href="delete.aspx?isbn=<%=myReader.GetString(0) %>">删除</a></p>
      </div>

      <div class="row marketing">
        <div class="col-lg-6">
          <h4>ISBN</h4>
          <p><%=myReader.GetString(0) %></p>

          <h4>书名</h4>
          <p><%=myReader.GetString(1) %></p>

          <h4>作者</h4>
          <p><%=myReader.GetString(2) %></p>
        </div>

        <div class="col-lg-6">
          <h4>介绍</h4>
          <p><%=myReader.GetString(3) %></p>

          <h4>更新时间</h4>
          <p><%=myReader.GetDateTime(5) %></p>

        </div>
      </div>

      <div class="footer">
        <p>&copy; 1121030陈琦 2013</p>
      </div>

    </div> 

<%//关闭数据库连接
    myReader.Close();
    conn.Close();
 %>
</body>
</html>
