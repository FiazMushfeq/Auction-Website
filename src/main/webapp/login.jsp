<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
   <head>
   		<meta charset="UTF-8">
    	<title>Login Form</title>
  	</head>
   <body>
		<form method="POST" action="checkLogin.jsp">
			Username: <input type="text" placeholder="Enter Username" name="username" required>
			Password: <input type="password" placeholder="Enter Password" name="password" required>
			<input type="submit" value="Login!"/>
	   </form>
   </body>
</html>