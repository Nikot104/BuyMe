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
		<h2><a href ="mainAdminPage.jsp">Buy Me!</a></h2>
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
<br>
<br>


</body>
</html>
