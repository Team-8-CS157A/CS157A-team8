<%@ page import="java.sql.*"%>
<%@page import="java.util.*" %>

<html>
  <head>
    <title>Inventory Manager</title>
    <style><%@include file="/css/add.css"%></style>
      <link rel="preconnect" href="https://fonts.googleapis.com">
      <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
      <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
  </head>
  <body>
    <div class="add-header">
        <h1>Inventory Manager</h1>
        <h2>Add Manufacturer</h2>
        <div class="add-body">
            <form action="">
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

            <div class="add-button-container">
                <%
                    String firstName = request.getParameter("FirstName");
                    String lastName = request.getParameter("LastName");
                %>
                <a href="adminHome.jsp?FirstName=<%=firstName%>&LastName=<%=lastName%>">
                    Back to Admin Home
                </a>
            </div>
        </div>
    </div>
    <% 
	
	// Database info
		String db = "inventory_manager";
        String user; // assumes database name is the same as username
          user = "root";
        String password = "rootpass";
	
	// Gets information from the HTML file above
	//	int manuID = Integer.parseInt(request.getParameter("adminIDReg")); // the parse doesn't work for int var
		String manuName = request.getParameter("manuName-AM");
		String manuAddress = request.getParameter("manuAddress-AM");
        Random randID = new Random();       // generate random number up to 1000
        int manuID = randID.nextInt(1000);
        // Stuff in order to insert
		PreparedStatement pstatement = null;
		int updateQuery = 0;

        // Prevent below code from running on page render
        if (manuName == null) {
            return;
        }

        try {
            
			// Gets database connection + JDBC driver
            java.sql.Connection con; 
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/inventory_manager?autoReconnect=true&useSSL=false",user, password);
            out.println(db + " database successfully opened.<br/><br/>");
			
			// String SQL insert statement, should correspond to table information in database
			String queryString = "insert into manufacturer(manfID,name,address) values(?,?,?)";
			pstatement = con.prepareStatement(queryString);
			
			// Sets the query info to variables that you get in HTML file			
			
			pstatement.setInt(1, manuID); 		// manuID field test
		//	pstatement.setString(1, adminID);
		
			pstatement.setString(2, manuName);
			pstatement.setString(3, manuAddress);
		
			updateQuery = pstatement.executeUpdate();
            
			// Teacher's code to print out enteries in database 
//            out.println("Initial entries in table \"manufacturer\": <br/>");
//            Statement stmt = con.createStatement();
//            ResultSet rs = stmt.executeQuery("SELECT * FROM manufacturer");
//            while (rs.next()) {
//                out.println(rs.getInt(1) + " " + rs.getString(2) + " " + rs.getString(3) + "<br/><br/>");
//            }
//            rs.close();
//            stmt.close();
            con.close();
        } catch(SQLException e) { 
            out.println("SQLException caught: " + e.getMessage()); 
        }
    %>
  </body>
</html>
