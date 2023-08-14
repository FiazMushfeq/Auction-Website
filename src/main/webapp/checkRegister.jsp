<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Checking Register Info</title>
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
				String str = "INSERT INTO users(`email`, `firstName`, `lastName`, `username`, `password`) VALUES ('"
					+ email + "', '" + firstName + "', '"
					+ lastName + "', '" + username + "', '" + password + "')";
				//Run the query against the database.
				// out.print(str);
				int result = stmt.executeUpdate(str);
				if(result == 1) {
					out.print("Success in creating your account!");
					%>
						<a href="login.jsp">Try logging in!</a>
					<%
				} else {
					out.print("Username is already taken!");
					%>
						<a href="register.jsp">Try registering again!</a>
					<%
				}
				db.closeConnection(con);
			} catch (SQLException e) { //
				out.print(e);
				out.println("Error Occurred!");
				%>
					<a href="register.jsp">Retry Registering!</a>
				<%
			}
		%>
	</body>
</html>