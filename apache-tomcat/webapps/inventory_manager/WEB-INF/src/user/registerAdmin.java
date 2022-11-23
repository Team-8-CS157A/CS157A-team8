package user;

import dbInfo.dbSetting;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.*;             // Tomcat 10
import jakarta.servlet.http.*;        // Tomcat 10

public class registerAdmin extends HttpServlet {
    /*
    * SQL Table Schema:
    *
    * AdminID
    * FirstName
    * LastName
    * phoneNumber
    * storeID
    * */

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String input_firstName = request.getParameter("FirstName");
        String input_lastName = request.getParameter("LastName");
        String input_phoneNumber = request.getParameter("phoneNumber");
        String input_storeID = request.getParameter("storeID");

        String redirectPage = "";

        try {
            // Create database connection
            java.sql.Connection con;
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/inventory_manager?autoReconnect=true&useSSL=false", dbSetting.user, dbSetting.password);
            System.out.println(dbSetting.db + " database successfully opened.<br/><br/>");

            // Check for valid inputs, if not send back to register
            boolean validInputs = usersActions.checkInputs(new String[]{ input_firstName, input_lastName, input_phoneNumber, input_storeID });
            if (!validInputs) {
                redirectPage = "registerAdmin.jsp";
                System.out.println("Invalid Inputs for registerAdmin");
            } else {
                redirectPage = "login.jsp";

                // Insert new Admin User into the "AdminUsers" table
                usersActions.insertIntoTable(con, "Admin", input_firstName, input_lastName, input_phoneNumber, input_storeID, "");
            }

            // Close SQL Connection
            con.close();

            // Redirect to another page, takes in redirectPage as a variable redirect
            RequestDispatcher dd = request.getRequestDispatcher(redirectPage);
            dd.forward(request, response);
        } catch(SQLException e) {
            System.out.println("SQLException caught: " + e.getMessage());
        } catch (ClassNotFoundException e) {
            System.out.println("ClassNotFoundException caught: " + e.getMessage());
        }
    }

}
