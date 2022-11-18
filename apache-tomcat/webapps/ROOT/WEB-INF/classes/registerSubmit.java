import java.io.IOException;
import java.sql.DriverManager;
import java.sql.SQLException;

import java.io.*;
//import jakarta.servlet.*;             // Tomcat 10
//import jakarta.servlet.http.*;        // Tomcat 10
//import jakarta.servlet.annotation.*;  // Tomcat 10
import javax.servlet.*;             // Tomcat 9
import javax.servlet.http.*;        // Tomcat 9
import javax.servlet.annotation.*;  // Tomcat 9

//import javax.servlet.RequestDispatcher;
//import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.HttpServlet;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
import javax.swing.*;

@WebServlet("/registerSubmit")
public class registerSubmit extends HttpServlet {
    public static void submitForm(String name, String username, String password) {
        if (name.isEmpty() || name == null) {
            System.out.println("name parameter is empty");
        }

        if (username.isEmpty() || username == null) {
            System.out.println("username parameter is empty");
        }

        if (password.isEmpty() || password == null) {
            System.out.println("password parameter is empty");
        }
    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        // Set the response MIME type of the response message
        response.setContentType("text/html");
        // Allocate a output writer to write the response message into the network socket
        PrintWriter out = response.getWriter();

        // Write the response message, in an HTML page
        out.println("<!DOCTYPE html>");
        out.println("<html>");
        out.println("<head><title>Hello, World</title></head>");
        out.println("<body>");
        out.println("<h1>Hello, world!</h1>");  // says Hello
        // Echo client's request information
        out.println("<p>Request URI: " + request.getRequestURI() + "</p>");
        out.println("<p>Protocol: " + request.getProtocol() + "</p>");
        out.println("<p>PathInfo: " + request.getPathInfo() + "</p>");
        out.println("<p>Remote Address: " + request.getRemoteAddr() + "</p>");
        // Generate a random number upon each request
        out.println("<p>A Random Number: <strong>" + Math.random() + "</strong></p>");
        out.println("</body></html>");
        out.close();  // Always close the output writer
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("DOPOST RAN");
        String input_name = request.getParameter("name");
        String input_username = request.getParameter("username");
        String input_password = request.getParameter("password");

        String db = "inventory_manager";
        String user = "root"; // assumes database name is the same as username
        String password = "root";

        try {
            java.sql.Connection con;
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/inventory_manager?autoReconnect=true&useSSL=false", user, password);
            System.out.println(db + " database successfully opened.<br/><br/>");

            System.out.println("Adding user to \"Employees\": <br/>");
            // Statement stmt = con.createStatement();
            String[] inputs = new String[] { input_name, input_username, input_password };

            for (String input : inputs) {
                if (input == null || input.length() == 0) {
                    throw new IllegalArgumentException("Inputs must be filled out");
                } else {

                }
            }

//              if (!input_name.isEmpty() && !input_username.isEmpty() && !input_password.isEmpty()) {
//                  String queryString = "INSERT INTO Employees (name, username, password) VALUES (?, ?, ?)";
//                  System.out.println(queryString);
//                  System.out.println("----");
//                  PreparedStatement pstatement = con.prepareStatement(queryString);
//
//                  pstatement.setString(1, input_name);
//                  pstatement.setString(2, input_username);
//                  pstatement.setString(3, input_password);
//
//                  int updateQuery = 0;
//                  updateQuery = pstatement.executeUpdate();
//              } else {
//                  System.out.println("Invalid Input");
//              }


            // ResultSet rs = stmt.executeQuery("INSERT INTO Employees (name, username, password) VALUES (?, ?, ?)");
            // while (rs.next()) {
            //     System.out.println(rs.getInt(1) + " " + rs.getString(2) + " " + rs.getString(3) + "<br/><br/>");
            //     out.println(rs.getInt(1) + " " + rs.getString(2) + " " + rs.getString(3) + "<br/><br/>");
            // }
            // rs.close();
            // stmt.close();
            con.close();
        } catch(SQLException e) {
            JOptionPane.showMessageDialog(null, e);
            System.out.println("SQLException caught: " + e.getMessage());

        } catch (ClassNotFoundException e) {
            System.out.println("ClassNotFoundException caught: " + e.getMessage());
        }

//        if(first_name.isEmpty() || last_name.isEmpty() || username.isEmpty() ||
//            password.isEmpty() || address.isEmpty() || contact.isEmpty())
//        {
//            RequestDispatcher req = request.getRequestDispatcher("register_1.jsp");
//            req.include(request, response);
//        }
//        else
//        {
//            RequestDispatcher req = request.getRequestDispatcher("register_2.jsp");
//            req.forward(request, response);
//        }
    }
}