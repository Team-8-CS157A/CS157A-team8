<%@ page import="java.sql.*"%>
<html>
<head>
    <title>Inventory Manager</title>
    <style><%@include file="/css/add.css"%></style>
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

//    String name = request.getParameter("name");
    String firstName = request.getParameter("FirstName");
    String lastName = request.getParameter("LastName");

    try {

        // Gets database connection + JDBC driver
        java.sql.Connection con;
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/inventory_manager?autoReconnect=true&useSSL=false",user, password);
//          out.println(db + " database successfully opened.<br/><br/>");

        Statement itemStmt = con.createStatement();
        ResultSet itemRS = itemStmt.executeQuery("Select * FROM manufacturer;");
    %>
<div class="add-header">
    <h1>Inventory Manager</h1>
    <h2>Add Item</h2>
    <div class="add-body">
        <form action="add_item_confirmation.jsp?FirstName=<%=firstName%>&LastName=<%=lastName%>">
            <div class="add-input-container">
                <label for="">Name</label>
                <input placeholder="Name" name="name" type="text" />
            </div>
            <div class="add-input-container">
                <label for="">Manufacturer</label>
                <select name="itemManf">
                    <option selected disabled>Choose manufacturer</option>
                    <%
                        while(itemRS.next()) {
                            String manfName = itemRS.getString("name");
                            String manfID = itemRS.getString("manfID");

                    %>
                    <%-- user sees the store name displayed, but the storeID is stored in DB--%>
                    <option value="<%=manfID %>"><%=manfName %></option>
                    <%

                        }
                    %>
                </select>
            </div>
            <div class="add-input-container">
                <label for="">Serving Size</label>
                <input placeholder="Serving Size" name="servingSize" type="number" />
            </div>
            <div class="add-input-container">
                <label for="">Calories</label>
                <input placeholder="Calories" name="calories" type="number" />
            </div>
            <div class="add-input-container">
                <label for="">Sugar</label>
                <input placeholder="Sugar" name="sugar" type="number" />
            </div>
            <div class="add-input-container">
                <label for="">Color</label>
                <input placeholder="Color" name="color" type="text" />
            </div>
            <div class="add-input-container">
                <label for="">Price</label>
                <input placeholder="Price" name="price" type="number" step="any" />
            </div>
            <div class="add-input-container">
                <label for="">Stock Number</label>
                <input placeholder="Stock Number" name="stockNum" type="number" />
            </div>

            <div class="add-button-container">
                <button>Add Item</button>
            </div>
        </form>

        <div class="add-button-container">
            <a href="adminHome.jsp?FirstName=<%=firstName%>&LastName=<%=lastName%>">
                <button>Back to Admin Home</button>
            </a>
        </div>
    </div>
</div>
<%
        itemRS.close();
//          stmt.close();
        con.close();
    } catch(SQLException e) {
        out.println("SQLException caught: " + e.getMessage());
    }
%>
<%--<%--%>

<%--    // Prevent below code from running on page render--%>
<%--    if (name == null) {--%>
<%--        return;--%>
<%--    }--%>

<%--    try {--%>

<%--        // Gets database connection + JDBC driver--%>
<%--        java.sql.Connection con;--%>
<%--        Class.forName("com.mysql.jdbc.Driver");--%>
<%--        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/inventory_manager?autoReconnect=true&useSSL=false",user, password);--%>
<%--        out.println(db + " database successfully opened.<br/><br/>");--%>

<%--        // Check to see if the item already exists in the table, if so do not add--%>
<%--        String checkString = "SELECT COUNT(*) FROM Item WHERE name = ?";--%>
<%--        PreparedStatement checkForExistingItem = con.prepareStatement(checkString);--%>
<%--        checkForExistingItem.setString(1, name);--%>
<%--        ResultSet rs = checkForExistingItem.executeQuery();--%>

<%--        rs.next();--%>
<%--        if (rs.getInt(1) >= 1) {--%>
<%--            out.println("This item already exists!");--%>
<%--            return;--%>
<%--        }--%>

<%--        // Add the new item to the Items Table--%>
<%--        String insertString = "INSERT INTO Item (name, manfID, servingSize, cal, sugar, color, price, stockNum) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";--%>

<%--        PreparedStatement pstatement = con.prepareStatement(insertString);--%>
<%--        pstatement.setString(1, name);--%>
<%--        pstatement.setInt(2, 1);--%>
<%--        pstatement.setInt(3, Integer.parseInt(request.getParameter("servingSize")));--%>
<%--        pstatement.setInt(4, Integer.parseInt(request.getParameter("calories")));--%>
<%--        pstatement.setInt(5, Integer.parseInt(request.getParameter("sugar")));--%>
<%--        pstatement.setString(6, request.getParameter("color"));--%>
<%--        pstatement.setDouble(7, Double.parseDouble(request.getParameter("price")));--%>
<%--        pstatement.setInt(8, Integer.parseInt(request.getParameter("stockNum")));--%>

<%--        if (name != null) {--%>
<%--            int queryResult = pstatement.executeUpdate();--%>

<%--            if (queryResult != 0) {--%>
<%--                out.println("Successfully added item: " + name);--%>

<%--                String redirectPage = "add_item.jsp";--%>
<%--                RequestDispatcher dd = request.getRequestDispatcher(redirectPage);--%>
<%--                dd.forward(request, response);--%>
<%--            }--%>
<%--        }--%>

<%--        con.close();--%>
<%--    } catch(SQLException e) {--%>
<%--        out.println("SQLException caught: " + e.getMessage());--%>
<%--    }--%>
<%--%>--%>
</body>
</html>
