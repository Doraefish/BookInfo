<%@ Page Language="C#" AutoEventWireup="true" CodeFile="modify.aspx.cs" Inherits="modify" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>更新</title>
    <%--bootsrap框架需要使用jquery插件--%>
    <script src="js/jquery.min.js"></script>
    <%--导入框架文件--%>
    <script src="js/bootstrap.min.js"></script>
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    
    <link href="css/justified-nav.css" rel="stylesheet">

</head>

<body>
    <%if(Session["username"] == null){ Response.Redirect("signin.aspx");} %>
    <%if (Request.QueryString["isbn"] == null) { Response.Redirect("list.aspx"); } %>
    <%
        //申明新变量方便使用
        string isbn = Request.QueryString["isbn"];
        //数据库连接
        SqlConnection conn = new SqlConnection("Data Source=localhost;Initial Catalog=bookinfo;User ID=sa;Password=sasasa");//sqlserver数据库连接
        conn.Open();
        //搜索这本书的所有信息
        SqlCommand cmd = new SqlCommand("select * from bookinfo_book where book_isbn='" + isbn + "'", conn);
        SqlDataReader myReader = cmd.ExecuteReader();
        myReader.Read();
         %>
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

    <div class="jumbotron">
        <!--修改图书信息的表单，修改图片在下一个表单中提交-->
        <form class="form-horizontal" role="form" action="modifypicture.aspx" method="post">
            <input type="hidden" name="isbn" value="<%=Request.QueryString["isbn"] %>" />
          <div class="form-group">
            <label for="isbn" class="col-sm-2 control-label">ISBN</label><!--isbn-->
            <div class="col-sm-10">
              <%=Request.QueryString["isbn"] %>
            </div>
          </div>
          <div class="form-group">
            <label for="title" class="col-sm-2 control-label">书名</label>
            <div class="col-sm-10"><!--获得数据库中的title 使用Trim（）去除两端的空格-->
              <input type="text" class="form-control" id="title" name="title" value="<%=myReader.GetString(1).Trim() %>" />
            </div>
          </div>
          <div class="form-group">
            <label for="author" class="col-sm-2 control-label">作者</label>
            <div class="col-sm-10"><!--获得数据库中的author使用Trim（）去除两端的空格-->
              <input type="text" class="form-control" id="author" name="author" value="<%=myReader.GetString(2).Trim() %>" />
            </div>
          </div>
            <div class="form-group">
            <label for="content" class="col-sm-2 control-label">介绍</label>
            <div class="col-sm-10"><!--获得数据库中的content使用Trim（）去除两端的空格-->
              <textarea class="form-control" rows="5" id="content" name="content"><%=myReader.GetString(3).Trim() %></textarea>
            </div>
          </div>
           
          <div class="form-group">
            <div class="col-sm-offset-2 col-sm-10">
              <input type="submit" class="btn btn-default" value="提交" />
            </div>
          </div>
        </form>
    </div>
</div>
    <%
        myReader.Close();
        conn.Close(); %>
</body>
</html>
