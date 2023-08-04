<!DOCTYPE html>
<html>
<head>
    <title>Register</title>
    <script type="text/javascript">
        function validatePassword() {
            var password = document.getElementById("password");
            var confirm_password = document.getElementById("confirm_password");

            if (password.value != confirm_password.value) {
                confirm_password.setCustomValidity("Passwords don't match");
            } else {
                confirm_password.setCustomValidity('');
            }
        }
    </script>
</head>
<body>
    <form action="RegisterServlet" method="post">
        First Name: <input type="text" name="firstName" required /><br/>
        Last Name: <input type="text" name="lastName" required /><br/>
        Email: <input type="email" name="email" required /><br/>
        Password: <input type="password" name="password" id="password" required /><br/>
        Confirm Password: <input type="password" name="confirmPassword" id="confirm_password" required oninput="validatePassword()" /><br/>
        <input type="submit" value="Register" />
    </form>
</body>
</html>
