<%@ page import="java.sql.*"%>
<%@page import="java.util.*" %>

<html>
  <head>
    <title>Inventory Manager</title>
    <style><%@include file="/css/register.css"%></style>
    </head>
  <body>
  <%

      // Database info
      String db = "inventory_manager";
      String user; // assumes database name is the same as username
      user = "root";
      String password = "@J4wn1033";

      // Gets information from the HTML file above
      String firstName = request.getParameter("firstNameReg");
      String lastName = request.getParameter("lastNameReg");
      String username = request.getParameter("usernameReg");
      String pswd = request.getParameter("passwordReg");
      Random randID = new Random();       // generate random number up to 1000
      int adminID = randID.nextInt(1000); // use randID to generate random adminID
      String phoneNum = request.getParameter("phoneNumReg");
//		int storeID = randID.nextInt(1000); // use randID to generate random storeID
      // shouldn't be random, but leaving like this for now

      // Stuff in order to insert
      PreparedStatement pstatement = null;
      PreparedStatement ps = null;
      int updateQuery = 0;

      try {

          // Gets database connection + JDBC driver
          java.sql.Connection con;
          Class.forName("com.mysql.jdbc.Driver");
          con = DriverManager.getConnection("jdbc:mysql://localhost:3306/inventory_manager?autoReconnect=true&useSSL=false",user, password);
          out.println(db + " database successfully opened.<br/><br/>");

          // String SQL insert statement, should correspond to table information in database
          String queryStringAdminTable = "insert into adminusers(AdminID,FirstName,LastName,phoneNumber, storeID) values(?,?,?,?,?)";
          pstatement = con.prepareStatement(queryStringAdminTable);
          // Sets the query info to variables that you get in HTML file

          pstatement.setInt(1, adminID); 		// adminID field test
          //	pstatement.setString(1, adminID);

          pstatement.setString(2, firstName);
          pstatement.setString(3, lastName);

          // pstatement.setString(?*, username); // need to make tables for this info
          // pstatement.setString(?*, pswd);  // and this info

          pstatement.setString(4, phoneNum);

//			pstatement.setInt(5, storeID); 		// storeID field test
          //  pstatement.setString(5, storeID);



          // Teacher's code to print out enteries in database
          out.println("Initial entries in table \"adminusers\": <br/>");
          Statement stmt = con.createStatement();
          Statement storeStmt = con.createStatement();
          ResultSet rs = stmt.executeQuery("SELECT * FROM adminusers;");
          ResultSet storeRS = storeStmt.executeQuery("Select * FROM store;");
          while (rs.next()) {
              out.println(rs.getInt(1) + " " + rs.getString(2) + " " + rs.getString(3) + " " +
                      rs.getString(4) + " " + rs.getInt(5) + "<br/><br/>");

//              String storeName = storeRS.getString("name");
//              out.println(storeRS.getInt(1) + " " + storeRS.getString(2) + "<br/><br/>");
          }

//          String storeInfo = "SELECT * FROM store"; //gather store info
//          Statement storeStmt = con.createStatement();
//          ResultSet resultSet = ps.executeQuery("SELECT * FROM store");
//            while (resultSet.next()) {
////                out.println(resultSet.getString(0));
//            }
  %>
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

                    <%-- REMOVING FOR NOW
                    <div class="reg-input-container">
                        <label for="">Username</label>
                        <input placeholder = "Create Username" NAME = "usernameReg" type="text" />
                    </div>
                    <div class="reg-input-container">
                        <label for="">Password</label>
                        <input  placeholder = "Create Password" NAME = "passwordReg "type="password" />
                    </div>
                    --%>

<%--                    Removed so now adminID is randomly generated
                        <div class="reg-input-container">--%>
<%--                        <label for="">Admin ID</label>--%>
<%--                        <input  placeholder = "Pregiven Admin ID Number" NAME = "adminIDReg "type="int" />--%>
<%--                    </div>--%>
                    <div class="reg-input-container">
                        <label for="">Phone Number</label>
                        <input  placeholder = "Phone Number" NAME = "phoneNumReg"type="text" />
                    </div>
                    <div class="reg-input-container">
                        <%--user should be able to select from list of stores --%>
                        <label for="">Store Name</label>
<%--                        <input  placeholder = "Store ID" NAME = "storeIDReg "type="int" />--%>
                            <select name="store">
                                <%
                                while(storeRS.next()) {
                                    String storeName = storeRS.getString("name");
                                    String storeID = storeRS.getString("storeID");
                                %>
                                <%-- user sees the store name displayed, but the storeID is stored in DB--%>
                                <option value="<%=storeID %>"><%=storeName %></option>
                                <%
                                        out.println(storeID + " " + storeName); //for debugging
                                    }
                                %>
                            </select>
                        <%

                            pstatement.setInt(5, Integer.parseInt(request.getParameter("store")));
                            updateQuery = pstatement.executeUpdate();

                        %>
<%--                        <p>Selected Store: ${param.store}</p> //for debugging--%>
                    </div>
                    <div class="reg-button-container">
                        <button>Register</button>
                    </div>
                </form>
        </div>
    </div>
    <%
            rs.close();
            stmt.close();
            con.close();
        } catch(SQLException e) {
            out.println("SQLException caught: " + e.getMessage());
        }
    %>
  </body>
</html>
