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

    try {

          // Gets database connection + JDBC driver
          java.sql.Connection con;
          Class.forName("com.mysql.jdbc.Driver");
          con = DriverManager.getConnection("jdbc:mysql://localhost:3306/inventory_manager?autoReconnect=true&useSSL=false",user, password);
//          out.println(db + " database successfully opened.<br/><br/>");

          Statement storeStmt = con.createStatement();
          ResultSet storeRS = storeStmt.executeQuery("Select * FROM store;");

%>
<div class="reg-header">
    <h1>Inventory Manager</h1>
    <h2>Register New Admin User</h2>
    <div class="reg-body">
        <form action="registerAdmin_confirmation.jsp">
            <div class="reg-input-container">
                <label for="">First Name</label>
                <input placeholder = "First Name" NAME = "firstNameReg" type="text" />
            </div>
            <div class="reg-input-container">
                <label for="">Last Name</label>
                <input placeholder = "Last Name" NAME = "lastNameReg" type="text" />
            </div>
            <div class="reg-input-container">
                <label for="">Phone Number</label>
                <input  placeholder = "Phone Number" NAME = "phoneNumReg"type="text" />
            </div>
            <div class="reg-input-container">
                <%--user should be able to select from list of stores --%>
                <label for="">Store Name</label>
                <%--                        <input  placeholder = "Store ID" NAME = "storeIDReg "type="int" />--%>
                <select NAME="store">
                    <option selected disabled value="">Choose Store Name</option>
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
            <div class="reg-button-container">
                <button>Register</button>
            </div>
        </form>
    </div>
</div>
  <%
          storeRS.close();
//          stmt.close();
          con.close();
      } catch(SQLException e) {
          out.println("SQLException caught: " + e.getMessage());
      }
  %>
</body>
</html>
