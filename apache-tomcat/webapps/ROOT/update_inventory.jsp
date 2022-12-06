<%@ page import="java.sql.*"%>
<html>
  <head>
    <title>Inventory Manager</title>
      <style><%@include file="/css/update.css"%></style>
  </head>
  <body>
    <h1>Inventory Manager Application</h1>
	<h2>Update Inventory</h2>
    
     <div class="update-inventory-body">
                <form action="">
					<div class="update-inventory-input-container">
                        <label for="">Store Inventory ID</label>
                        <input placeholder = "ID Number" NAME = "storeInventoryID-UI" type="int" />
                    </div>
					<div class="update-inventory-input-container">
                        <label for="">Item to add</label>
                        <input  placeholder = "Item name" NAME = "itemsStocked-UI"type="text" />
                    </div>
					<div class="update-inventory-input-container">
                        <label for="">Amount of Inventory</label>
                        <input  placeholder = "Number of items" NAME = "itemAmt-UI"type="int" />
                    </div>
					<div class="update-inventory-input-container">
                        <label for="">Store ID</label>
                        <input  placeholder = "Store ID" NAME = "storeID-UI"type="int" />
                    </div>
                    <div class="update-inventory-button-container">
                        <button>Add Item</button>
                    </div>
                </form>
            </div>
        </div>
    <% 
	
	// Database info
		String db = "inventory_manager";
        String user; // assumes database name is the same as username
          user = "root";
        String password = "Panda101";
	
	// Gets information from the HTML file above
	//	int storeInventoryID = Integer.parseInt(request.getParameter("adminIDReg")); // the parse doesn't work for int vars
		String itemName = request.getParameter("itemsStocked-UI");
	//	int inventoryStock= Integer.parseInt(request.getParameter("adminIDReg")); // the parse doesn't work for int vars
	//	int storeID = Integer.parseInt(request.getParameter("storeIDReg")); // the parse doesn't work for int vars
		
	// Stuff in order to insert
		PreparedStatement pstatement = null;
		int updateQuery = 0;
		
        try {
            
			// Gets database connection + JDBC driver
            java.sql.Connection con; 
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/inventory_manager?autoReconnect=true&useSSL=false",user, password);
            out.println(db + " database successfully opened.<br/><br/>");
			
			// String SQL insert statement, should correspond to table information in database
			String queryString = "insert into inventory(storeInventoryID,itemsStocked,inventoryStock,storeID) values(?,?,?,?)";
			pstatement = con.prepareStatement(queryString);
			
			// Sets the query info to variables that you get in HTML file			
			
			pstatement.setInt(1, 529); 		// storeInventoryID field test
		//	pstatement.setString(1, adminID);
		
			pstatement.setString(2, itemName);
			
			pstatement.setInt(3, 151); 		// inventory stock field test
		//  pstatement.setString(3, storeID);
		
			pstatement.setInt(4, 1551); 		// storeID field test
		//  pstatement.setString(4, storeID);
		
			updateQuery = pstatement.executeUpdate();
            
			// Teacher's code to print out enteries in database 
            out.println("Initial entries in table \"inventory\": <br/>");
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM inventory");
            while (rs.next()) {
                out.println(rs.getInt(1) + " " + rs.getString(2) + " " + rs.getInt(1) + " " + 
							rs.getInt(1) + "<br/><br/>");
            }
            rs.close();
            stmt.close();
            con.close();
        } catch(SQLException e) { 
            out.println("SQLException caught: " + e.getMessage()); 
        }
    %>
	  <div class="add-button-container">
        <a href="adminHome.jsp">
            <button>Back Home</button>
        </a>
    </div>

  </body>
</html>
