import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class RegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        // you should validate and compare password and confirmPassword here

        User user = new User(firstName, lastName, email, password);

        UserDAO userDao = new UserDAO();
        userDao.saveUser(user);

        response.sendRedirect("login.jsp");
    }
}
