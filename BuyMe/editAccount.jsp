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

	<%
		String curruse = request.getParameter("currUser");
	%>

		<br>
<form method="post" action="updateAccount.jsp">
	<table>
	<tr>    
	<td>New Password</td><td><input type="text" name="newPass"></td>
	</tr>
	<tr>
	<td>New First Name</td><td><input type="text" name="newFirst"></td>
	</tr>
	<tr>
	<td>New Last Name</td><td><input type="text" name="newLast"></td>    
	</tr>
	<tr>
	<td>New Email</td><td><input type="text" name="newEmail"></td>    
	</tr>
	<tr>
	<td>DOB</td><td><input type="text" name="newDOB"></td>    
	</tr>
	<tr>
	<td><input type="hidden" name="mydude" value="<%=curruse%>"></td>
	</tr>
	</table>
	<input type="submit" value="Create">
	</form>
</body>
</html>