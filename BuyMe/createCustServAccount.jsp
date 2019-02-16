<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Account Created!</title>
</head>
<body>
	<%
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();

		//Get param
		/*String newBar = request.getParameter("bar");
		String newBeer = request.getParameter("beer");
		float price = Float.valueOf(request.getParameter("price"));*/
		String newUID = "cs." + request.getParameter("user_id2");
		String newFName = request.getParameter("first_name");
		String newLName = request.getParameter("last_name");
		String newDob = request.getParameter("dob");
		String newEmail= request.getParameter("email");
		String newPassword = request.getParameter("password2");


		//Make an insert statement for the Accounts table:
		String insert = "INSERT INTO cust_serv_acc(user_id, password, email, fname, lname, dob)"
				+ "VALUES (?, ?, ?, ?, ?, ?)"; 
		
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps = con.prepareStatement(insert);

		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		ps.setString(1, newUID);
		ps.setString(2, newPassword);
		ps.setString(3, newEmail);
		ps.setString(4, newFName);
		ps.setString(5, newLName);
		ps.setString(6, newDob);
		//Run the query against the DB
		ps.executeUpdate();

		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();

		out.print("Insert succeeded!");
		
	} catch (Exception ex) {
		out.print(ex);
		out.print("Insert failed :()");
	}
%>
<br>
<a href="mainAdminPage.jsp">Return Admin Account</a>
</body>
</html>