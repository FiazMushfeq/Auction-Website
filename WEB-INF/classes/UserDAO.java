import java.sql.*;

public class UserDAO {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/auction-website?useSSL=false&serverTimezone=UTC";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "Enter your password";

public User getUser(String email, String password) {
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

        PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM user WHERE email = ?");
        pstmt.setString(1, email);
        ResultSet rs = pstmt.executeQuery();

        if (rs.next()) {
            if (rs.getString("password").equals(password)) {
                return new User(rs.getString("firstName"), rs.getString("lastName"), rs.getString("email"), rs.getString("password"));
            } else {
                return new User(null, null, null, null);  // wrong password
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }

    return null;  // email not found
}


    public void saveUser(User user) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            PreparedStatement pstmt = conn.prepareStatement("INSERT INTO user (firstName, lastName, email, password) VALUES (?, ?, ?, ?)");
            pstmt.setString(1, user.getFirstName());
            pstmt.setString(2, user.getLastName());
            pstmt.setString(3, user.getEmail());
            pstmt.setString(4, user.getPassword());
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
