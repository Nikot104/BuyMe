<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<style>
* {
    box-sizing: border-box;
}
.headerbox{
	float: left;
	width: 100%;
	padding-left: 30px;
}

.sub_headerbox{
	float: left;
	width: 100%;
	padding-left: 10px;
}

.box {
    float: left;
    width: 33.33%;
    padding: 5px;
    padding-left: 55px;
}

.clearfix::after {
    content: "";
    clear: both;
    display: table;
}
</style>
</head>
<body>
	<%if(session.getAttribute("user")== null) {
	%> Login Error, Please Try Again. <br>
	<%}else{ %>
	Welcome, <%= session.getAttribute("user") %>!
	<%} %><a href = 'logout.jsp'>    Logout</a>


	<div class = "clearfix">
	<div class="headerbox" style= "background-color:#bbb">
		<h2><a href ="mainPage.jsp">Buy Me!</a></h2>
	</div>
	</div>
	<br>
	<form method = "post" action= "search.jsp"> Search For Item
		<select name = "objectType">
 			 <option value="Computer">Computer</option>
 			 <option value="Cellphone">Cellphone</option>
  			<option value="Headphones">Headphones</option>
		</select>
		<select name = "sort_by">
 			 <option value="price">Sort By Price</option>
 			 <option value="item_name">Sort By Name</option>
  			<option value="status">Sort By Status</option>
		</select>
		<input type = "text" name= "keywords">
		<input type = "submit" value = "Search Now!">
		</form>
		<br>

	
	<div class = "clearfix">
	<div class="sub_headerbox" style= "background-color:#ddd">
		<h3>Profile</h3>
	</div>
	</div>
	<% String current_user_profile = request.getParameter("userInfo");
	out.print("User:\t"+ current_user_profile);
	
	%>
	<div class = "clearfix">
	<div class="sub_headerbox" style= "background-color:#ddd">
		<h3>Auctions Created</h3>
	</div>
	</div>

	<%
	//retrieve table of current auctions
	try{
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		String str1 = "SELECT * FROM Headphone_Auctions WHERE user_id = \'" + current_user_profile
		+ "\'";
		String str2 = "SELECT * FROM Cellphone_Auctions WHERE user_id = \'" + current_user_profile
		+ "\'";
		String str3 = "SELECT * FROM Computer_Auctions WHERE user_id = \'" + current_user_profile
		+ "\'";
		
		PreparedStatement stmt1 = con.prepareStatement(str1);
		ResultSet result1 = stmt1.executeQuery();
		
		//Make an HTML table to show the results in:
		out.print("<table>");

		//make a row
		out.print("<tr>");
		//make a column
		out.print("<td>");
		//print out column header
		out.print("Auction ID");
		out.print("</td>");
		out.print("<td>");
		//print out column header
		out.print("Item Name");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("Description");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("Current Bid");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("End Date");
		out.print("</td>");
		out.print("<td>");
		out.print("Status");
		out.print("</td>");
		out.print("</tr>");
		
		%>
		<form method = "get" action = "auctionPage.jsp">
		<% 
		while (result1.next()) {
			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
			//Print out current description:
			out.print(result1.getString("auction_id"));
			out.print("</td>");
			out.print("<td>");
			//Print out current item name: %>
			<button name = "result" type= "submit" 
			value = <%= result1.getString("auction_id") %>>
			<%= result1.getString("item_name") %></button>
			<% 
			out.print("</td>");
			out.print("<td>");
			//Print out current description:
			out.print(result1.getString("description"));
			out.print("</td>");
			out.print("<td>");
			//Print out start price
			out.print("$" + result1.getString("curr_bid_price"));
			out.print("</td>");
			out.print("<td>");
			//Print out end date
			out.print(result1.getString("end_date_time"));
			out.print("</td>");
			out.print("<td>");
			//Print out end date
			out.print(result1.getString("status"));
			out.print("</td>");
			out.print("</tr>");

		}
		%>
		</form>
		
		<% 
		PreparedStatement stmt2 = con.prepareStatement(str2);
		ResultSet result2 = stmt2.executeQuery();
		%>
		
		<form method = "get" action = "auctionPage.jsp">
		<% 
		while (result2.next()) {
			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
			//Print out current description:
			out.print(result2.getString("auction_id"));
			out.print("</td>");
			out.print("<td>");
			//Print out current item name: %>
			<button name = "result" type= "submit" 
			value = <%= result2.getString("auction_id") %>>
			<%= result2.getString("item_name") %></button>
			<% 
			out.print("</td>");
			out.print("<td>");
			//Print out current description:
			out.print(result2.getString("description"));
			out.print("</td>");
			out.print("<td>");
			//Print out start price
			out.print("$" + result2.getString("curr_bid_price"));
			out.print("</td>");
			out.print("<td>");
			//Print out end date
			out.print(result2.getString("end_date_time"));
			out.print("</td>");
			out.print("<td>");
			//Print out end date
			out.print(result2.getString("status"));
			out.print("</td>");
			out.print("</tr>");

		}

		%>
		</form>
		
		<% 
		PreparedStatement stmt3 = con.prepareStatement(str3);
		ResultSet result3 = stmt3.executeQuery();
		%>
		
		<form method = "get" action = "auctionPage.jsp">
		<% 
		while (result3.next()) {
			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
			//Print out current description:
			out.print(result3.getString("auction_id"));
			out.print("</td>");
			out.print("<td>");
			//Print out current item name: %>
			<button name = "result" type= "submit" 
			value = <%= result3.getString("auction_id") %>>
			<%= result3.getString("item_name") %></button>
			<% 
			out.print("</td>");
			out.print("<td>");
			//Print out current description:
			out.print(result3.getString("description"));
			out.print("</td>");
			out.print("<td>");
			//Print out start price
			out.print("$" + result3.getString("curr_bid_price"));
			out.print("</td>");
			out.print("<td>");
			//Print out end date
			out.print(result3.getString("end_date_time"));
			out.print("</td>");
			out.print("<td>");
			//Print out end date
			out.print(result3.getString("status"));
			out.print("</td>");
			out.print("</tr>");

		}
		out.print("</table>");
		%>
		</form>
		<div class = "clearfix">
	<div class="sub_headerbox" style= "background-color:#ddd">
		<h3>Auctions Participated</h3>
	</div>
	</div>
		<% String participation_qr ="select auction_id, item_name, status" +
									" from Computer_Auctions" +
									" where auction_id in (select distinct auction_id from Bids where user_id= \'"+
									current_user_profile +"\')" +
									" union " +
									"select auction_id, item_name, status" +
									" from Cellphone_Auctions" +
									" where auction_id in (select distinct auction_id from Bids where user_id= \'"+
									current_user_profile +"\')" +
									" union " +
									"select auction_id, item_name, status" +
									" from Headphone_Auctions" +
									" where auction_id in (select distinct auction_id from Bids where user_id= \'"+
									current_user_profile +"\')";
		PreparedStatement parti_ps = con.prepareStatement(participation_qr);
		ResultSet parti_rs = parti_ps.executeQuery();
		
		//Make an HTML table to show the results in:
		out.print("<table>");

		//make a row
		out.print("<tr>");
		//make a column
		out.print("<td>");
		//print out column header
		out.print("Auction ID");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("Item Name");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("Status");
		out.print("</td>");
		out.print("</tr>");
		%>
		<form method ="get" action="auctionPage.jsp">
		<% 
		
		while (parti_rs.next()) {
			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
			//Print out current auction id: %>
			<button name = "result" type= "submit" 
			value = <%= parti_rs.getString("auction_id") %>>
			<%= parti_rs.getString("auction_id") %></button>
			<% 
			out.print("</td>");
			out.print("<td>");
			//Print out current date & time:
			out.print(parti_rs.getString("item_name"));
			out.print("</td>");
			out.print("<td>");
			//Print out start val
			out.print( parti_rs.getString("status"));
			out.print("</td>");
			out.print("</tr>");

		}
		%>
		</form>
		
		<% 
		out.print("</table>");
		
		//close the connection.
		con.close();
		
		
	}catch(Exception ex){
		out.print(ex);
	}
	%>

</body>
</html>
