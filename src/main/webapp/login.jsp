<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
   <head>
   		<meta charset="UTF-8">
    	<title>Login Form</title>
    	<style>
    		body {
    			font-family: Arial, sans-serif;
    			background-color: #f4f4f4;
    			text-align: center;
    		}
    		.container {
    			width: 300px;
    			margin: 100px auto;
    			background: #fff;
    			padding: 20px;
    			border-radius: 5px;
    			box-shadow: 0 0 10px #ccc;
    		}
    		h1 {
    			color: #333;
    			margin-bottom: 20px;
    		}
    		input[type="text"],
    		input[type="password"] {
    			width: 100%;
    			padding: 10px;
    			margin-bottom: 10px;
    			border: 1px solid #ccc;
    			border-radius: 4px;
    		}
    		input[type="submit"] {
    			background-color: #4CAF50;
    			color: white;
    			padding: 15px 20px;
    			border: none;
    			border-radius: 4px;
    			cursor: pointer;
    		}
    		.register-button {
    			background-color: #f44336;
    			color: white;
    			padding: 10px 15px;
    			margin-top: 10px;
    			border: none;
    			border-radius: 4px;
    			cursor: pointer;
    		}
    	</style>
  	</head>
   <body>
   		<div class="container">
   			<h1>BuyMe</h1>
			<form method="POST" action="checkLogin.jsp">
				Username: <input type="text" placeholder="Enter Username" name="username" required><br>
				Password: <input type="password" placeholder="Enter Password" name="password" required><br>
				<input type="submit" value="Login!"/>
		   	</form>
		   	<form action="register.jsp" method="get">
		   		<input type="submit" class="register-button" value="Register"/>
		   	</form>
		</div>
   </body>
</html>
