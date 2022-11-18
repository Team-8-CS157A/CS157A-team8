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
                        <label for="">First Name</label>
                        <input placeholder = "First Name" NAME = "firstNameReg" type="text" />
                    </div>
                    <div class="reg-input-container">
                        <label for="">Last Name</label>
                        <input placeholder = "Last Name" NAME = "lastNameReg" type="text" />
                    </div>
                    <div class="reg-input-container">
                        <label for="">Username</label>
                        <input placeholder = "Create Username" NAME = "usernameReg" type="text" />
                    </div>
                    <div class="reg-input-container">
                        <label for="">Password</label>
                        <input  placeholder = "Create Password" NAME = "passwordReg "type="password" />
                    </div>
                    <div class="reg-input-container">
                        <label for="">Admin ID</label>
                        <input  placeholder = "Pregiven Admin ID Number" NAME = "adminIDReg "type="int" />
                    </div>
                    <div class="reg-input-container">
                        <label for="">Phone Number</label>
                        <input  placeholder = "Phone Number" NAME = "phoneNumReg"type="text" />
                    </div>
                    <div class="reg-input-container">
                        <label for="">Store ID</label>
                        <input  placeholder = "Store ID" NAME = "storeIDReg "type="int" />
                    </div>
                    <div class="reg-button-container">
                        <button>Register</button>
                    </div>
                </form>
        </div>
    </div>
    <% 
	
	// Database info
		String db = "cs156a_proj";
        String user; // assumes database name is the same as username
          user = "root";
        String password = "Panda101";
	
	// Gets information from the HTML file above
		String firstName = request.getParameter("firstNameReg");
		String lastName = request.getParameter("lastNameReg");
		String username = request.getParameter("usernameReg");
		String pswd = request.getParameter("passwordReg");
	//	int adminID = Integer.parseInt(request.getParameter("adminIDReg")); // the parse doesn't work for int vars
		String phoneNum = request.getParameter("phoneNumReg");
	//	int storeID = Integer.parseInt(request.getParameter("storeIDReg")); // the parse doesn't work for int vars
		
	// Stuff in order to insert
		PreparedStatement pstatement = null;
		int updateQuery = 0;
		
        try {
            
			// Gets database connection + JDBC driver
            java.sql.Connection con; 
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cs156a_proj?autoReconnect=true&useSSL=false",user, password);
            out.println(db + " database successfully opened.<br/><br/>");
			
			// String SQL insert statement, should correspond to table information in database
			String queryStringAdminTable = "insert into adminusers(AdminID,FirstName,LastName,phoneNumber,storeID) values(?,?,?,?,?)";
			pstatement = con.prepareStatement(queryStringAdminTable);
			
			// Sets the query info to variables that you get in HTML file			
			
			pstatement.setInt(1, 1529); 		// adminID field test
		//	pstatement.setString(1, adminID);
		
			pstatement.setString(2, firstName);
			pstatement.setString(3, lastName);
			
			// pstatement.setString(?*, username); // need to make tables for this info
			// pstatement.setString(?*, pswd);  // and this info

			pstatement.setString(4, phoneNum);
			
			pstatement.setInt(5, 1581); 		// storeID field test
		//  pstatement.setString(5, storeID);
		
			updateQuery = pstatement.executeUpdate();
            
			// Teacher's code to print out enteries in database 
            out.println("Initial entries in table \"adminusers\": <br/>");
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM adminusers");
            while (rs.next()) {
                out.println(rs.getInt(1) + " " + rs.getString(2) + " " + rs.getString(3) + " " + 
							rs.getString(4) + " " + rs.getInt(5) + "<br/><br/>");
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
