<%@ Page Language="C#" AutoEventWireup="true" CodeFile="picture.aspx.cs" Inherits="picture" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>添加图片</title>
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
        if (Request.Form["isbn"] == null) { 
            Response.Redirect("index.aspx"); 
        }
        
        %>
    
        <!--这个表单提交图片-->
        <div class="jumbotron"> 
            <p>提交成功</p>
            <!--这个表单提交图片-->
            <form id="form1" runat="server" method="post" action="picture.aspx">
                <input type="hidden" name="isbn" value="<%=Request.Form["isbn"] %>" />
                <div class="form-group">
                    <label for="author" class="col-sm-2 control-label"></label>
                    <div class="col-sm-10">                 
                     <asp:FileUpload ID="FileUpload1" runat="server" class="form-control" />
                    </div>
                </div>    
                 
                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">                
                    <asp:Button ID="Button1" runat="server" Text="提交" OnClick="Button1_Click" class="btn btn-default" />
                    </div>
                    <asp:Label ID="Upload_info" runat="server" ForeColor="Red"></asp:Label>
                </div>
            </form> 
        </div>

</div>
</body>
</html>
