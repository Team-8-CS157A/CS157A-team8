<%@ page import="java.sql.*"%>
<html>
  <head>
    <title>Inventory Manager</title>
    </head>
  <body>
    <h1>Inventory Manager Application</h1>
	<h2>Team 8</h2>
    
     <div class="login-body">
                <form action="">
					<div>
						<label for="">ID</label>
                        <input placeholder = "ID" NAME = "IDLogin" type="text" />
					</div>
                    <div class="login-input-container">
                        <label for="">Username</label>
                        <input placeholder = "username" NAME = "usernameLogin" type="text" />
                    </div>
                    <div class="login-input-container">
                        <label for="">Password</label>
                        <input  placeholder = "password" NAME = "passwordLogin "type="password" />
                    </div>
                    <div class="login-button-container">
                        <button>Login</button>
                    </div>
                </form>
            </div>
        </div>
    <% 
	
	// Database info
		String db = "zhang";
        String user; // assumes database name is the same as username
          user = "root";
        String password = "Panda101";
	
	// Gets information from the HTML file above
	//  int ID = Integer.parseInt(request.getParameter("IDLogin")); // the parse doesn't work for int vars
		String username = request.getParameter("usernameLogin");
		String pswd = request.getParameter("passwordLogin");
		
	// Stuff in order to insert
		PreparedStatement pstatement = null;
		int updateQuery = 0;
		
        try {
            
			// Gets database connection + JDBC driver
            java.sql.Connection con; 
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/zhang?autoReconnect=true&useSSL=false",user, password);
            out.println(db + " database successfully opened.<br/><br/>");
			
			// String SQL insert statement, should correspond to table information in database
			String queryString = "insert into hw1(SJSU_ID,NAME,MAJOR) values(?,?,?)";
			pstatement = con.prepareStatement(queryString);
			
			// Sets the query info to variables that you get in HTML file
			pstatement.setInt(1, 11236); // Sets int to hard value that you need to change
									     // everytime you insert b/c no duplicate entries :(
										 // need to change to variable once parseInt works
			pstatement.setString(2, username);
			pstatement.setString(3, pswd);
			updateQuery = pstatement.executeUpdate();
            
			// Teacher's code to print out enteries in database 
            out.println("Initial entries in table \"hw1\": <br/>");
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM hw1");
            while (rs.next()) {
                out.println(rs.getInt(1) + " " + rs.getString(2) + " " + rs.getString(3) + "<br/><br/>");
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
