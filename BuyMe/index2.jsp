<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Create Account</title>
</head>
<body>
Enter Your Information Below:
<br>
<form method="post" action="createAccount.jsp">
	<table>
	<tr>    
	<td>First Name</td><td><input type="text" name="first_name"></td>
	<td>Last Name</td><td><input type="text" name="last_name"></td>
	</tr>
	<tr>  
	<td>DOB (YYYY-MM-DD) </td><td><input type="text" name="dob"></td>  
	<td>E-Mail Address</td><td><input type="text" name="email"></td>
	</tr>
	<tr>    
	<td>UserID</td><td><input type="text" name="user_id2"></td>
	</tr>
	<tr>
	<td>Password</td><td><input type="text" name="password2"></td>
	</tr>
	</table>
	<input type="submit" value="Create">
	</form>
</body>
</html>