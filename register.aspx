<%@ Page Language="C#" AutoEventWireup="true" CodeFile="register.aspx.cs" Inherits="register" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%--这个网站前端使用bootstrap框架--%>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
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
    <%if (Request.Form["username"] != null)//判断是否提交了表单，提交了则设置session否则重新登陆
      {
          string username = Request.Form["username"];
          string password = Request.Form["password"];
          SqlConnection conn = new SqlConnection("Data Source=localhost;Initial Catalog=bookinfo;User ID=sa;Password=sasasa");//数据库连接
          conn.Open();
          SqlCommand cmd = new SqlCommand("Select Count(*) from bookinfo_user Where user_username='" + username + "'", conn);
          int count = (int)cmd.ExecuteScalar();//判断这个用户是否存在只需要查询是否查询结果为零
          if (count > 0)
          {
              Response.Write("<center>该用户已存在<br /><a href='register.aspx'>返回</a></center>");//存在的话则给出提示
          }
          else
          {
              cmd = new SqlCommand("insert into bookinfo_user values('" + username + "', '" + password + "')",conn);
              int recordsAffected = cmd.ExecuteNonQuery();//影响的行数
              if (recordsAffected > 0)//如果行数大于零的话，则插入信息成功
              {
                  Session["username"] = Request.Form["username"];//设置Session
                  Response.Write(username);
              }
              Response.Redirect("index.aspx");//跳转到首页
          }
      }
      else {
      %>
    <div class="container">
      <%if (Session["username"] == null) {  //判断Session是否存在，不存在则重新登陆%>
      <form class="form-signin" action="register.aspx" method="post">  
            <h2 class="form-signin-heading">注册</h2>
            <input type="text" class="form-control" placeholder="Username" name="username" required autofocus>
            <input type="password" class="form-control" placeholder="Password" name="password" required>
            <input class="btn btn-lg btn-primary btn-block" type="submit" value="注册" />
      </form>
        <%}else{
                Response.Redirect("index.aspx");
          } %>
      
     <% }%>  
    </div>
</body>
</html>
