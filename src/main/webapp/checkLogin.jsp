<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
   <head>
   		<meta charset="UTF-8">
    	<title>Checking Login Info</title>
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
		<% 
			try {
				//Get the database connection
				ApplicationDB db = new ApplicationDB();	
				Connection con = db.getConnection();		
				//Create a SQL statement
				Statement stmt = con.createStatement();
				//Get username and password
				String username = request.getParameter("username");
				String password = request.getParameter("password");
				//Make a SELECT query for username
				String str = "SELECT * FROM users WHERE `username` = '" + username + "' AND `password` = '" + password + "'";
				//Run the query against the database.
				ResultSet result = stmt.executeQuery(str);
				if(result.next()) {
					session.setAttribute("username", username);
					session.setAttribute("userId", result.getInt("id")); // Assuming "id" is the column name for the user ID
					%>
						
					<%
				} else {
					out.print("Invalid/Incorrect username or password!");
					%>
						<a href="login.jsp">Retry Logging In!</a>
					<%
				}
				db.closeConnection(con);
			} catch (Exception e) { // incorrect login
				out.print(e);
				%>
					<a href="login.jsp">Retry Logging In!</a>
				<%
			}
		%>
   </body>
</html>
