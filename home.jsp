<!DOCTYPE html>
<html>
<head>
    <title>Home</title>
</head>
<body>
    <h1>Welcome to the Auction Website</h1>
    <p>Welcome, <%= session.getAttribute("username") %></p>
    <button onclick="window.location.href='logout.jsp'">Logout</button>
</body>
</html>
