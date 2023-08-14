<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Home Page</title>
	</head>
	<body>
		<% 
			try {
				//Get the database connection
				ApplicationDB db = new ApplicationDB();	
				Connection con = db.getConnection();
				if(session.getAttribute("username") == null) {
					out.print("Account not found!");
					%>
						<a href="register.jsp">Register?</a>
					<%
				} else {
					out.print("Welcome to your BuyMe homepage, " + session.getAttribute("username").toString() + "!");
					%>
						<a href="listing.jsp">Create a listing</a>
					<%
				}
			} catch (Exception e) {
				out.print(e);
				%>
					<a href="login.jsp">Login!</a>
				<%
			}
		%>
	</body>
</html>