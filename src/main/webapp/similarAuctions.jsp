<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*,com.cs336.pkg.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Similar Items</title>
</head>
<body>
    <h1>Similar Items</h1>
    <%
        int itemId = Integer.parseInt(request.getParameter("itemId"));
        ApplicationDB db = new ApplicationDB();
        Connection con = db.getConnection();
        PreparedStatement pstmt = con.prepareStatement("SELECT subcategory_id FROM item WHERE id = ?");
        pstmt.setInt(1, itemId);
        ResultSet rs = pstmt.executeQuery();
        int subcategoryId = 0;

        if (rs.next()) {
            subcategoryId = rs.getInt("subcategory_id");
        }

        pstmt = con.prepareStatement("SELECT * FROM item WHERE subcategory_id = ? AND id <> ?");
        pstmt.setInt(1, subcategoryId);
        pstmt.setInt(2, itemId);
        rs = pstmt.executeQuery();

        while (rs.next()) {
            int similarItemId = rs.getInt("id");
            String itemName = rs.getString("name");
            double itemPrice = rs.getDouble("price");
    %>
        <p>
            <strong><%= itemName %></strong>: $<%= itemPrice %>
            <a href="itemDescription.jsp?itemId=<%= similarItemId %>">View Details</a>
        </p>
    <%
        }
        db.closeConnection(con);
    %>
    <a href="homepage.jsp">Back to Home</a>
</body>
</html>
