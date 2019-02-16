<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<style>
* {
    box-sizing: border-box;
}
.headerbox{
	float: left;
	width: 100%;
	padding-left: 30px;
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
<%
			String id = request.getParameter("result");
			
			List<String> list = new ArrayList<String>();

try {

	//Get the database connection
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();	
	
	
	System.out.println("We are searching");
	//Create a SQL statement
	Statement stmt = con.createStatement();
	String str = "";
	str = "SELECT * FROM Computer_Auctions WHERE auction_id = \'" + id
			+ "\'";
	//Run the query against the database.
	ResultSet result = stmt.executeQuery(str);
	
	String end = "";
	
	System.out.println("We searched");
	if(result.next())
	{
		System.out.println("We found it");
	}
	else
	{
		System.out.println("none found, trying another table");
		str = "SELECT * FROM Cellphone_Auctions WHERE auction_id = \'" + id
				+ "\'";
		
		result = stmt.executeQuery(str);
		if(result.next())
		{
			System.out.println("We found it");
		}
		else
		{
			System.out.println("none found, trying another table");
			str = "SELECT * FROM Headphone_Auctions WHERE auction_id = \'" + id
					+ "\'";
			
			result = stmt.executeQuery(str);
			if(result.next())
			{
				System.out.println("We found it");
			}
			else
			{
				System.out.println("rip");
			}
		}
	}
	
	end = result.getString("auction_id");
	String owner = result.getString("user_id");
	String name = result.getString("item_name");
	String descrip = result.getString("description");
	String start = result.getString("start_price");
	int curr_bid = result.getInt("curr_bid_price");
	String status = result.getString("status");
	String cat = result.getString("category");
	session.setAttribute("cat", cat);
	
	
	out.println("Auction ID: " + end);
	%> <form method = 'get' action = 'userInfo.jsp'> 
	Owner: <button name = "userInfo" type= "submit" 
		value = <%= owner %>>
		<%= owner %></button>
	</form>
	
	<% 

	out.println("<br>");
	out.println("Item Name:" + name);
	out.println("<br>");
	out.println("Description: " + descrip);
	out.println("<br>");
	out.println("Category: " + cat);
	out.println("<br>");
	out.println("The sale ends: " + result.getTimestamp("end_date_time") );
	out.println("<br>");
	out.println("Start Price: $" + start);
	out.println("<br>");
	out.println("Current Bid Price: $" + curr_bid);
	out.println("<br>");
	out.println("Status: " + status);
	out.println("<br>");
	
	if(status.equals("open")){%>
	<br>
	<form method="post" action="updateAuction.jsp">
	<table>
	<tr>
	<td><input type="hidden" name="mydata" value="<%=id%>"></td>
	</tr>
	<tr>
	<td>
	Input Value Greater Than Current Bid Price  $</td><td>
	<input type="text" name="bid" value= <%=curr_bid==0?start:curr_bid+10 %>></td>
	</tr>
	</table>
	<input type="submit" value="Bid">
	</form>
	
<br>
	<form method="post" action="updateAuction.jsp">
	<table>
	<tr>
	<td><input type="hidden" name="mydata" value="<%=id%>"></td>
	</tr>
	<tr>
	<td>Value  $</td><td><input type="text" name="auto_bid"></td>
	</tr>
	</table>
	<input type="submit" value="Set Auto-Bid">
	</form>
	
	<%} %>
	<div class = "clearfix">
	<div class="sub_headerbox" style= "background-color:#ddd">
		<h3>Bid History</h3>
	</div>
</div>
	<% 
	String bid_hist= "SELECT * FROM Bids WHERE auction_id =\'"+ id +"\' ORDER BY bid_date_time DESC";
	PreparedStatement bid_hist_ps = con.prepareStatement(bid_hist);
	ResultSet bid_hist_rs = bid_hist_ps.executeQuery();
	
	//Make an HTML table to show the results in:
			out.print("<table>");

			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
			//print out column header
			out.print("User ID");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("Date & Time");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("Value");
			out.print("</td>");
			out.print("</tr>");
			
			while (bid_hist_rs.next()) {
				//make a row
				out.print("<tr>");
				//make a column
				out.print("<td>");
				//Print out current user:
				out.print(bid_hist_rs.getString("user_id"));
				out.print("</td>");
				out.print("<td>");
				//Print out current date & time:
				out.print(bid_hist_rs.getString("bid_date_time"));
				out.print("</td>");
				out.print("<td>");
				//Print out start val
				out.print("$" + bid_hist_rs.getString("val"));
				out.print("</td>");
				out.print("</tr>");

			}
	
	//close the connection.
	con.close();

} catch (Exception e) {
}

 
%>


</body>
</html>
