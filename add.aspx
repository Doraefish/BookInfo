<%@ Page Language="C#" AutoEventWireup="true" CodeFile="add.aspx.cs" Inherits="add" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%--
    这个网站前端使用bootstrap框架    
    --%>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>添加书籍信息</title>
    <%--bootsrap框架需要使用jquery插件--%>
    <script src="js/jquery.min.js"></script>
    <%--导入框架文件--%>
    <script src="js/bootstrap.min.js"></script>
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    
    <link href="css/justified-nav.css" rel="stylesheet">

</head>

<body>
    <!--判断有没有登录，没有登录的话跳转到登录页面-->
    <%if(Session["username"] == null){
          Response.Redirect("signin.aspx");
      } %>
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

    <div class="jumbotron">
        <!--图书信息的表单，图片在下一个表单中提交-->
        <form class="form-horizontal" role="form" action="addpicture.aspx" method="post">
          <div class="form-group">
            <label for="isbn" class="col-sm-2 control-label">ISBN</label><!--isbn-->
            <div class="col-sm-10">
              <input type="text" class="form-control" id="isbn" name="isbn" placeholder="ISBN" required />
            </div>
          </div>
          <div class="form-group">
            <label for="title" class="col-sm-2 control-label">书名</label>
            <div class="col-sm-10">
              <input type="text" class="form-control" id="title" name="title" placeholder="书名" /><!--title-->
            </div>
          </div>
          <div class="form-group">
            <label for="author" class="col-sm-2 control-label">作者</label>
            <div class="col-sm-10">
              <input type="text" class="form-control" id="author" name="author" placeholder="作者" /><!--author-->
            </div>
          </div>
            <div class="form-group">
            <label for="content" class="col-sm-2 control-label">介绍</label>
            <div class="col-sm-10">
              <textarea class="form-control" rows="5" id="content" name="content"></textarea><!--content-->
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
</body>
</html>
