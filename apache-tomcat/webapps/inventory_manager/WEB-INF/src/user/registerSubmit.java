package user;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.*;             // Tomcat 10
import jakarta.servlet.http.*;        // Tomcat 10

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

    // If the link is ran it will show the doGet as the front-end response
//    @Override
//    public void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws IOException, ServletException {
//
//        // Set the response MIME type of the response message
//        response.setContentType("text/html");
//        // Allocate a output writer to write the response message into the network socket
//        PrintWriter out = response.getWriter();
//
//        // Write the response message, in an HTML page
//        out.println("<!DOCTYPE html>");
//        out.println("<html>");
//        out.println("<head><title>Hello, World</title></head>");
//        out.println("<body>");
//        out.println("<h1>Hello, world!</h1>");  // says Hello
//        // Echo client's request information
//        out.println("<p>Request URI: " + request.getRequestURI() + "</p>");
//        out.println("<p>Protocol: " + request.getProtocol() + "</p>");
//        out.println("<p>PathInfo: " + request.getPathInfo() + "</p>");
//        out.println("<p>Remote Address: " + request.getRemoteAddr() + "</p>");
//        // Generate a random number upon each request
//        out.println("<p>A Random Number: <strong>" + Math.random() + "</strong></p>");
//        out.println("</body></html>");
//        out.close();  // Always close the output writer
//    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String input_name = request.getParameter("name");
        String input_username = request.getParameter("username");
        String input_password = request.getParameter("password");

        String db = "inventory_manager";
        String user = "root"; // assumes database name is the same as username
        String password = "root";

        String redirectPage = "";
        try {
            java.sql.Connection con;
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/inventory_manager?autoReconnect=true&useSSL=false", user, password);
            System.out.println(db + " database successfully opened.<br/><br/>");

            // Check to make sure inputs are valid
            String[] inputs = new String[] { input_name, input_username, input_password };

            for (String input : inputs) {
                if (input == null || input.length() == 0) {
                    System.out.println("Inputs must be filled out");
                    redirectPage="register.jsp";    // If inputs aren't valid send back to register page
                }
            }

            // Gets the next Employee ID
            // Auto increment didn't work for me so this will do for now
            String getNextIDString = "SELECT MAX(id) FROM Employee";
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery(getNextIDString);
            rs.next();
            int nextID = rs.getInt(1) + 1;  // column 1 is ID
            String id = Integer.toString(nextID);

            // SQL INSERT into Employee Query Execution
            String queryString = "INSERT INTO Employee (id, name, username, password) VALUES (?, ?, ?, ?)";

            PreparedStatement pstatement = con.prepareStatement(queryString);
            pstatement.setString(1, id);
            pstatement.setString(2, input_name);
            pstatement.setString(3, input_username);
            pstatement.setString(4, input_password);

            int insertQuery = 0;
            insertQuery = pstatement.executeUpdate();

            // "Returns either (1) the row count for SQL Data Manipulation Language (DML) statements or (2) 0 for SQL statements that return nothing"
            if (insertQuery == 0) {
                throw new SQLException("");
            }

            System.out.println("--Adding user to \"Employees\"-- \nName: " + input_name + "\nUsername: " + input_username + "\nPassword: " + input_password);

            // Upon successful inputs redirect to another page
//            redirectPage="someSuccessPage.jsp";

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