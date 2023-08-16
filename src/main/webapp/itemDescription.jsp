<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Item Description</title>
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
            <a href="logout.jsp">Logout</a>
            <!-- Add other links as needed -->
        </div>
    <%
        ApplicationDB db = new ApplicationDB();
        Connection con = db.getConnection();
        int itemId = Integer.parseInt(request.getParameter("itemId")); // Assuming the item ID is passed as a parameter
        
        String query = "SELECT * FROM item WHERE id = ?";
        PreparedStatement pstmt = con.prepareStatement(query);
        pstmt.setInt(1, itemId);
        ResultSet rs = pstmt.executeQuery();
        
        if (rs.next()) {
            String itemName = rs.getString("name");
            String itemDescription = rs.getString("description");
            double itemPrice = rs.getDouble("price");
            String itemImage = rs.getString("image_url");
    %>
            <h1><%= itemName %></h1>
            <img src="<%= itemImage %>" alt="<%= itemName %>" width="350" height="300">
            <p><%= itemDescription %></p>
            <p>Price: $<%= itemPrice %></p>
            <button>Add to Cart</button>
            <button>Bid</button>
    <%
        } else {
            out.print("Item not found!");
        }
        
        db.closeConnection(con);
    %>
    
    <!-- Navigation Links -->
    <a href="homepage.jsp">Home</a>
    <a href="profile.jsp">Profile</a>
    <a href="logout.jsp">Logout</a>
</body>
</html>
