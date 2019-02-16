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
	<div class="clearfix">
  		<div class="box" style="background-color:#bbb">
   			 <p><a href = "changeCSAccounts.jsp">Customer Service Accounts</a></p>
  		</div>
  		<div class="box" style="background-color:#ccc">
    		<p><a href = "salesReport.jsp">Generate Sales Report</a></p>
  		</div>
 		 <div class="box" style="background-color:#ddd">
   			 <p><a href= "customerQuestions.jsp">Customer Questions</a></p>
  		</div>
	</div>
	<div class = "clearfix">
	<div class="sub_headerbox" style= "background-color:#ddd">
		<h3>Create Customer Service Accounts</h3>
	</div>
	</div>
<br>
<form method="post" action="createCustServAccount.jsp">
	<table>
	<tr>    
	<td>First Name</td><td><input type="text" name="first_name"></td>
	<td>Last Name</td><td><input type="text" name="last_name"></td>
	<td>UserID (ex. "cs.example") </td><td> cs. <input type="text" name="user_id2"></td>
	</tr>
	<tr>  
	<td>DOB (YYYY-MM-DD) </td><td><input type="text" name="dob"></td>  
	<td>E-Mail Address</td><td><input type="text" name="email"></td>
	</tr>
	<tr>
	<td>Password</td><td><input type="text" name="password2"></td>
	</tr>
	</table>
	<input type="submit" value="Create">
</form>

<%if(request.getParameter("removeError") != null) { %>
<p>Error removing customer rep: <%=request.getParameter("removeError")%></p>
<%}%>
<div class = "clearfix">
	<div class="sub_headerbox" style= "background-color:#ddd">
		<h3>Existing Customer Service Accounts</h3>
	</div>
	</div>
<table>
<tr>
<th>User ID</th>
<th>Password</th>
</tr>
<%
ApplicationDB db = new ApplicationDB();
Connection con = db.getConnection();
ResultSet rs = con.createStatement().executeQuery("SELECT * FROM cust_serv_acc;");
while (rs.next()) {%>
<tr>
<td><%=rs.getString("user_id")%></td>
<td><%=rs.getString("password")%></td>
<%-- <td><a href=""><input type="button" value="Remove"></a></td> --%>
</tr>
<%}
con.close();
%>
</table>
</body>
</html>
