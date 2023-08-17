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
   <script>
    function updateSubcategories() {
        var categoryId = document.getElementById("category").value;
        var subcategory = document.getElementById("subcategory");
        subcategory.innerHTML = ""; // Clear existing options
        var bodyTypeSelect = document.getElementById("body_type");
        bodyTypeSelect.innerHTML = ""; // Clear existing options

        // Make AJAX request to get subcategories
        var xhr = new XMLHttpRequest();
        xhr.open("GET", "getSubcategories.jsp?categoryId=" + categoryId, true);
        xhr.onreadystatechange = function() {
            if (xhr.readyState === 4 && xhr.status === 200) {
                var options = JSON.parse(xhr.responseText);
                for (var i = 0; i < options.length; i++) {
                    var option = document.createElement("option");
                    option.value = options[i].id;
                    option.text = options[i].name;
                    subcategory.appendChild(option);
                }
            }
        };
        xhr.send();

        // Make AJAX request to get body types
        var xhrBodyTypes = new XMLHttpRequest();
        xhrBodyTypes.open("GET", "getBodyTypes.jsp?categoryId=" + categoryId, true);
        xhrBodyTypes.onreadystatechange = function() {
            if (xhrBodyTypes.readyState === 4 && xhrBodyTypes.status === 200) {
                var bodyTypes = JSON.parse(xhrBodyTypes.responseText);
                for (var i = 0; i < bodyTypes.length; i++) {
                    var option = document.createElement("option");
                    option.value = bodyTypes[i].id;
                    option.text = bodyTypes[i].name;
                    bodyTypeSelect.appendChild(option);
                }
            }
        };
        xhrBodyTypes.send();
    }
</script>
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
    <form method="POST" action="checkListing.jsp">
        Please select a category:
        <select name="category" id="category" required onchange="updateSubcategories()">
            <option value="">Select One</option>
            <%
                ApplicationDB db = new ApplicationDB();
                Connection con = db.getConnection();
                Statement stmt = con.createStatement();
                ResultSet categories = stmt.executeQuery("SELECT * FROM categories");
                while (categories.next()) {
            %>
                <option value="<%= categories.getInt("id") %>"><%= categories.getString("name") %></option>
            <% } 
               db.closeConnection(con);
            %>
        </select>
        Please select a subcategory:
        <select name="subcategory" id="subcategory" required>
            <!-- Subcategories will be populated dynamically -->
        </select>
        Please select a color:
        <select name="color" id="color" required>
            <option value="">Select One</option>
            <%
                ApplicationDB dbColor = new ApplicationDB();
                Connection conColor = dbColor.getConnection();
                Statement stmtColor = conColor.createStatement();
                ResultSet colors = stmtColor.executeQuery("SELECT * FROM colors");
                while (colors.next()) {
            %>
                <option value="<%= colors.getInt("id") %>"><%= colors.getString("name") %></option>
            <% }
               dbColor.closeConnection(conColor);
            %>
        </select>
        Please select a body type:
   			 <select name="body_type" id="body_type" required>
     		   <!-- Body types will be populated dynamically -->
  		  </select>
   		Year: <input type="number" name="year" min="1900" max="2099" step="1" required><br>
        Name: <input type="text" name="name" required><br>
        Description: <textarea name="description" required></textarea><br>
        Price: <input type="number" name="price" step="0.01" required><br>
        Image URL: <input type="text" name="image_url"><br>
        Bid Increment: <input type="number" name="bid_increment" step="0.01" required><br>
        Closing Time: <input type="datetime-local" name="closing_time" required><br>
        <input type="submit" value="Create Listing"/>
        <!-- Rest of the form fields -->
    </form>
</body>

</html>
