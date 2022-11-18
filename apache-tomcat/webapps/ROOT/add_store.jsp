<%@ page import="java.sql.*"%>
<html>
  <head>
    <title>Inventory Manager</title>
    <style><%@include file="/css/add.css"%></style>

  </head>
  <body>
    <div class="add-header">
        <h1>Inventory Manager</h1>
        <h2>Add Store</h2>
        <p>should be assessible from home page</p>
    
        <div class="add-body">
                <form action="">
                    <div class="add-input-container">
                        <label for="">Store ID</label>
                        <input placeholder = "Store ID" NAME = "storeID-AS" type="int" />
                    </div>
                    <div class="add-input-container">
                        <label for="">Admin ID</label>
                        <input placeholder = "Name" NAME = "adminID-AS" type="int" />
                    </div>
                    <div class="add-input-container">
                        <label for="">Address</label>
                        <input placeholder = "123 Example Address" NAME = "storeAddress-AS" type="text" />
                    </div>
                    <div class="add-input-container">
                        <label for="">Store Inventory ID</label>
                        <input placeholder = "Store Inventory ID" NAME = "storeInvID" type="int" />
                    </div>
                     <div class="add-button-container">
                        <button>Add Store</button>
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
	//	int storeID = Integer.parseInt(request.getParameter("adminIDReg")); // the parse doesn't work for int var
	//	int adminID = Integer.parseInt(request.getParameter("adminIDReg")); // the parse doesn't work for int var
		String address = request.getParameter("storeAddress-AS");
	//	int storeInventoryID = Integer.parseInt(request.getParameter("adminIDReg")); // the parse doesn't work for int var

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
			String queryString = "insert into store(storeID,adminID,address,storeInventoryID) values(?,?,?,?)";
			pstatement = con.prepareStatement(queryString);
			
			// Sets the query info to variables that you get in HTML file			
			
			pstatement.setInt(1, 1542); 		// storeID field test
		//	pstatement.setString(1, adminID);
		
			pstatement.setInt(2, 1562); 		// adminID field test
		//	pstatement.setString(2, adminID);
		
			pstatement.setString(3, address);
		
			pstatement.setInt(4, 13452); 		// storeInventoryID field test
		//	pstatement.setString(4, adminID);
		
			updateQuery = pstatement.executeUpdate();
            
			// Teacher's code to print out enteries in database 
            out.println("Initial entries in table \"store\": <br/>");
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM store");
            while (rs.next()) {
                out.println(rs.getInt(1) + " " + rs.getInt(2) + " " + rs.getString(3) +
							" " + rs.getInt(4) + "<br/><br/>");
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
