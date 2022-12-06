<%@ page import="java.sql.*"%>
<html>
<head>
    <title>Individual Item Page</title>
    <style><%@include file="/css/items.css"%></style>
    <style><%@include file="/css/add.css"%></style>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
</head>

<body>
    <input type="hidden" name="name" value="${name}">

    <h1>Inventory Manager</h1>

    <table id="itemsTable" style="width: 100%">
        <tr>
            <th>Name</th>
            <th>Serving Size</th>
            <th>Calories</th>
            <th>Sugar</th>
            <th>Color</th>
            <th>Price</th>
            <th>Stock Number</th>
        </tr>

        <%
            // Database info
            String db = "inventory_manager";
            String user; // assumes database name is the same as username
            user = "root";
            String password = "root";

            String name = request.getParameter("name");
            String firstName = request.getParameter("FirstName");
            String lastName = request.getParameter("LastName");

            try {

                // Gets database connection + JDBC driver
                java.sql.Connection con;
                Class.forName("com.mysql.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/inventory_manager?autoReconnect=true&useSSL=false",user, password);

                // Teacher's code to print out enteries in database
                String selectQuery = "SELECT * FROM Item WHERE name = ?";
                PreparedStatement pstatement = con.prepareStatement(selectQuery);
                pstatement.setString(1, name);
                ResultSet rs = pstatement.executeQuery();
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
                con.close();
            } catch(SQLException e) {
                out.println("SQLException caught: " + e.getMessage());
            }

        %>
    </table>

    <div class="add-button-container">
        <%
            String userType = request.getParameter("Type");
            String linkStart;
            if (userType.equals("Admin")) {
                linkStart = "itemsAdmin.jsp";
            } else {
                linkStart = "itemsEmp.jsp";
            }
        %>
        <a href="<%=linkStart%>?FirstName=<%=firstName%>&LastName=<%=lastName%>">
            <button>Back To Items</button>
        </a>
    </div>

</body>

</html>