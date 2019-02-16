<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Create Your Auction</title>
</head>
<body>
Enter auction information below:
<br>
<form method="post" action="createAuction.jsp">
	<table>
	<tr>    
	<td>Item Name</td><td><input type="text" name="item_name"></td>
	</tr>
	<tr>
	<td>Description</td><td><input type="text" name="description"></td>
	</tr>
	<tr>  
	<td>Category</td><td><select name="category">
 	 <option value="cell_phone">Cell Phone</option>
 	 <option value="computer">Computer</option>
	 <option value="headphones">Headphones</option>
	</select></td> 
	</tr>
	<tr>
	<td></td><td>IF CELLPHONE</td>
	</tr>
	<tr>
	<td>Dimensions</td><td><input type="text" name="dimensions_cell"></td>    
	</tr>
	<tr>
	<td></td><td>IF COMPUTER</td>
	</tr>
	<tr>
	<td>Dimensions</td><td><input type="text" name="dimensions_comp"></td>  
	<td>Weight</td><td><input type="text" name="weight"></td>    
	</tr>
	<tr>
	<td></td><td>IF HEADPHONES</td>
	</tr>
	<tr>
	<td>Blue Tooth</td><td><input type="checkbox" name="bluetooth" value="1"></td>   
	<td>Noise Canceling</td><td><input type="checkbox" name="noise_canceling" value='1'></td>   
	</tr>
	<tr>
	<td>Reserve Price</td><td><input type="number" name="lower_bound" value = 0></td>    
	<td>Start Price</td><td><input type="number" name="start_price"></td>
	</tr>
	<tr>
	<td>End Date</td><td><input type="date" name="end_date_time" value = "yyyy-mm-dd HH:MM" ></td>
	
	</tr>
	</table>
	<input type="submit" value="Create">
	</form>
</body>
</html>