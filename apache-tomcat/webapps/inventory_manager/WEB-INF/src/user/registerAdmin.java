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

    public static boolean checkInputs(String firstName, String lastName, String phoneNumber, String storeID) {
        boolean validInputs = true;

        if (firstName.isEmpty() || firstName == null) {
            validInputs = false;
            System.out.println("firstName parameter is empty");
        }

        if (lastName.isEmpty() || lastName == null) {
            validInputs = false;
            System.out.println("firstName parameter is empty");
        }

        if (phoneNumber.isEmpty() || phoneNumber == null) {
            validInputs = false;
            System.out.println("firstName parameter is empty");
        }

        if (storeID.isEmpty() || storeID == null) {
            validInputs = false;
            System.out.println("firstName parameter is empty");
        }

        return validInputs;
    }

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
            boolean validInputs = checkInputs(input_firstName, input_lastName, input_phoneNumber, input_storeID);
            if (!validInputs) {
                System.out.println("Invalid Inputs for registerAdmin");
                redirectPage = "register.jsp";
            }

            // Insert new Admin User into the "AdminUsers" table
            usersActions.insertIntoTable(con, "Admin", input_firstName, input_lastName, input_phoneNumber, input_storeID, "");

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
