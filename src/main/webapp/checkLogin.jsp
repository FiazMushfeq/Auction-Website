<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
   <head>
   		<meta charset="UTF-8">
    	<title>Checking Login Info</title>
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
				String username = request.getParameter("username");
				String password = request.getParameter("password");
				//Make a SELECT query for username
				String str = "SELECT * FROM users WHERE `username` = '" + username + "' AND `password` = '" + password + "'";
				//Run the query against the database.
				ResultSet result = stmt.executeQuery(str);
				if(result.next()) {
					session.setAttribute("username", username);
					%>
						Welcome <%=request.getParameter("username")%>
						<a href='homepage.jsp'>Home Page</a>
						<a href='logout.jsp'>Log out</a>
					<%
				} else {
					out.print("Invalid/Incorrect username or password!");
					%>
						<a href="login.jsp">Retry Logging In!</a>
					<%
				}
				db.closeConnection(con);
			} catch (Exception e) { // incorrect login
				out.print(e);
				%>
					<a href="login.jsp">Retry Logging In!</a>
				<%
			}
		%>
   </body>
</html>