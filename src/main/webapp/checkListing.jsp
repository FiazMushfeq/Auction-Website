<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<%
    int categoryId = Integer.parseInt(request.getParameter("category"));
    int subcategoryId = Integer.parseInt(request.getParameter("subcategory"));
    String name = request.getParameter("name");
    String description = request.getParameter("description");
    double price = Double.parseDouble(request.getParameter("price"));
    String imageUrl = request.getParameter("image_url");
    int sellerId = (int) session.getAttribute("userId"); // Assuming the user ID is stored in the session

    try {
        ApplicationDB db = new ApplicationDB();
        Connection con = db.getConnection();
        PreparedStatement ps = con.prepareStatement("INSERT INTO item (name, description, price, image_url, seller_id, subcategory_id) VALUES (?, ?, ?, ?, ?, ?)");
        ps.setString(1, name);
        ps.setString(2, description);
        ps.setDouble(3, price);
        ps.setString(4, imageUrl);
        ps.setInt(5, sellerId);
        ps.setInt(6, subcategoryId); // Only include subcategory_id
        ps.executeUpdate();

        out.print("Listing created successfully!");
        // Redirect to home page or another relevant page
    } catch (Exception e) {
        out.print("An error occurred: " + e.getMessage());
        // Redirect to error page or provide a link back to listing.jsp
    }
%>
