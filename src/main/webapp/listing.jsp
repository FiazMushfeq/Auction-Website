<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Create a Listing</title>
	</head>
	<body>
		<form method="POST" action="checkListing.jsp">
			Please select a category:
			<select name="category" onchange="selectCategory()" required>
				<option value="">Select One</option>
				<option value="car">Car</option>
				<option value="clothing">Clothing</option>
				<option value="computers">Computers</option>
			</select>
			<input type="submit" value="Confirm"/>
	   	</form>
	  	<script>
	   		function selectCategory() {
	   			var selected = document.getElementById("category");
	   			out.print(selected);
	   		}
	   	</script>
	</body>
</html>