<%@ page import="java.sql.*"%>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.LinkedHashMap" %>
<html>
<head>
    <title>Inventory Manager - Sort By Category</title>
    <style><%@include file="/css/items.css"%></style>
    <style><%@include file="/css/add.css"%></style>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
</head>
<body>
    <h1>Inventory Manager Application - Sort By Category</h1>

    <table id="itemsTable" style="width: 80%">
        <tr>
            <th>Name</th>
            <td>Serving Size</td>
            <td>Calories</td>
            <td>Sugar</td>
            <td>Color</td>
            <td>Price</td>
            <th>Stock Number</th>
        </tr>

        <%
            String category = request.getParameter("Category");
            String query;
            if (category == null || category.isEmpty()) {
                query = "SELECT * FROM Item";
            } else {
                query = "SELECT * FROM Item ORDER BY " + category + " ASC";
            }

             // Database info
             String db = "inventory_manager";
             String user; // assumes database name is the same as username
             user = "root";
             String password = "rootpass";

             String firstName = request.getParameter("FirstName");
             String lastName = request.getParameter("LastName");

             try {

                 // Gets database connection + JDBC driver
                 java.sql.Connection con;
                 Class.forName("com.mysql.jdbc.Driver");
                 con = DriverManager.getConnection("jdbc:mysql://localhost:3306/inventory_manager?autoReconnect=true&useSSL=false",user, password);

                 // Teacher's code to print out enteries in database
                 Statement stmt = con.createStatement();
                 ResultSet rs = stmt.executeQuery(query);
                 while (rs.next()) {
                     // HTML code is within the while loop below
                     // SQL errors when having rs.getInt() or rs.getDouble()
                     // so I used rs.getString() instead, displays fine
        %>
                     <tr>
                         <td> <%= rs.getString(1) %> </td> <%-- Name --%>
                         <td> <%= rs.getString(3) %> </td> <%-- Serving Size --%>
                         <td> <%= rs.getString(4) %> </td> <%-- Calories --%>
                         <td> <%= rs.getString(5) %> </td> <%-- Sugar --%>
                         <td> <%= rs.getString(6) %> </td> <%-- Color --%>
                         <td> <%= rs.getString(7) %> </td> <%-- Price --%>
                         <td> <%= rs.getString(8) %> </td> <%-- Stock Num --%>
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

    <div style="display: flex; justify-content: space-evenly">
        <%
            // Key = Button Name
            // Value = Link passed attribute value
            HashMap<String, String> categories = new LinkedHashMap<>(); // Maintain order inserted
            categories.put("Name", "name");
            categories.put("Serving Size", "servingSize");
            categories.put("Calories", "cal");
            categories.put("Sugar", "sugar");
            categories.put("Color", "color");
            categories.put("Price", "price");
            categories.put("Stock Number", "stockNum");

            for (Map.Entry<String, String> catType : categories.entrySet()) {
        %>
                <div class="add-button-container">
                    <a href="sortCatAdm.jsp?Category=<%=catType.getValue()%>">
                        <button><%=catType.getKey()%></button>
                    </a>
                </div>
        <%
            }
        %>
    </div>

    <div class="add-button-container">
        <a href="adminHome.jsp?FirstName=<%=firstName%>&LastName=<%=lastName%>">
            <button>Back to Admin Home</button>
        </a>
    </div>

</body>
</html>