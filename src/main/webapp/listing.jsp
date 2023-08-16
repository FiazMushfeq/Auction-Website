<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Create a Listing</title>
		<style>
            #navbar {
              overflow: hidden;
              background-color: #333;
            }

            #navbar a {
              float: left;
              display: block;
              color: #f2f2f2;
              text-align: center;
              padding: 14px 16px;
              text-decoration: none;
            }

            #navbar a:hover {
              background-color: #ddd;
              color: black;
            }
        </style>
	</head>
	<body>
		<div id="navbar">
            <a href="homepage.jsp">Home</a>
            <a href="listing.jsp">Create Listing</a>
            <a href="userProfile.jsp">My Profile</a>
            <a href="logout.jsp">Logout</a>
            <!-- Add other links as needed -->
        </div>
		<form method="POST" action="checkListing.jsp">
			Please select a category:
			<select name="category" id="category" required>
				<option value="">Select One</option>
				<option value="1">Vehicles</option>
				<!-- Add other categories here -->
			</select>
			Please select a subcategory:
			<select name="subcategory" id="subcategory" required>
				<option value="">Select One</option>
				<option value="1">Automobiles & Motorcycles</option>
				<!-- Add other subcategories here -->
			</select>
			Item Name: <input type="text" name="name" required><br>
			Description: <textarea name="description" required></textarea><br>
			Price: <input type="number" name="price" step="0.01" required><br>
			Image URL: <input type="text" name="image_url"><br>
			<input type="submit" value="Create Listing"/>
	   	</form>
	</body>
</html>
