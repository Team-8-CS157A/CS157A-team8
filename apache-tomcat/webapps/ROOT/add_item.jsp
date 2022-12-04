<%@ page import="java.sql.*"%>
<%@ page import="jakarta.servlet.RequestDispatcher" %>
<html>
<head>
    <title>Inventory Manager</title>
    <style><%@include file="/css/add.css"%></style>
</head>
<body>
<div class="add-header">
    <h1>Inventory Manager</h1>
    <h2>Add Item</h2>

    <div class="add-body">
        <form action="">
            <div class="add-input-container">
                <label for="">Name</label>
                <input name="name" type="text" />
            </div>
            <div class="add-input-container">
                <label for="">Serving Size</label>
                <input name="servingSize" type="number" />
            </div>
            <div class="add-input-container">
                <label for="">Calories</label>
                <input name="calories" type="number" />
            </div>
            <div class="add-input-container">
                <label for="">Sugar</label>
                <input name="sugar" type="number" />
            </div>
            <div class="add-input-container">
                <label for="">Color</label>
                <input name="color" type="text" />
            </div>
            <div class="add-input-container">
                <label for="">Price</label>
                <input name="price" type="number" step="any" />
            </div>
            <div class="add-input-container">
                <label for="">Stock Num</label>
                <input name="stockNum" type="number" />
            </div>

            <div class="add-button-container">
                <button>Add Item</button>
            </div>
        </form>

        <div class="add-button-container">
            <a href="adminHome.jsp">
                <button>Back Home</button>
            </a>
        </div>
    </div>
</div>
<%
    // Database info
    String db = "inventory_manager";
    String user; // assumes database name is the same as username
    user = "root";
    String password = "root";

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

        // Check to see if the item already exists in the table, if so do not add
        String checkString = "SELECT COUNT(*) FROM Item WHERE name = ?";
        PreparedStatement checkForExistingItem = con.prepareStatement(checkString);
        checkForExistingItem.setString(1, name);
        ResultSet rs = checkForExistingItem.executeQuery();
        rs.next();
        if (rs.getInt(1) >= 1) {
            System.out.println("This item already exists!");
            return;
        }

        // Add the new item to the Items Table
        String insertString = "INSERT INTO Item (name, servingSize, cal, sugar, color, price, stockNum) VALUES (?, ?, ?, ?, ?, ?, ?)";

        PreparedStatement pstatement = con.prepareStatement(insertString);
        pstatement.setString(7, name);
        pstatement.setInt(1, Integer.parseInt(request.getParameter("servingSize")));
        pstatement.setInt(2, Integer.parseInt(request.getParameter("calories")));
        pstatement.setInt(3, Integer.parseInt(request.getParameter("sugar")));
        pstatement.setString(4, request.getParameter("color"));
        pstatement.setDouble(5, Double.parseDouble(request.getParameter("price")));
        pstatement.setInt(6, Integer.parseInt(request.getParameter("stockNum")));

        if (name != null) {
            int queryResult = pstatement.executeUpdate();

            if (queryResult != 0) {
                System.out.println("Successfully added item: " + name);

                String redirectPage = "add_item.jsp";
                RequestDispatcher dd = request.getRequestDispatcher(redirectPage);
                dd.forward(request, response);
            }
        }

        con.close();
    } catch(SQLException e) {
        out.println("SQLException caught: " + e.getMessage());
    }
%>
</body>
</html>
