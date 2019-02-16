<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<title>Buy Me Search</title>
</head>
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
<body>
<div class = "clearfix">
	<%if(session.getAttribute("user")== null) {
	%> Login Error, Please Try Again. <br>
	<%}else{ %>
	Welcome, <%= session.getAttribute("user") %>!
	<%} %><a href = 'logout.jsp'>    Logout</a>
	
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
List<String> list = new ArrayList<String>();
try{	
	
	//Get the database connection
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();	
	
	//Get search params
	String Obj_Type = request.getParameter("objectType");
	String keywords = request.getParameter("keywords");
	String sort = request.getParameter("sort_by");
	
	//Create generic statement
	Statement stmt = con.createStatement();
	String str = "SELECT * FROM " ;

	//Set table to search from 
	if(Obj_Type.equals("Computer")){
		Obj_Type = "Computer_Auctions";
	}else{
		if(Obj_Type.equals("Cellphone")){
			Obj_Type = "Cellphone_Auctions";
		}else{
			Obj_Type = "Headphone_Auctions";
		}
	}
	str = str + Obj_Type;
	//Handle keywords
	//split keywords by spaces
	String[] keywords_arr = keywords.split("\\s+");
	
	//create statement
	if(keywords_arr.length>1){
		str = str + " WHERE ";
		for(String keyword: keywords_arr){
			str = str + "(item_name LIKE \'%" + keyword + "%\' OR description LIKE \'%" + keyword + "%\') AND ";
		}
		str =str.substring(0, str.length() -4);
		}else{
		str = str + " WHERE item_name LIKE \'%" + keywords_arr[0] + "%\' OR description LIKE \'%" + keywords_arr[0] + "%\'";
	}
	
	String sort_stmt = "ORDER BY ";
	if(sort.equals("price")){
		sort_stmt = sort_stmt + "start_price ASC";
	}else{
		if(sort.equals("item_name")){
			sort_stmt = sort_stmt + "item_name ASC";
		}else{
			sort_stmt = sort_stmt + "status DESC";
		}
	}
	ResultSet result = stmt.executeQuery(str + sort_stmt);
	
	//Make an HTML table to show the results in:
	out.print("<table>");

	//make a row
	out.print("<tr>");
	//make a column
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
	out.print("Start Price");
	out.print("</td>");
	//make a column
	out.print("<td>");
	out.print("End Date");
	out.print("</td>");
	out.print("<td>");
	out.print("Status");
	out.print("</td>");
	out.print("</tr>");



	//parse out the results
	%>
	<form method = "get" action = "auctionPage.jsp">
	<% 
	while (result.next()) {
		//make a row
		out.print("<tr>");
		//make a column
		out.print("<td>");
		//Print out current item name: %>
		<button name = "result" type= "submit" 
		value = <%= result.getString("auction_id") %>>
		<%= result.getString("item_name") %></button>
		<% 
		out.print("</td>");
		out.print("<td>");
		//Print out current description:
		out.print(result.getString("description"));
		out.print("</td>");
		out.print("<td>");
		//Print out start price
		out.print("$" + result.getString("start_price"));
		out.print("</td>");
		out.print("<td>");
		//Print out end date
		out.print(result.getString("end_date_time"));
		out.print("</td>");
		out.print("<td>");
		//Print out end date
		out.print(result.getString("status"));
		out.print("</td>");
		out.print("</tr>");

	}
	out.print("</table>");
	%>
	</form>
	<% 
	//close the connection.
	con.close();
	
}catch (Exception e){
	
}


%>


</body>
</html>