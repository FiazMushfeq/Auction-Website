<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*,com.cs336.pkg.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Your Auctions as Buyer</title>
</head>
<body>
    <h1>Your Auctions as Buyer</h1>
  <%
    String currentUsername = (String) session.getAttribute("username");
    ApplicationDB db = new ApplicationDB();
    Connection con = db.getConnection();
    PreparedStatement pstmt = con.prepareStatement("SELECT DISTINCT i.* FROM item i JOIN bids b ON i.id = b.item_id JOIN users u ON u.id = b.user_id WHERE u.username = ?");
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
        </p>
<%
    }
    db.closeConnection(con);
%>


</body>
</html>
