<%@ Page Language="C#" AutoEventWireup="true" CodeFile="signin.aspx.cs" Inherits="signin" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%--这个网站前端使用bootstrap框架--%>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>登陆</title>
    <%--bootsrap框架需要使用jquery插件--%>
    <script src="js/jquery.min.js"></script>
    <%--导入框架文件--%>
    <script src="js/bootstrap.min.js"></script>
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link href="css/signin.css" rel="stylesheet" />
</head>
<body>
    <%if (Request.Form["username"] != null) { }//判断是否提交了表单，提交了则设置session否则重新登陆
      
        string username = Request.Form["username"];
        string password = Request.Form["password"];
        SqlConnection conn = new SqlConnection("Data Source=localhost;Initial Catalog=bookinfo;User ID=sa;Password=sasasa");//数据库连接
        conn.Open();
        SqlCommand cmd = new SqlCommand("Select Count(*) from bookinfo_user Where user_username='" + username + "' and user_password = '"+password+"'", conn);
        int count = (int)cmd.ExecuteScalar();//判断这个用户是否存在只需要查询是否查询结果为零
        
        if (count > 0)
        {
            Session["username"] = username;//设置Session
            Response.Redirect("index.aspx");
        }else{
      %>
    <div class="container">
      <%if (Session["username"] == null) {  //判断Session是否存在，不存在则重新登陆%>
      <form class="form-signin" action="signin.aspx" method="post">  
            <h2 class="form-signin-heading">请登录</h2>
            <input type="text" class="form-control" placeholder="Username" name="username" required autofocus>
            <input type="password" class="form-control" placeholder="Password" name="password" required>
            <input class="btn btn-lg btn-primary btn-block" type="submit" value="登陆" />
      </form>
        <%}else{
                Response.Redirect("index.aspx");
          } %>
      
     <% }%>  
    </div>
</body>
</html>
