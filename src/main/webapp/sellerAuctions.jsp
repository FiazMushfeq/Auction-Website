<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*,com.cs336.pkg.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Your Auctions as Seller</title>
</head>
<body>
    <h1>Your Auctions as Seller</h1>
    <%
        String currentUsername = (String) session.getAttribute("username");
        ApplicationDB db = new ApplicationDB();
        Connection con = db.getConnection();
        PreparedStatement pstmt = con.prepareStatement("SELECT i.* FROM item i JOIN users u ON i.seller_id = u.id WHERE u.username = ?");
        pstmt.setString(1, currentUsername);
        ResultSet rs = pstmt.executeQuery();

        while (rs.next()) {
            int itemId = rs.getInt("id");
            String itemName = rs.getString("name");
            double itemPrice = rs.getDouble("price");
    %>
        <p>
            <strong><%= itemName %></strong>: $<%= itemPrice %>
            <a href="itemDescription.jsp?itemId=<%= itemId %>">View Details</a>
            <a href="bidHistory.jsp?itemId=<%= itemId %>">View Bid History</a>
            <a href="similarItems.jsp?itemId=<%= itemId %>">View Similar Items</a> <!-- You can define similarity based on your criteria -->
        </p>
    <%
        }
        db.closeConnection(con);
    %>
</body>
</html>
