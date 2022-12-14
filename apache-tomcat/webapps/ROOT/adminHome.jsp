<%@ page import="java.sql.*"%>
<%@page import="java.util.*" %>
<html>
<head>
    <title>Inventory Manager</title>
    <style><%@include file="/css/adminHome.css"%></style>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
</head>
<body>
<%
    String db = "inventory_manager";
    String user; // assumes database name is the same as username
    user = "root";
    String password = "rootpass";

    try {
        // Gets database connection + JDBC driver
        java.sql.Connection con;
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/inventory_manager?autoReconnect=true&useSSL=false", user, password);

        String firstName = request.getParameter("FirstName");
        String lastName = request.getParameter("LastName");

        PreparedStatement pstatement = con.prepareStatement("SELECT AdminID from AdminUsers WHERE FirstName = '" + firstName + "' AND LastName = '" + lastName + "';");
        ResultSet rs = pstatement.executeQuery();
        rs.next();
        int adminID = rs.getInt(1);
%>
    <%-- Might remove later because it re-renders as "null null"
    after returning from add_item.jsp or itemsAdmin.jsp --%>
    <h1>
        <%out.println(firstName + " " + lastName + "'s ");%>
        Admin Home
    </h1>

    <a href="add_item.jsp?FirstName=<%=firstName%>&LastName=<%=lastName%>">
        <h2>Add Item</h2>
    </a>

    <a href="itemsAdmin.jsp?FirstName=<%=firstName%>&LastName=<%=lastName%>">
        <h2>Show All Items</h2>
    </a>
	
    <a href="update_inventory.jsp?FirstName=<%=firstName%>&LastName=<%=lastName%>">
        <h2>Update Inventory</h2>
    </a>

    <a href="remove_item.jsp?FirstName=<%=firstName%>&LastName=<%=lastName%>">
        <h2>Remove Item</h2>
    </a>
	
	<a href="sortCatAdm.jsp?FirstName=<%=firstName%>&LastName=<%=lastName%>">
        <h2>Sort by Category</h2>
    </a>
	
	<a href="showEmpAdmin.jsp?FirstName=<%=firstName%>&LastName=<%=lastName%>&AdminID=<%=adminID%>">
        <h2>Show Employees</h2>
    </a>

	<a href="add_manufactors.jsp?FirstName=<%=firstName%>&LastName=<%=lastName%>">
        <h2>Add Manufacturers</h2>
    </a>
	
	<a href="add_store.jsp?FirstName=<%=firstName%>&LastName=<%=lastName%>">
        <h2>Add Store</h2>
    </a>

    <a href="Home.jsp">
        <h2>Log Out</h2>
    </a>
<%
        con.close();
    } catch(SQLException e) {
        out.println("SQLException caught: " + e.getMessage());
    }
%>
</body>
</html>