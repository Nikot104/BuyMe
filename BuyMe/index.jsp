<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<style>
div.container {
background-color: #ffffff;
}
div.container p {
font-family: Times;
font-size: 14px;
font-style: italic;
font-weight: normal;
text-decoration: none;
text-transform: none;
color: #000000;
background-color: #ffffff;
}
</style>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Buy Me!</title>
</head>
<body>
Welcome to Buy Me!
<br>
<br>
Login Here 

<br><% 
ScheduledTaskExample ste = new ScheduledTaskExample();
ste.startScheduleTask(); %>
	<form method="post" action="query.jsp">
	<table>
	<tr>    
	<td>UserID</td><td><input type="text" name="user_ID"></td>
	</tr>
	<tr>
	<td>Password</td><td><input type="password" name="password"></td>
	</tr>
	</table>
	<input type="submit" value="login">
	</form>
<br>
<div class = "container"><p>Don't Have An Account Yet? <a href="index2.jsp">Create One Here!</a></p></div>
<br>

</body>
</html>