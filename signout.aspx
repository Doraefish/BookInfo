<%@ Page Language="C#" AutoEventWireup="true" CodeFile="signout.aspx.cs" Inherits="signout" %>

<!DOCTYPE html>
<!--这个页面是用来删除session信息的-->
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <%
        //Session.Abandon()用来删除所有Session信息
        if (Session["username"] != null)
      {
          Session.Abandon();
      }
      //跳转到首页
          Response.Redirect("index.aspx");
     %>
</body>
</html>
