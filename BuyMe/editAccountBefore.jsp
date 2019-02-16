<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*, java.util.Date"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Updating Account</title>
</head>

<body>

		<br>
<form method="post" action="editAccount.jsp">
	<table>
	<tr>    
	<td>Enter Username:</td><td><input type="text" name="currUser"></td>
	</tr>
	<tr>
	<td>Enter Password:</td><td><input type="text" name="currPass"></td>
	</tr>
	</table>
	<input type="submit" value="Create">
	</form>
</body>
</html>