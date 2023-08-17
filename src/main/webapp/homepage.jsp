<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Home Page</title>
		<style>
			.grid-container {
				display: grid;
				grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
				gap: 20px;
				padding: 20px;
			}
			.grid-item {
				border: 1px solid #ccc;
				padding: 20px;
				text-align: center;
			}
			.grid-item img {
				max-width: 100%;
				height: auto;
			}
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
            <a href="logout.jsp">Logout</a>
            <!-- Add other links as needed -->
        </div>
		<% 
			try {
				//Get the database connection
				ApplicationDB db = new ApplicationDB();	
				Connection con = db.getConnection();
				if(session.getAttribute("username") == null) {
					out.print("Account not found!");
					%>
						<a href="register.jsp">Register?</a>
					<%
				} else {
					out.print("Welcome to your BuyMe homepage, " + session.getAttribute("username").toString() + "!");
					%>
						<a href="listing.jsp">Create a listing</a>
						<br/>
						<h2>Items Available for Auction:</h2>
						<div class="grid-container">
							<%
								Statement stmt = con.createStatement();
								ResultSet rs = stmt.executeQuery("SELECT * FROM item");
								while(rs.next()) {
							%>
								<div class="grid-item">
									<a href="itemDescription.jsp?itemId=<%= rs.getInt("id") %>">
										<img src="<%= rs.getString("image_url") %>" alt="<%= rs.getString("name") %>">
										<h3><%= rs.getString("name") %></h3>
										<p>Price: <%= rs.getDouble("price") %></p>
									</a>
								</div>
							<%
								}
							%>
						</div>
					<%
				}
			} catch (Exception e) {
				out.print(e);
				%>
					<a href="login.jsp">Login!</a>
				<%
			}
		%>
	</body>
</html>
