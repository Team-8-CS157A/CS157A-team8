<%@ page import="java.sql.*"%>
<%@ page import="jakarta.servlet.*" %>
<html>
  <head>
    <title>Inventory Manager</title>
      <style><%@include file="/css/login.css"%></style>
      <link rel="preconnect" href="https://fonts.googleapis.com">
      <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
      <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
  </head>
  <body>
        <div class="login-header">
            <h1>Inventory Manager</h1>
            <h2>Login</h2>
            <div class="login-body">
                <form action="">
                    <div class="login-input-container">
                        <label>First Name</label>
                        <input name="FirstName" />
                    </div>
                    <div class="login-input-container">
                        <label>Last Name</label>
                        <input name="LastName" />
                    </div>
                    <div class="login-input-container">
                        <label>Phone Number</label>
                        <input name="phoneNumber" />
                    </div>
                    <div class="login-button-container">
                        <button>Login</button>
                    </div>
                </form>
            </div>
        </div>
    <% 
	
	// Database info
		String db = "inventory_manager";
        String user; // assumes database name is the same as username
          user = "root";
        String password = "root";
	
	// Gets information from the HTML file above
        String firstName = request.getParameter("FirstName");
        String lastName = request.getParameter("LastName");
        String phoneNumber = request.getParameter("phoneNumber");

        String redirectPage;

        if (firstName == null) {
            return;
        }
		
        try {
            
			// Gets database connection + JDBC driver
            java.sql.Connection con; 
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/inventory_manager?autoReconnect=true&useSSL=false",user, password);

            // Run a query each on AdminUsers & Emp_Users to check credentials
            String loginQueryAdmin = "SELECT COUNT(*) FROM AdminUsers WHERE FirstName = ? AND LastName = ? AND phoneNumber = ?;";
            PreparedStatement pstatementAdmin = con.prepareStatement(loginQueryAdmin);
            pstatementAdmin.setString(1, firstName);
            pstatementAdmin.setString(2, lastName);
            pstatementAdmin.setString(3, phoneNumber);


            String loginQueryEmp = "SELECT COUNT(*) FROM Emp_Users WHERE FirstName = ? AND LastName = ? AND phoneNumber = ?;";
            PreparedStatement pstatementEmp = con.prepareStatement(loginQueryEmp);
            pstatementEmp.setString(1, firstName);
            pstatementEmp.setString(2, lastName);
            pstatementEmp.setString(3, phoneNumber);

            ResultSet rsAdmin = pstatementAdmin.executeQuery();
            ResultSet rsEmp = pstatementEmp.executeQuery();

            /*
            * If the user exists, log them in and determine the user type (Admin or Emp)
            * */
            rsAdmin.next();
            int doesUserExistAdmin = rsAdmin.getInt(1);

            rsEmp.next();
            int doesUserExistEmp = rsEmp.getInt(1);

            // If user exist redirect to another page, takes in redirectPage as a variable redirect
            if (doesUserExistAdmin == 1) {
                redirectPage = "http://localhost:8080/adminHome.jsp?FirstName=" + firstName + "&LastName=" + lastName;
                response.sendRedirect(redirectPage);
            } else if (doesUserExistEmp == 1) {
                redirectPage = "http://localhost:8080/empHome.jsp?FirstName=" + firstName + "&LastName=" + lastName;
                response.sendRedirect(redirectPage);
            } else {
                out.println("User with these credentials does not exist!");
            }

            con.close();
        } catch(SQLException e) { 
            out.println("SQLException caught: " + e.getMessage()); 
        }
    %>
  </body>
</html>
