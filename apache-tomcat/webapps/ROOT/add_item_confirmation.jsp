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

    int updateQuery = 0;

    String firstName = request.getParameter("FirstName");
    String lastName = request.getParameter("LastName");

    try {

        // Gets database connection + JDBC driver
        java.sql.Connection con;
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/inventory_manager?autoReconnect=true&useSSL=false",user, password);
        out.println(db + " database successfully opened.<br/><br/>");

        // Check to see if the item already exists in the table, if so do not add
        String name = request.getParameter("name");
        String checkString = "SELECT COUNT(*) FROM Item WHERE name = ?";
        PreparedStatement checkForExistingItem = con.prepareStatement(checkString);
        checkForExistingItem.setString(1, name);
        ResultSet rs = checkForExistingItem.executeQuery();

        rs.next();
        if (rs.getInt(1) >= 1) {
            out.println("This item already exists!");
            return;
        }

        // Add the new item to the Items Table
        String insertString = "INSERT INTO Item (name, manfID, servingSize, cal, sugar, color, price, stockNum) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        PreparedStatement pstatement = con.prepareStatement(insertString);
        pstatement.setString(1, request.getParameter("name"));
        pstatement.setInt(2, Integer.parseInt(request.getParameter("itemManf")));
        pstatement.setInt(3, Integer.parseInt(request.getParameter("servingSize")));
        pstatement.setInt(4, Integer.parseInt(request.getParameter("calories")));
        pstatement.setInt(5, Integer.parseInt(request.getParameter("sugar")));
        pstatement.setString(6, request.getParameter("color"));
        pstatement.setDouble(7, Double.parseDouble(request.getParameter("price")));
        pstatement.setInt(8, Integer.parseInt(request.getParameter("stockNum")));

        updateQuery = pstatement.executeUpdate();
//        if (name != null) {
//            int queryResult = pstatement.executeUpdate();
//
//            if (queryResult != 0) {
//                out.println("Successfully added item: " + name);
//
//                String redirectPage = "add_item.jsp";
//                RequestDispatcher dd = request.getRequestDispatcher(redirectPage);
//                dd.forward(request, response);
//            }
//        }


%>
<div class="reg-header">
    <h1>Inventory Manager</h1>
    <h2>Item added successfully!<br>
<%--        <%out.println(firstName + " " + lastName + "!");%>--%>
    </h2>
<%--    <h3>Your Admin ID:--%>
<%--        <%out.println(adminID); %>--%>
<%--    </h3>--%>
    <div class="reg-button-container">
        <button>
            <a href="add_item.jsp?FirstName=<%=firstName%>&LastName=<%=lastName%>">Add another item</a>
        </button>
    </div>

</div>
<%
        //        rs.close();
//        stmt.close();
        con.close();
    } catch(SQLException e) {
        out.println("SQLException caught: " + e.getMessage());
    }
%>
</body>
</html>
