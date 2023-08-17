<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>User Profile</title>
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
            <a href="userProfile.jsp"> My Profile</a>
            <a href="search.jsp">Search</a>
            <a href="buyerAuctions.jsp">View Buyer Auctions</a>
			<a href="sellerAuctions.jsp">View Seller Auctions</a> 
            <a href="logout.jsp">Logout</a>
            <!-- Add other links as needed -->
        </div>
		<h1>Welcome, <%= session.getAttribute("username") %>!</h1>
		<h2>Current Profile Information</h2>
		<p>Email: <%= session.getAttribute("email") %></p>
		<p>First Name: <%= session.getAttribute("firstName") %></p>
		<p>Last Name: <%= session.getAttribute("lastName") %></p>
		<p>Username: <%= session.getAttribute("username") %></p>
		
		<h2>Update Profile Information</h2>
		<form method="POST" action="updateProfile.jsp">
			<label for="email">Email:</label>
			<input type="email" name="email" value="<%= session.getAttribute("email") %>" required><br>
			<label for="firstName">First Name:</label>
			<input type="text" name="firstName" value="<%= session.getAttribute("firstName") %>" required><br>
			<label for="lastName">Last Name:</label>
			<input type="text" name="lastName" value="<%= session.getAttribute("lastName") %>" required><br>
			<label for="password">Password:</label>
			<input type="password" name="password" required><br>
			<input type="submit" value="Update Profile">
		</form>
		

		<!-- Rest of the code remains the same -->
	</body>
</html>
