<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*,com.cs336.pkg.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Search Items</title>
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
        	#item-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            gap: 16px;
            padding: 16px;
       		 }
        
     	   .item-card {
            border: 1px solid #ccc;
            padding: 16px;
            text-align: center;
        	}
        
        	.item-card img {
            max-width: 100%;
            height: auto;
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
    <form method="GET" action="search.jsp">
        Search by Name: <input type="text" name="query" value="<%= request.getParameter("query") == null ? "" : request.getParameter("query") %>">
        <input type="submit" value="Search">
    </form>
    <div id="item-grid">
        <%
            String query = request.getParameter("query");
            if (query != null && !query.trim().isEmpty()) {
                ApplicationDB db = new ApplicationDB();
                Connection con = db.getConnection();
                PreparedStatement pstmt = con.prepareStatement("SELECT * FROM item WHERE name LIKE ?");
                pstmt.setString(1, "%" + query + "%");
                ResultSet rs = pstmt.executeQuery();

                while (rs.next()) {
                    String itemName = rs.getString("name");
                    String imageUrl = rs.getString("image_url");
                    double itemPrice = rs.getDouble("price");
        %>
            <div class="item-card">
                <img src="<%= imageUrl %>" alt="<%= itemName %>">
                <h2><%= itemName %></h2>
                <p>Price: $<%= itemPrice %></p>
                <a href="itemDescription.jsp?itemId=<%= rs.getInt("id") %>">View Item</a>
            </div>
        <%
                }
                db.closeConnection(con);
            }
        %>
    </div>
</body>
</html>
