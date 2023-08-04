<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
</head>
<body>
    <form action="LoginServlet" method="post">
        Email: <input type="text" name="email" /><br/>
        Password: <input type="password" name="password" /><br/>
        <input type="submit" value="Login" />
    </form>
    <button onclick="window.location.href='register.jsp'">Sign Up</button>
</body>
</html>
