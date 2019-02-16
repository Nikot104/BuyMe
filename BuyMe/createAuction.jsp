<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Auction Created!</title>
</head>
<body>
	<%
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		

		//Get param
		String newItem = request.getParameter("item_name");
		String newDesc = request.getParameter("description");
		String newCata = request.getParameter("category");
		String newLow = request.getParameter("lower_bound");
		String newStart= request.getParameter("start_price");
		String newEndD = request.getParameter("end_date_time");

		
		//Special Instruction for specific items
		String newDimCell = request.getParameter("dimensions_cell");
		String newDimComp = request.getParameter("dimensions_comp");
		String newWeight = request.getParameter("weight");
		String newBlue = request.getParameter("bluetooth");
		String newNoise = request.getParameter("noise_canceling");		
		
		if(newBlue == null)
			newBlue = "0";
		if(newNoise == null)
			newNoise = "0";	
		
		//String random = "" + (int)(Math.random()*1000000);
		String random = "960335";
		boolean cont = true;
		String str1 = "SELECT * FROM Auctions Where auction_id = \'" ;

		//Create a SQL statement
		
		loop:
		while(cont){
			PreparedStatement stmt1 = con.prepareStatement(str1 + random + "\'");
			out.print(stmt1 + "\n");
			ResultSet result1 = stmt1.executeQuery();
			if(!result1.next()){
				break loop;
			}else{
				random = ((int)(Math.random()*100000)) +"";
			}
			
		}
		
		
		
		
		//Run the query against the database.		
		String auction_id = random;
		String auction_table_insert = "INSERT into Auctions(auction_id) VALUES(\'"+ auction_id +"\')";
		out.print(auction_table_insert);
		PreparedStatement auction_ps = con.prepareStatement(auction_table_insert);
		auction_ps.executeUpdate();
		
		//Make an insert statement for the Accounts table:
		String insert = "";

		if(newCata.compareTo("cell_phone") == 0)
		insert = "INSERT INTO Cellphone_Auctions( user_id ,auction_id, item_name, description, category, lower_bound, start_price, end_date_time, dimensions, curr_bid_price,status)"
				+ "VALUES (?,?, ?, ?, ?, ?, ?, ?, ?, ?,?)"; 
		if(newCata.compareTo("computer") == 0)
			insert = "INSERT INTO Computer_Auctions(user_id ,auction_id, item_name, description, category, lower_bound, start_price, end_date_time, dimensions, weight, curr_bid_price, status)"
					+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?)"; 
		if(newCata.compareTo("headphones") == 0)
			insert = "INSERT INTO Headphone_Auctions(user_id ,auction_id, item_name, description, category, lower_bound, start_price, end_date_time, noise_cancelling, bluetooth, curr_bid_price, status)"
					+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?)"; 
		
		
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps = con.prepareStatement(insert);

		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		String user = (String)session.getAttribute("user");
		ps.setString(1, user);
		ps.setString(2, auction_id);
		ps.setString(3, newItem);
		ps.setString(4, newDesc);
		ps.setString(5, newCata);
		ps.setString(6, newLow);
		ps.setString(7, newStart);
		ps.setString(8, newEndD);
		
		
		if(newCata.compareTo("cell_phone") == 0 )
		{
			ps.setString(9, newDimCell);
			ps.setInt(10, 0);
			ps.setString(11, "open");
		}
		if(newCata.compareTo("computer") == 0)
		{
			ps.setString(9, newDimComp);
			ps.setString(10, newWeight);
			ps.setInt(11, 0);
			ps.setString(12, "open");
		}
		if(newCata.compareTo("headphones") == 0 )
		{
			ps.setString(9, newBlue);
			ps.setString(10, newNoise);
			ps.setInt(11, 0);
			ps.setString(12, "open");
		}
		//Run the query against the DB
		ps.executeUpdate();

		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.

		out.print("Insert succeeded!");
		
		
		session.setAttribute("auctionID", auction_id);
		session.setAttribute("auctionCat", newCata);
		String redirectURL = "mainPage.jsp";
	    response.sendRedirect(redirectURL);
		
		con.close();
	    
	} catch (Exception ex) {
		out.print(ex);
		out.print("Insert failed :()");
	}
	

%>
<br>
<a href="mainPage.jsp">Return To Main Page</a>
</body>
</html>