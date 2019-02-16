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
			String cat = (String)session.getAttribute("cat");
			out.print(cat);
			String auction_table = "";
			if(cat.equals("cell_phone")){
				auction_table = "Cellphone_Auctions";
			}else{
				if(cat.equals("computer")){
					auction_table = "Computer_Auctions";
				}else{
					auction_table = "Headphone_Auctions";
				}
			}
			//get last highest bidder
			String last_bidder = "SELECT * FROM Bids WHERE auction_id = \'" + theID 
			+ "\' AND val = (SELECT MAX(val) FROM Bids WHERE auction_id =\'" + theID + "\')";
			PreparedStatement ps1 = con.prepareStatement(last_bidder);
			ResultSet last_bidder_info = ps1.executeQuery();
			
			if(last_bidder_info.next()){
				//Send Bid Alert
				String alert = "INSERT INTO Notification( auction_id, user_id, message, message_date)" 
				+ "VALUES (?, ?, ?, ?)"; 
				
				Timestamp alert_time = new Timestamp(new Date().getTime());	 
				
				//Create a Prepared SQL statement allowing you to introduce the parameters of the query
				PreparedStatement ps2 = con.prepareStatement(alert);
				
				//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
						ps2.setString(1, theID);
						ps2.setString(2, last_bidder_info.getString("user_id"));
						ps2.setString(3, "You have been outbid!");
						ps2.setTimestamp(4, alert_time);
						//Run the query against the DB
						ps2.executeUpdate();
			}
			
			//char added
			String curr_user = (String)session.getAttribute("user");
			
			System.out.println("The transfered data is: " + theID);
			String str = "UPDATE "+ auction_table +" SET curr_bid_price = \'" + bid + "\' WHERE auction_id = \'" + theID + "\'";
			System.out.println(str);
			//Run the query against the database.
			stmt.executeUpdate(str);
			

			System.out.println("Update successful");
			
			//char added
			Timestamp timestamp1 = new Timestamp(new Date().getTime());	
			int val = Integer.parseInt(bid);
			String str2 = "SELECT * FROM Bids WHERE auction_id = \'" + theID + "\' AND val > " + val;
			ResultSet result = stmt.executeQuery(str2);
			
			if(!result.next()){
				//Create Statement
				Statement stmt2 = con.createStatement();
				String str3 = "INSERT INTO Bids(user_id, auction_id, bid_date_time, val)" + "VALUES (\'"+
				curr_user +"\', \'"+ theID +"\', \'"+ timestamp1 +"\', "+ val +")"; ;
				out.print(str3);
				stmt.executeUpdate(str3);
				out.print(str3);
			}
			//close the connection.
			con.close();
		
		} catch (Exception e) {
		}
		String redirectURL = "mainPage.jsp";
		response.sendRedirect(redirectURL);

	%>
	
</body>
</html>