import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    UserDAO userDao = new UserDAO();
    User user = userDao.getUser(email, password);

    if (user != null) {
        if (user.getEmail() != null) {
            HttpSession session = request.getSession();
            session.setAttribute("username", user.getFirstName() + " " + user.getLastName());
            request.getRequestDispatcher("home.jsp").forward(request, response);
        } else {
            // wrong password
            request.setAttribute("errorMessage", "Wrong password");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    } else {
        // email not found
        request.setAttribute("errorMessage", "Email not found");
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
}

}
