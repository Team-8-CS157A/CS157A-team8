package item;

import dbInfo.dbSetting;
import user.usersActions;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.*;             // Tomcat 10
import jakarta.servlet.http.*;        // Tomcat 10

public class addItem extends HttpServlet {

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String servingSize = request.getParameter("servingSize");
        String calories = request.getParameter("calories");
        String sugar = request.getParameter("sugar");
        String color = request.getParameter("color");
        String price = request.getParameter("price");
        String stockNum = request.getParameter("stockNum");

        String redirectPage = "";

        try {
            // Create database connection
            java.sql.Connection con;
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/inventory_manager?autoReconnect=true&useSSL=false", dbSetting.user, dbSetting.password);
            System.out.println(dbSetting.db + " database successfully opened.<br/><br/>");

            // Check for valid inputs, if not send back to register
            boolean validInputs = usersActions.checkInputs(new String[]{ name, servingSize, calories, sugar, color, price, stockNum });
            if (!validInputs) {
                redirectPage = "addItem.jsp";
                System.out.println("Invalid Inputs for addItem");
                return;
            }

            redirectPage = "home.jsp";  // TODO: Change the redirect page?
            String insertString = "INSERT INTO Item (name, servingSize, cal, sugar, color, price, stockNum) VALUES (?, ?, ?, ?, ?, ?, ?)";

            PreparedStatement pstatement = con.prepareStatement(insertString);
            pstatement.setString(1, name);
            pstatement.setString(2, servingSize);
            pstatement.setString(3, calories);
            pstatement.setString(4, sugar);
            pstatement.setString(5, color);
            pstatement.setString(6, price);
            pstatement.setString(7, stockNum);

            int queryResult = pstatement.executeUpdate();

            if (queryResult == 0) {
                throw new SQLException("Add Item Query Failed");
            }

            // Print to logs the newly created User/AdminUser/EmpUser
            System.out.println("-- Adding item to Item --" +
                    "\nName: " + name +
                    "\nServing Size: " + servingSize +
                    "\nCalories: " + calories +
                    "\nSugar: " + sugar +
                    "\nColor: " + color +
                    "\nPrice: " + price +
                    "\nStock Number: " + stockNum +
                    "\n -------------------");

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
