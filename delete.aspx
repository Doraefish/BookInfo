<%@ Page Language="C#" AutoEventWireup="true" CodeFile="delete.aspx.cs" Inherits="delete" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
<%
    //判断有没有数据传过来，没有传过来则跳转到住而已
    if (Request.QueryString["isbn"] == null) { Response.Redirect("list.aspx"); }
    string isbn = Request.QueryString["isbn"];
    //连接数据库
    SqlConnection conn = new SqlConnection("Data Source=localhost;Initial Catalog=bookinfo;User ID=sa;Password=sasasa");//sqlserver数据库连接
    conn.Open();
    //删除数据
    SqlCommand cmd = new SqlCommand("delete from bookinfo_book where book_isbn = '"+isbn+"'",conn);
    int rs = cmd.ExecuteNonQuery();
    //如果没有影响行数则出错
    if (rs == 0) { Response.Write("出错了<a href='list.aspx'></a>"); }
    else { Response.Redirect("list.aspx"); }
    conn.Close();
     %>
</body>
</html>
