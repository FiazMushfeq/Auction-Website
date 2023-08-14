<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Create Account</title>
	</head>
	<body>
		<form method="POST" action="checkRegister.jsp">
			Email: <input type="text" placeholder="Enter Username" name="email" required>
			First Name: <input type="text" placeholder="Enter First Name" name="firstName" required>
			Last Name: <input type="text" placeholder="Enter Last Name" name="lastName" required>
			Username: <input type="text" placeholder="Enter Username" name="username" required>
			Password: <input type="password" placeholder="Enter Password" name="password" required>
			<input type="submit" value="Register"/>
	   </form>
	</body>
</html>