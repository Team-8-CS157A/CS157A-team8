<%@ page import="java.sql.*"%>
<html>
<head>
    <title>Update Inventory</title>
    <style><%@include file="/css/items.css"%></style>
<%--    <style><%@include file="/css/add.css"%></style>--%>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
</head>
 
 <body>
	<div class="item-body">
	<h1>Update Inventory</h1>
        <form action="">
		<h3>Please fill in all required* fields, then fill in the fields you would like to update</h3>
			<div class="item-input-container">
                <label for="">Store Inventory ID</label>
                <input placeholder = "Required*" NAME = "storeInventoryID" type="int" />
            </div>
			<div class="item-input-container">
                <label for="">Item Name</label>
                <input placeholder = "Item Name" NAME = "itemsStocked" type="String" />
            </div>			
			<div class="item-input-container">
				<label for="">Number of Stocked items</label>
                <input  placeholder = "Number of Stocked Item" NAME = "inventoryStock" type="int" />
            </div>
			<div class="item-input-container">
                <label for="">Store ID</label>
                <input  placeholder = "Required*" NAME = "storeID"type="int" />
            </div>   
			<div class="item-button-container">
                <button>Update Inventory</button>
            </div>			
        </form>
		<div class="item-button-container">
			<a href="adminHome.jsp">
				<button>Back to Admin Home</button>
			</a>
		</div>
    </div>
    <% 
	
	// Database info
		String db = "inventory_manager";
        String user; // assumes database name is the same as username
          user = "root";
        String password = "rootpass";
	
	// Gets information from the HTML file above
       String storeID = request.getParameter("storeID");
       String itemsStocked = request.getParameter("itemsStocked");
	   String inventoryStocked = request.getParameter("inventoryStock");
	   
	   
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
			String queryString;
			
			if(storeID== null){ // code to prevent page to run on render
				return;
			}
			if(itemsStocked != null){
				queryString = "update inventory set itemsStocked = ? WHERE storeInventoryID = ?";
				PreparedStatement statement = con.prepareStatement(queryString);
				statement.setString(1, itemsStocked);
				statement.setInt(2, Integer.parseInt(request.getParameter("storeInventoryID")));
				statement.executeUpdate();
                out.println("Successfully updated item");
			
			}
			//if (inventoryStocked != null){
			//	queryString = "update inventory set inventoryStock = ? WHERE storeInventoryID = ?";
			//	PreparedStatement gstatement = con.prepareStatement(queryString);
			//	gstatement.setInt(1, Integer.parseInt(request.getParameter("inventoryStock")));
			//	gstatement.setInt(2, Integer.parseInt(request.getParameter("storeInventoryID")));
			//	gstatement.executeUpdate();
				
			//}
	
            con.close();
        } catch(SQLException e) { 
            out.println("SQLException caught: " + e.getMessage()); 
        }
    %>
  </body>
</html>
