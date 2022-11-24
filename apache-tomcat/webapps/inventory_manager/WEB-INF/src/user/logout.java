package user;

import java.io.IOException;
import jakarta.servlet.*;             // Tomcat 10
import jakarta.servlet.http.*;        // Tomcat 10

public class logout extends HttpServlet {

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }

        // Redirect to another page, takes in redirectPage as a variable redirect
        RequestDispatcher dd = request.getRequestDispatcher("/login.jsp");
        dd.forward(request, response);
    }

}
