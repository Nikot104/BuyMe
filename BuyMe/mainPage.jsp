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

	<div class="clearfix">
  		<div class="box" style="background-color:#bbb">
   			 <p><a href = "editAccountBefore.jsp">Edit Account</a></p>
  		</div>
  		<div class="box" style="background-color:#ccc">
    		<p><a href = "create.jsp">Create Auction</a></p>
  		</div>
 		 <div class="box" style="background-color:#ddd">
   			 <p><a href= "currentAuctions.jsp">Current Auctions</a></p>
  		</div>
	</div>
<br>
<br>

<div class = "clearfix">
	<div class="sub_headerbox" style= "background-color:#ddd">
		<h3>My Notifications</h3>
	</div>
</div>

<%
 //retrieve data
	 try{
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			String str1 = "SELECT * FROM Notification WHERE user_id = \'" + session.getAttribute("user")
			+ "\' ORDER BY message_date DESC";		
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
			out.print("Message Date");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("Message");
			out.print("</td>");
			out.print("</tr>");
		%>
		
		<form method = "get" action = "auctionPage.jsp"><% 	
			while(result1.next()){
				//make a row
				out.print("<tr>");
				//make a column
				out.print("<td>");
				//Print out Auction ID
				if(result1.getString("auction_id").equals("na")){
					out.print(result1.getString("auction_id"));	
				}else{%>
				<button name = "result" type= "submit" value = <%= result1.getString("auction_id") %>>
				<%= result1.getString("auction_id") %></button>
				<%	
				}	
				out.print("</td>");
				out.print("<td>");
				//Print out current Message Date:
				out.print(result1.getString("message_date"));
				out.print("</td>");
				out.print("<td>");
				//Print out Message:
				out.print(result1.getString("message"));
				out.print("</td>");
				out.print("</tr>");

			}
		%></form><%
		//close the connection.
			con.close();
 	}catch(Exception ex){
	 out.print(ex);
 	}

%>
		

</body>
</html>
