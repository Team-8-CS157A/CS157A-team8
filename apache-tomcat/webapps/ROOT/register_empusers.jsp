<%@ page import="java.sql.*"%>
<%@page import="java.util.*" %>

<html>
  <head>
    <title>Inventory Manager</title>
    <style><%@include file="/css/register.css"%></style>
      <link rel="preconnect" href="https://fonts.googleapis.com">
      <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
      <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
  </head>
  <body>
  <%

      // Database info
      String db = "inventory_manager";
      String user; // assumes database name is the same as username
      user = "root";
      String password = "rootpass";

      // Gets information from the HTML file above
      //	int userID = Integer.parseInt(request.getParameter("adminIDempR")); // the parse doesn't work for int vars
      String firstName = request.getParameter("firstNameempR");
      String lastName = request.getParameter("lastNameempR");
      Random randID = new Random();         // generate random number up to 1000
      int userID = randID.nextInt(1000);    //use randID to generate random empUserID
      String phoneNum = request.getParameter("phoneNumempR");

      // Stuff in order to insert
      PreparedStatement pstatement = null;
      int updateQuery = 0;

      try {

          // Gets database connection + JDBC driver
          java.sql.Connection con;
          Class.forName("com.mysql.jdbc.Driver");
          con = DriverManager.getConnection("jdbc:mysql://localhost:3306/inventory_manager?autoReconnect=true&useSSL=false",user, password);

          // String SQL insert statement, should correspond to table information in database
          String queryStringEmpTable = "insert into emp_users(empUserID,FirstName,LastName,phoneNumber,storeID, adminID) values(?,?,?,?,?,?)";
          pstatement = con.prepareStatement(queryStringEmpTable);
          // Sets the query info to variables that you get in HTML file

          // Teacher's code to print out enteries in database
//          out.println("Initial entries in table \"emp_users\": <br/>");
          Statement stmt = con.createStatement();
          Statement storeStmt = con.createStatement();
          Statement adminStmt = con.createStatement();

          ResultSet rs = stmt.executeQuery("SELECT * FROM emp_users");
          ResultSet storeRS = storeStmt.executeQuery("Select * FROM store;");
          ResultSet adminRS = adminStmt.executeQuery("Select * FROM adminusers;");

//          while (rs.next()) {
//              out.println(rs.getInt(1) + " " + rs.getString(2) + " " + rs.getString(3) + " " +
//                      rs.getString(4) + " " + rs.getInt(5) + " " + rs.getInt(6) + "<br/><br/>");
//          }
  %>
    <div class="reg-header">
        <h1>Inventory Manager</h1>
        <h2>Register New Employee User</h2>
        <div class="reg-body">
                <form action="registerEmp_confirmation.jsp">
                    <div class="reg-input-container">
                        <label for="">First Name</label>
                        <input placeholder = "First Name" NAME = "firstNameempR" type="text" />
                    </div>
                    <div class="reg-input-container">
                        <label for="">Last Name</label>
                        <input placeholder = "Last Name" NAME = "lastNameempR" type="text" />
                    </div>
                    <div class="reg-input-container">
                        <label for="">Phone Number</label>
                        <input  placeholder = "Phone Number" NAME = "phoneNumempR"type="text" />
                    </div>
                    <div class="reg-input-container">
                        <label for="">Store Name</label>
<%--                        <input  placeholder = "Store ID" NAME = "storeIDempR "type="int" />--%>
                        <select name="store">
                            <option selected disabled>Choose Store Name</option>
                            <%
                                while(storeRS.next()) {
                                    String storeName = storeRS.getString("name");
                                    String storeID = storeRS.getString("storeID");
                            %>
                            <%-- user sees the store name displayed, but the storeID is stored in DB--%>
                            <option value="<%=storeID %>"><%=storeName %></option>
                            <%
                                }
                            %>
                        </select>

                    </div>
                    <div class="reg-input-container">
                        <label for="">Admin Name</label>
                        <select name="admin">
                            <option selected disabled> Choose Admin Name</option>
                            <%

                                while(adminRS.next()) {
                                    String adminName = adminRS.getString("FirstName") + " " + adminRS.getString("LastName");
                                    String adminID = adminRS.getString("adminID");

                            %>
                            <%-- user sees the store name displayed, but the storeID is stored in DB--%>
                                   <option value="<%=adminID %>"><%=adminName %></option>
                            <%

                                }
                            %>
                        </select>
                        <%
//                          pstatement.setInt(5, Integer.parseInt(request.getParameter("store")));
//                          pstatement.setInt(6, Integer.parseInt(request.getParameter("admin")));
//                            pstatement.setInt(6, Integer.parseInt(request.getParameter("admin")));

//                            updateQuery = pstatement.executeUpdate();

                        %>
<%--                          <p>Selected Admin: ${param.admin}</p>--%>

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
