<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<%
    int itemId = Integer.parseInt(request.getParameter("itemId"));
    double bidAmount = Double.parseDouble(request.getParameter("bidAmount"));
    boolean enableAutobid = request.getParameter("autobid") != null;
    double maxBid = request.getParameter("maxBid") != null ? Double.parseDouble(request.getParameter("maxBid")) : 0;

    ApplicationDB db = new ApplicationDB();
    Connection con = db.getConnection();

    // Get current item details
    String query = "SELECT * FROM item WHERE id = ?";
    PreparedStatement pstmt = con.prepareStatement(query);
    pstmt.setInt(1, itemId);
    ResultSet rs = pstmt.executeQuery();

    if (rs.next()) {
        double currentPrice = rs.getDouble("price");
        double bidIncrement = rs.getDouble("bid_increment");
        double secretMinimumPrice = rs.getDouble("secret_minimum_price");

        // Validate the bid
        if (bidAmount < currentPrice + bidIncrement || (enableAutobid && maxBid < currentPrice + bidIncrement)) {
            out.print("Bid must be at least " + (currentPrice + bidIncrement));
        } else {
            // Process the bid
            if (enableAutobid) {
    // Handle automatic bidding logic
    PreparedStatement autobidPstmt = con.prepareStatement("SELECT * FROM bids WHERE item_id = ? AND autobid = 1 ORDER BY bid_amount DESC");
    autobidPstmt.setInt(1, itemId);
    ResultSet autobidRs = autobidPstmt.executeQuery();

    while (autobidRs.next()) {
        double otherMaxBid = autobidRs.getDouble("max_bid");
        if (otherMaxBid > bidAmount) {
            // Another user has an automatic bid higher than this bid
            // Automatically place a bid for the other user
            bidAmount += bidIncrement;
            if (bidAmount > maxBid) {
                // This user's maximum bid has been reached
                // Notify this user that they've been outbid
                // TODO: Notification logic
                break;
            }
        } else {
            break; // No more competing autobids
        }
    }

    // TODO: Store this user's automatic bid information in the database
}

            // Update the item's current price if this bid is higher
            if (bidAmount > currentPrice) {
                pstmt = con.prepareStatement("UPDATE item SET price = ? WHERE id = ?");
                pstmt.setDouble(1, bidAmount);
                pstmt.setInt(2, itemId);
                pstmt.executeUpdate();
            }

            // TODO: Store the bid information in the database
            out.print("Bid placed successfully!");
            
            //response.sendRedirect("itemDescription.jsp?itemId=" + itemId);


            // TODO: Notify users if they've been outbid
        }
    } else {
        out.print("Item not found!");
    }

    db.closeConnection(con);
%>
<script>
    alert('Bid placed successfully!');
    window.location.href = 'itemDescription.jsp?itemId=<%= itemId %>';
</script>

<!-- Navigation Links -->
<a href="homepage.jsp">Home</a>
<a href="itemDescription.jsp?itemId=<%= itemId %>">Back to Item</a>
