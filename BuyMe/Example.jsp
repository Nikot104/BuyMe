<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*, java.util.Date"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Updating Auction</title>
</head>
<body>
	<%
		List<String> list = new ArrayList<String>();

		try {

			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			String bid = request.getParameter("bid");
			String biddy = request.getParameter("auto_bid");
			String theID = request.getParameter("mydata");
			//char added
			String curr_user = (String)session.getAttribute("user");
			
			System.out.println("The transfered data is: " + theID);
			String str = "UPDATE Computer_Auctions SET curr_bid_price = \'" + bid + "\' WHERE auction_id = \'" + theID + "\'";
			//Run the query against the database.
			stmt.executeUpdate(str);
			

			System.out.println("Update successful");
			
			//char added
			Timestamp timestamp1 = new Timestamp(new Date().getTime());	
			int val = Integer.parseInt(bid);
			String str2 = "SELECT * FROM Bids WHERE auction_id = \'" + theID + "\' AND val > " + val;
			ResultSet result = stmt.executeQuery(str2);
			
			if(!result.next()){
				//Make an insert statement for the Accounts table:
				String insert = "INSERT INTO Bids(user_id, auction_id, bid_date_time, val)"
						+ "VALUES (?, ?, ?, ?)"; 
				
				//Create a Prepared SQL statement allowing you to introduce the parameters of the query
				PreparedStatement ps = con.prepareStatement(insert);

				//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
				ps.setString(1, curr_user);
				ps.setString(2, theID);
				ps.setTimestamp(3, timestamp1);
				ps.setInt(4, val);
				ps.executeUpdate();
			}
			//close the connection.
			con.close();
		
		} catch (Exception e) {
		}
	%>
	
</body>
</html>