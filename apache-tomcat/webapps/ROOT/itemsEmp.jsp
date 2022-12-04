<%@ page import="java.sql.*"%>
<html>
<head>
    <title>Items Page</title>
    <style><%@include file="/css/items.css"%></style>
    <style><%@include file="/css/add.css"%></style>
</head>
<body>
    <h1>Inventory Manager Application</h1>

    <table id="itemsTable" style="width: 100%">
        <tr>
            <td>Name</td>
            <td>Serving Size</td>
            <td>Calories</td>
            <td>Sugar</td>
            <td>Color</td>
            <td>Price</td>
            <td>Stock Number</td>
        </tr>

        <%
            // Database info
            String db = "inventory_manager";
            String user; // assumes database name is the same as username
            user = "root";
            String password = "root";

            try {

                // Gets database connection + JDBC driver
                java.sql.Connection con;
                Class.forName("com.mysql.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/inventory_manager?autoReconnect=true&useSSL=false",user, password);

                // Teacher's code to print out enteries in database
                Statement stmt = con.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT * FROM Item");
                while (rs.next()) {
                    // HTML code is within the while loop below
                    // SQL errors when having rs.getInt() or rs.getDouble()
                    // so I used rs.getString() instead, displays fine
        %>
        <tr>
            <td> <%= rs.getString(1) %> </td>
            <td> <%= rs.getString(2) %> </td>
            <td> <%= rs.getString(3) %> </td>
            <td> <%= rs.getString(4) %> </td>
            <td> <%= rs.getString(5) %> </td>
            <td> <%= rs.getString(6) %> </td>
            <td> <%= rs.getString(7) %> </td>
        </tr>
        <%
                }

                rs.close();
                stmt.close();
                con.close();
            } catch(SQLException e) {
                out.println("SQLException caught: " + e.getMessage());
            }

        %>
    </table>

    <div class="add-button-container">
        <a href="empHome.jsp">
            <button>Back Home</button>
        </a>
    </div>

</body>
</html>
