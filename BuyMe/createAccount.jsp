<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*, java.util.Date"%>
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
		String newUID = request.getParameter("user_id2");
		String newFName = request.getParameter("first_name");
		String newLName = request.getParameter("last_name");
		String newDob = request.getParameter("dob");
		String newEmail= request.getParameter("email");
		String newPassword = request.getParameter("password2");


		//Make an insert statement for the Accounts table:
		String insert = "INSERT INTO end_user_acc(user_id, password, email, first_name, last_name, dob)"
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

		out.print("Insert succeeded!");
		
		//Send Welcome Notification
		String welcome = "INSERT INTO Notification( auction_id, user_id, message, message_date)" 
		+ "VALUES (?, ?, ?, ?)"; 
		
		Timestamp timestamp1 = new Timestamp(new Date().getTime());	 
		
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps2 = con.prepareStatement(welcome);
		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
				ps2.setString(1, "na");
				ps2.setString(2, newUID);
				ps2.setString(3, "Welcome, to Buy Me!");
				ps2.setTimestamp(4, timestamp1);
				//Run the query against the DB
				ps2.executeUpdate();
		
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			con.close();
	} catch (Exception ex) {
		out.print(ex);
		out.print("Insert failed :()");
	}
%>
<br>
<a href="index.jsp">Return To Login Page</a>
</body>
</html>