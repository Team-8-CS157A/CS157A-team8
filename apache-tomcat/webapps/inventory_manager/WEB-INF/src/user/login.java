package user;

import dbInfo.dbSetting;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.*;             // Tomcat 10
import jakarta.servlet.http.*;        // Tomcat 10

public class login extends HttpServlet {

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String input_firstName = request.getParameter("FirstName");
        String input_lastName = request.getParameter("LastName");
        String input_phoneNumber = request.getParameter("phoneNumber");
//        String input_storeID = request.getParameter("storeID");

        String redirectPage = "";

        try {
            // Create database connection
            java.sql.Connection con;
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/inventory_manager?autoReconnect=true&useSSL=false", dbSetting.user, dbSetting.password);
            System.out.println(dbSetting.db + " database successfully opened.<br/><br/>");

            // Check for valid inputs, if not send back to register
            boolean validInputs = usersActions.checkInputs(new String[]{ input_firstName, input_lastName, input_phoneNumber });
            if (!validInputs) {
                redirectPage = "login.jsp";
                System.out.println("Invalid Inputs for login");
            } else {
                redirectPage = "home.jsp";
            }

            // TODO: Change the table name to Users once the relationship set is created
            String loginQuery = "SELECT COUNT(*) FROM AdminUsers WHERE FirstName = ? AND LastName = ? AND phoneNumber = ?;";
            PreparedStatement pstatement = con.prepareStatement(loginQuery);
            pstatement.setString(1, input_firstName);
            pstatement.setString(2, input_lastName);
            pstatement.setString(3, input_phoneNumber);

            ResultSet rs = pstatement.executeQuery();
            rs.next();
            int doesUserExist = rs.getInt(1);

            if (doesUserExist != 1) {
                System.out.println("User with these credentials does not exist!");
            }

            // Login user
            HttpSession session = request.getSession(true);
            session.setAttribute("FirstName", input_firstName);
            session.setAttribute("LastName", input_lastName);
            session.setAttribute("phoneNumber", input_phoneNumber);

            // Close SQL Connection
            con.close();
        } catch(SQLException e) {
            System.out.println("SQLException caught: " + e.getMessage());
        } catch (ClassNotFoundException e) {
            System.out.println("ClassNotFoundException caught: " + e.getMessage());
        }

        // Redirect to another page, takes in redirectPage as a variable redirect
        RequestDispatcher dd = request.getRequestDispatcher(redirectPage);
        dd.forward(request, response);
    }
}
