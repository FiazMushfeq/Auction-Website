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
            <a href="search.jsp">Search</a> 
            <a href="logout.jsp">Logout</a>
            <!-- Add other links as needed -->
        </div>
        </body>
        </html>
<%
    int categoryId = Integer.parseInt(request.getParameter("category"));
    int subcategoryId = Integer.parseInt(request.getParameter("subcategory"));
    int colorId = Integer.parseInt(request.getParameter("color"));
 // Commenting out body type functionality
  int bodyTypeId = Integer.parseInt(request.getParameter("body_type"));
    int year = Integer.parseInt(request.getParameter("year"));
    String name = request.getParameter("name");
    String description = request.getParameter("description");
    double bidIncrement = Double.parseDouble(request.getParameter("bid_increment"));
    double initialPrice = Double.parseDouble(request.getParameter("price"));
    String imageUrl = request.getParameter("image_url");
    int sellerId = (int) session.getAttribute("userId");

    try {
        ApplicationDB db = new ApplicationDB();
        Connection con = db.getConnection();
        Timestamp closingTime = new Timestamp(System.currentTimeMillis() + 7 * 24 * 60 * 60 * 1000L);
        PreparedStatement ps = con.prepareStatement("INSERT INTO item (name, description, price, bid_increment, closing_time, image_url, seller_id, subcategory_id, color_id, body_type_id, year) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
        ps.setString(1, name);
        ps.setString(2, description);
        ps.setDouble(3, initialPrice);
        ps.setDouble(4, bidIncrement);
        ps.setTimestamp(5, closingTime);
        ps.setString(6, imageUrl);
        ps.setInt(7, sellerId);
        ps.setInt(8, subcategoryId);
        ps.setInt(9, colorId);
       ps.setInt(10, bodyTypeId);
        ps.setInt(11, year);
        ps.executeUpdate();

        out.print("Listing created successfully!");
        // Redirect to home page or another relevant page
    } catch (Exception e) {
        out.print("An error occurred: " + e.getMessage());
        // Redirect to error page or provide a link back to listing.jsp
    }
%>
