<%@ page import="java.sql.*"%>
<html>
<head>
    <title>Items Page</title>
    <style><%@include file="/css/items.css"%></style>
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
</head>
<body>
  <div class="item-body">
	<h1>Inventory Manager Application</h1>
	<h2>Remove Item</h2>
	
        <form action="">
            <div class="item-input-container">
                <label for="">Item name to Delete</label>
                <input name="name" type="text" />
            </div>
			  <div class="item-button-container">
                <button>Delete Item</button>
            </div>
        </form>
		
		<div class="item-button-container">
			<%
				String firstName = request.getParameter("FirstName");
				String lastName = request.getParameter("LastName");
			%>
			<a href="adminHome.jsp?FirstName=<%=firstName%>&LastName=<%=lastName%>">
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
			
			String name = request.getParameter("name");

			// Prevent below code from running on page render
			if (name == null) {
				return;
			}
			
            try {

                // Gets database connection + JDBC driver
                java.sql.Connection con;
                Class.forName("com.mysql.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/inventory_manager?autoReconnect=true&useSSL=false",user, password);

				// Check to see if item exists
                String checkString = "SELECT COUNT(*) FROM Item WHERE name = ?";
				PreparedStatement checkForExistingItem = con.prepareStatement(checkString);
				checkForExistingItem.setString(1, name);
				ResultSet rs = checkForExistingItem.executeQuery();
				rs.next();
				if (rs.getInt(1) < 1) {
					out.println("Item does not exists!");
					return;
				}
				
				String deleteString = "DELETE FROM Item WHERE name = ?";
				PreparedStatement deleteStatement = con.prepareStatement(deleteString);
				deleteStatement.setString(1, name);
				
				if(name != null){
					int queryResult = deleteStatement.executeUpdate();
					
					if (queryResult != 0) {
						out.println("Successfully deleted item: " + name);

						String redirectPage = "remove_item.jsp";
						response.sendRedirect(redirectPage);
					}
				}
				
                rs.close();
                con.close();
            } catch(SQLException e) {
                out.println("SQLException caught: " + e.getMessage());
            }

 %>
 
</body>
</html>
