<%@ page import="java.sql.*"%>
<html>
  <head>
    <title>Inventory Manager</title>
    <style><%@include file="/css/add.css"%></style>
  </head>
  <body>
    <div class="add-header">
        <h1>Inventory Manager</h1>
        <h2>Add Manufacturer</h2>
        <p>Note: should only b accessible from admin page</p>
    
        <div class="add-body">
                <form action="">
					<div class="add-input-container">
                        <label for="">Manufacturer ID</label>
                        <input placeholder = "Manufacturer ID" NAME = "manuID-AM" type="int" />
                    </div>
                    <div class="add-input-container">
                        <label for="">Manufacturer Name</label>
                        <input placeholder = "Name" NAME = "manuName-AM" type="text" />
                    </div>
                    <div class="add-input-container">
                        <label for="">Manufacturer Address</label>
                        <input placeholder = "123 Example Address" NAME = "manuAddress-AM" type="text" />
                    </div>
                     <div class="add-button-container">
                        <button>Add Manufacturer</button>
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
	//	int manuID = Integer.parseInt(request.getParameter("adminIDReg")); // the parse doesn't work for int var
		String manuName = request.getParameter("manuName-AM");
		String manuAddress = request.getParameter("manuAddress-AM");

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
			String queryString = "insert into manufacturer(manfID,name,address) values(?,?,?)";
			pstatement = con.prepareStatement(queryString);
			
			// Sets the query info to variables that you get in HTML file			
			
			pstatement.setInt(1, 1542); 		// manuID field test
		//	pstatement.setString(1, adminID);
		
			pstatement.setString(2, manuName);
			pstatement.setString(3, manuAddress);
		
			updateQuery = pstatement.executeUpdate();
            
			// Teacher's code to print out enteries in database 
            out.println("Initial entries in table \"manufacturer\": <br/>");
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM manufacturer");
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
