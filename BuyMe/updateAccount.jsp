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
	Update your info below!
		<%
		String theDude = request.getParameter("mydude");
		try {

			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			Statement stmt = con.createStatement();
			
			System.out.println("We are trying to make a new account");
			System.out.println("The user is: " + theDude);
			String get = "";
			get = "SELECT * FROM end_user_acc WHERE user_id = \'" + theDude + "\'" ;
			ResultSet result = stmt.executeQuery(get);
			String updates = "";
			
			String newPass = request.getParameter("newPass");
			String newFirst = request.getParameter("newFirst");
			String newLast = request.getParameter("newLast");
			String newEmail = request.getParameter("newEmail");
			String newDOB= request.getParameter("newDOB");
			
			if(result.next())
			{
				System.out.println("We succeeded");
				System.out.println("The old values:" +  result.getString("user_id") + result.getString("password") + result.getString("first_name") + result.getString("last_name") + result.getString("email") + result.getString("DOB"));
				System.out.println("The new (wanted) values:" +  newPass + newFirst + newLast + newEmail + newDOB);
				String dude = result.getString("user_id");
				updates = "UPDATE end_user_acc SET password = \'" + newPass + "\' WHERE user_id = \'" + dude + "\'";
				stmt.executeUpdate(updates);
				updates = "UPDATE end_user_acc SET first_name = \'" + newFirst + "\' WHERE user_id = \'" + dude + "\'";
				stmt.executeUpdate(updates);
				updates = "UPDATE end_user_acc SET last_name = \'" + newLast + "\' WHERE user_id = \'" + dude + "\'";
				stmt.executeUpdate(updates);
				updates = "UPDATE end_user_acc SET email = \'" + newEmail + "\' WHERE user_id = \'" + dude + "\'";
				stmt.executeUpdate(updates);
				updates = "UPDATE end_user_acc SET DOB = \'" + newDOB + "\' WHERE user_id = \'" + dude + "\'";
				stmt.executeUpdate(updates);
				
				System.out.println("We're Done!!!");
				}
			else
			{
				System.out.println("We failed");
			}
			
			
			String redirectURL = "logout.jsp";
		    response.sendRedirect(redirectURL);
			
			con.close();
			
			
		}
		catch (Exception ex) 
		{
			out.print(ex);
			out.print("Something went wrong :(");
		}
		%>
</body>
</html>