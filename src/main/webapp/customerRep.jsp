<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="com.dbapp.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Customer Representative Home</title>
<style>
table {
   border-collapse: collapse;
   width: 100%;
}

th, td {
   border: 1px solid;
   padding: 8px;
   text-align: left;
}

.button {
   border: none;
   background-color: transparent;
   cursor: pointer;
}
</style>
</head>
<body>
<%
    ApplicationDB db = new ApplicationDB();
    Connection con = db.getConnection();
    
    String repId = (String) session.getAttribute("employeeid");
    
    if (repId == null) {
        response.sendRedirect("Login.jsp");
    }
%>

<h1>Welcome back!</h1>

<%
    displaySection("Questions", "question_id", "q_text", "question", "SELECT q_id, q_text FROM question");
    displaySection("Bids and Auctions", "l_id", "itemname, subcategory, price", "listings", "SELECT l_id, itemname, subcategory, price FROM listings");
    displaySection("User Account Access", "username", "username", "users", "SELECT username FROM users");
%>

<a href="Logout.jsp">Logout</a>

<%
    con.close();
    void displaySection(String title, String idCol, String columns, String tableName, String query) throws SQLException {
        ResultSet resultSet = con.createStatement().executeQuery(query);
%>

<hr>
<h2><%= title %></h2>
<% if (!resultSet.next()) { %>
    <p>No data available.</p>
<% } else { %>
    <form action="<%= tableName.equals("question") ? "ExamineQuestion.jsp" : "RepEditListing.jsp" %>" method="post">
        <table>
            <tr>
                <th></th>
                <th><%= title.equals("Bids and Auctions") ? "Item" : "Username" %></th>
                <% if (title.equals("Bids and Auctions")) { %>
                    <th>Subcategory</th>
                    <th>Price</th>
                <% } %>
            </tr>
            <%
                resultSet.beforeFirst();
                while (resultSet.next()) {
                    String idValue = resultSet.getString(idCol);
                    String[] columnValues = columns.split(", ");
            %>
            <tr>
                <td>
                    <button class="button" name="<%= idCol %>" type="submit" value="<%= idValue %>">>></button>
                </td>
                <%
                    for (String col : columnValues) {
                        String value = resultSet.getString(col);
                %>
                <td><%= value %></td>
                <% } %>
            </tr>
            <%
                }
            %>
        </table>
    </form>
<% } %>
<%
    }
%>
</body>
</html>