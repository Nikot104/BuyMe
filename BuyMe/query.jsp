<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login Details</title>
</head>
<body>
	<%
		List<String> list = new ArrayList<String>();

		try {

			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			//Create a SQL statement
			String user_id = request.getParameter("user_ID");
			String password = request.getParameter("password");
			
			PreparedStatement stmt = con.prepareStatement("SELECT * FROM admin_acc WHERE user_id=? AND password=?");
			stmt.setString(1, user_id);
			stmt.setString(2, password);
			ResultSet result = stmt.executeQuery();

			if (result.next()) {
				session.setAttribute("user", user_id);
				String redirectURL = "mainAdminPage.jsp";
			    response.sendRedirect(redirectURL);
			
			// Check customer service account
			} else {
				
				stmt = con.prepareStatement("SELECT * FROM cust_serv_acc WHERE user_id=? AND password=?");
				stmt.setString(1, user_id);
				stmt.setString(2, password);
				result = stmt.executeQuery();
				
				if (result.next()) {
					session.setAttribute("user", user_id);
					String redirectURL = "mainCustServPage.jsp";
				    response.sendRedirect(redirectURL);
				
				// Check user account
				} else {
					
					stmt = con.prepareStatement("SELECT * FROM end_user_acc WHERE user_id=? AND password=?");
					stmt.setString(1, user_id);
					stmt.setString(2, password);
					result = stmt.executeQuery();
					
					if (result.next()) {
						session.setAttribute("user", user_id);
						String redirectURL = "mainPage.jsp";
					    response.sendRedirect(redirectURL);
					    
					// No user found
					} else {
						out.print("invalid user!");
					}
				}
			}

			//close the connection.
			con.close();
		
		} catch (Exception e) {
			out.print("Error connecting");
			e.printStackTrace();
		}
	%>
	<br>
<a href="index.jsp">Return to login page!</a>
</body>
</html>