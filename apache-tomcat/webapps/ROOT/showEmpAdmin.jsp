<%@ page import="java.sql.*"%>
<html>
<head>
    <title>Items Page</title>
    <style><%@include file="/css/items.css"%></style>
    <style><%@include file="/css/add.css"%></style>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
</head>
</head>
<body>
    <h1>Inventory Manager</h1>
    <h2> Employees</h2>

    <table id="itemsTable" style="width: 50%">
        <thead>
            <td>Full Name</td>
            <td>Phone Number</td>
        </thead>

        <%
            // Database info
            String db = "inventory_manager";
            String user; // assumes database name is the same as username
            user = "root";
            String password = "rootpass";

            String firstName = request.getParameter("FirstName");
            String lastName = request.getParameter("LastName");
            String adminID = request.getParameter("AdminID");

            try {

                // Gets database connection + JDBC driver
                java.sql.Connection con;
                Class.forName("com.mysql.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/inventory_manager?autoReconnect=true&useSSL=false",user, password);

                // Teacher's code to print out enteries in database
                Statement stmt = con.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT * FROM Emp_Users WHERE adminID=" + adminID + ";");
                while (rs.next()) {
                    // HTML code is within the while loop below
                    // SQL errors when having rs.getInt() or rs.getDouble()
                    // so I used rs.getString() instead, displays fine
        %>
                    <tr>
                        <td> <%= rs.getString(2) + " " + rs.getString(3)%></td> <%-- First and last name --%>
                        <td> <%= rs.getString(4) %> </td> <%-- Phone Num --%>
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
        <a href="adminHome.jsp?FirstName=<%=firstName%>&LastName=<%=lastName%>">
            <button>Back to Admin Home</button>
        </a>
    </div>

</body>
</html>
