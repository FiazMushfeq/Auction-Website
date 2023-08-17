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
        <script>
        function toggleBidForm() {
            var bidForm = document.getElementById("bidForm");
            bidForm.style.display = (bidForm.style.display === "none" || bidForm.style.display === "") ? "block" : "none";
        }
    </script>
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
            double bidIncrement = rs.getDouble("bid_increment");
            Timestamp closingTime = rs.getTimestamp("closing_time"); // Assuming the closing_time field is a TIMESTAMP
    %>
            <h1><%= itemName %></h1>
            <img src="<%= itemImage %>" alt="<%= itemName %>" width="350" height="300">
            <p><%= itemDescription %></p>
            <p>Price: $<%= itemPrice %></p>
            <p>Minimum Bid Increment: $<%= bidIncrement %></p>
            <p>Auction Closing Time: <%= closingTime %></p>
			<p>Time Remaining: <span id="timeRemaining"></span></p>
			<script>
    			function updateRemainingTime() {
    			    var closingTime = new Date("<%= closingTime %>"); // Convert to JavaScript Date object
   				    var now = new Date();
        			var timeRemaining = closingTime - now;

        			var hours = Math.floor(timeRemaining / (1000 * 60 * 60));
        			var minutes = Math.floor((timeRemaining % (1000 * 60 * 60)) / (1000 * 60));
        			var seconds = Math.floor((timeRemaining % (1000 * 60)) / 1000);

        			document.getElementById("timeRemaining").innerHTML = hours + "h " + minutes + "m " + seconds + "s ";
    			}

    			setInterval(updateRemainingTime, 1000); // Update every second
			</script>
            <button onclick="toggleBidForm()">Bid</button>
    <form id="bidForm" method="POST" action="placeBid.jsp" onsubmit="return validateForm()" style="display: none;">
    <input type="hidden" name="itemId" value="<%= itemId %>">
    <label for="bidAmount">Your Bid:</label>
    <input type="number" name="bidAmount" id="bidAmount" min="<%= bidIncrement %>" step="<%= bidIncrement %>" required>
    <br>
    <input type="checkbox" name="autobid" id="autobid" onclick="toggleMaxBid()">
    <label for="autobid">Enable Autobid</label>
    <br>
    <label for="maxBid">Maximum Bid:</label>
    <input type="number" name="maxBid" id="maxBid" disabled>
    <button type="submit">Place Bid</button>
</form>
<script>
    function toggleMaxBid() {
        var autobid = document.getElementById("autobid").checked;
        var maxBid = document.getElementById("maxBid");
        maxBid.disabled = !autobid;
        if (autobid) {
            maxBid.setAttribute("required", "required");
            maxBid.setAttribute("min", "<%= bidIncrement %>");
        } else {
            maxBid.removeAttribute("required");
            maxBid.removeAttribute("min");
        }
    }

    function validateForm() {
        var autobid = document.getElementById("autobid").checked;
        var maxBid = document.getElementById("maxBid").value;
        if (autobid && maxBid === '') {
            alert("Please enter the Maximum Bid.");
            return false;
        }
        return true;
    }
</script>

	<button>
   <a href="bidHistory.jsp?itemId=<%= itemId %>">View Bid History</a>
	</button>
         
    <%
        } else {
            out.print("Item not found!");
        }
        
        db.closeConnection(con);
    %>
    
    <!-- Navigation Links -->
    <a href="homepage.jsp">Home</a>
    <a href="userProfile.jsp">Profile</a>
    <a href="logout.jsp">Logout</a>
</body>
</html>
