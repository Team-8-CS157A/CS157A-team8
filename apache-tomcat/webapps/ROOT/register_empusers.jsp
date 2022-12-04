<%@ page import="java.sql.*"%>
<html>
  <head>
    <title>Inventory Manager</title>
    <style><%@include file="/css/register.css"%></style>

  </head>
  <body>
    <div class="reg-header">
        <h1>Inventory Manager</h1>
        <h2>Register New Admin User</h2>
        <div class="reg-body">
                <form action="">
                    <div class="reg-input-container">
                        <label for="">Emp ID</label>
                        <input placeholder = "Pregiven Emp ID Number" NAME = "empIDempR" type="int" />
                    </div>
                    <div class="reg-input-container">
                        <label for="">First Name</label>
                        <input placeholder = "First Name" NAME = "firstNameempR" type="text" />
                    </div>
                    <div class="reg-input-container">
                        <label for="">Last Name</label>
                        <input placeholder = "Last Name" NAME = "lastNameempR" type="text" />
                    </div>
                    <div class="reg-input-container">
                        <label for="">Username</label>
                        <input placeholder = "Create Username" NAME = "usernameempR" type="text" />
                    </div>
                    <div class="reg-input-container">
                        <label for="">Password</label>
                        <input  placeholder = "Create Password" NAME = "passwordempR "type="password" />
                    </div>
                    <div class="reg-input-container">
                        <label for="">Phone Number</label>
                        <input  placeholder = "Phone Number" NAME = "phoneNumempR"type="text" />
                    </div>
                    <div class="reg-input-container">
                        <label for="">Store ID</label>
                        <input  placeholder = "Store ID" NAME = "storeIDempR "type="int" />
                    </div>
                    <div class="reg-input-container">
                        <label for="">Admin ID</label>
                        <input  placeholder = "Your manager's ID Number" NAME = "adminIDempR "type="int" />
                    </div>
                    <div class="reg-button-container">
                        <button>Register</button>
                    </div>
                </form>
        </div>
    </div>
    <% 
	
	// Database info
		String db = "inventory-manager";
        String user; // assumes database name is the same as username
          user = "root";
        String password = "@J4wn1033";
	
	// Gets information from the HTML file above
	//	int userID = Integer.parseInt(request.getParameter("adminIDempR")); // the parse doesn't work for int vars
		String firstName = request.getParameter("firstNameempR");
		String lastName = request.getParameter("lastNameempR");
		String username = request.getParameter("usernameempR");
		String pswd = request.getParameter("passwordempR");
		String phoneNum = request.getParameter("phoneNumempR");
	//	int storeID = Integer.parseInt(request.getParameter("storeIDempR")); // the parse doesn't work for int vars
	//	int adminID = Integer.parseInt(request.getParameter("adminIDempR")); // the parse doesn't work for int vars
		
	// Stuff in order to insert
		PreparedStatement pstatement = null;
		int updateQuery = 0;
		
        try {
            
			// Gets database connection + JDBC driver
            java.sql.Connection con; 
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/inventory-manager?autoReconnect=true&useSSL=false",user, password);
            out.println(db + " database successfully opened.<br/><br/>");
			
			// String SQL insert statement, should correspond to table information in database
			String queryStringEmpTable = "insert into emp_users(empUserID,FirstName,LastName,phoneNumber,storeID, adminID) values(?,?,?,?,?,?)";
			pstatement = con.prepareStatement(queryStringEmpTable);
			
			// Sets the query info to variables that you get in HTML file			
			
			pstatement.setInt(1, 15629); 		// empID field test
		//	pstatement.setString(1, userID);
		
			pstatement.setString(2, firstName);
			pstatement.setString(3, lastName);
			
			// pstatement.setString(?*, username); // need to make tables for this info
			// pstatement.setString(?*, pswd);  // and this info

			pstatement.setString(4, phoneNum);
			
			pstatement.setInt(5, 15781); 		// storeID field test
		//  pstatement.setString(5, storeID);
		
			pstatement.setInt(6, 15981); 		// adminID field test
		//  pstatement.setString(6, adminID);
		
			updateQuery = pstatement.executeUpdate();
            
			// Teacher's code to print out enteries in database 
            out.println("Initial entries in table \"emp_users\": <br/>");
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM emp_users");
            while (rs.next()) {
                out.println(rs.getInt(1) + " " + rs.getString(2) + " " + rs.getString(3) + " " + 
							rs.getString(4) + " " + rs.getInt(5) + " " + rs.getInt(6) + "<br/><br/>");
            }
            rs.close();
            stmt.close();
            con.close();
        } catch(SQLException e) { 
            out.println("SQLException caught: " + e.getMessage()); 
        }
    %>
  </body>
</html>
