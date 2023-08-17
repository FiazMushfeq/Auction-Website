<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*,com.cs336.pkg.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Bid History</title>
</head>
<body>
    <h1>Bid History</h1>
    <%
    int itemId = Integer.parseInt(request.getParameter("itemId"));

    ApplicationDB db = new ApplicationDB();
    Connection con = db.getConnection();
    PreparedStatement pstmt = con.prepareStatement("SELECT * FROM bids WHERE item_id = ? ORDER BY timestamp DESC"); // Updated the order by clause
    pstmt.setInt(1, itemId);
    ResultSet rs = pstmt.executeQuery();

    while (rs.next()) {
        double bidAmount = rs.getDouble("bid_amount"); // Make sure this matches your actual column name
        String bidderUsername = rs.getString("username"); // Assuming you have a column for the username
        Timestamp bidTime = rs.getTimestamp("timestamp"); // Assuming you have a timestamp column

        // Displaying the bid details inside the loop
        %>
            <p><strong><%= bidderUsername %></strong>: $<%= bidAmount %> at <%= bidTime %></p>
        <%
    }
    db.closeConnection(con);
    %>
    <a href="homepage.jsp">Back to Home</a>
</body>
</html>
