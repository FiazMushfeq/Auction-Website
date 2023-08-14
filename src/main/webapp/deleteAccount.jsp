<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Confirming Deletion of Account</title>
	</head>
	<body>
		<% 
			try {
				//Get the database connection
				ApplicationDB db = new ApplicationDB();	
				Connection con = db.getConnection();		
				//Create a SQL statement
				Statement stmt = con.createStatement();
				//Get username and password
				String email = request.getParameter("email");
				String firstName = request.getParameter("firstName");
				String lastName = request.getParameter("lastName");
				String username = request.getParameter("username");
				String password = request.getParameter("password");
				//Make a insert for users
				String str = "DELETE FROM users WHERE `username` = '" + username + "' AND "
					+ "`email` = '" + email + "' AND "
					+ "`password` = '" + password + "' AND "
					+ "`firstName` = '" + firstName + "' AND "
					+ "`lastName` = '" + lastName + "'";
				//Run the query against the database.
				out.print(str);
				int result = stmt.executeUpdate(str);
				out.print(result);
				if(result == 1) {
					out.print("Success in deleting your account!");
					%>
						<a href="register.jsp">Want to register?</a>
					<%
				} else {
					out.print("Account not found or details do not match!");
					%>
					<a href="delete.jsp">Try deleting again!</a>
				<%
				}
				db.closeConnection(con);
			} catch (SQLException e) { //
				out.print(e);
				out.println("Error Occurred!");
				%>
					<a href="delete.jsp">Retry deletion!</a>
				<%
			}
		%>
	</body>
</html>