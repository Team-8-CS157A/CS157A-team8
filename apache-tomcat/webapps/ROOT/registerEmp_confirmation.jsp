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
    String password = "root";


    // Gets information from the HTML file above
    String firstName = request.getParameter("firstNameempR");
    String lastName = request.getParameter("lastNameempR");
    String phoneNum = request.getParameter("phoneNumempR");
    Random randID = new Random();       // generate random number up to 1000
    int userID = randID.nextInt(1000); // use randID to generate random adminID
    int storeID = Integer.parseInt(request.getParameter("store"));
    int adminID = Integer.parseInt(request.getParameter("admin"));

    // Stuff in order to insert
    PreparedStatement pstatement = null;
    PreparedStatement usersPstatement = null;

    int updateQuery = 0;

    try {

        // Gets database connection + JDBC driver
        java.sql.Connection con;
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/inventory_manager?autoReconnect=true&useSSL=false",user, password);
        out.println(db + " database successfully opened.<br/><br/>");

        // String SQL insert statement, should correspond to table information in database
        String queryStringEmpTable = "insert into emp_users(empUserID,FirstName,LastName,phoneNumber,storeID, adminID) values(?,?,?,?,?,?)";
        String queryStringUsersTable = "insert into Users(userID,FirstName,LastName,phoneNumber, storeID) values(?,?,?,?,?)";

        pstatement = con.prepareStatement(queryStringEmpTable);
        usersPstatement = con.prepareStatement(queryStringUsersTable);
        // Sets the query info to variables that you get in HTML file

        pstatement.setInt(1, userID);
        pstatement.setString(2, firstName);
        pstatement.setString(3, lastName);
        pstatement.setString(4, phoneNum);
        pstatement.setInt(5, storeID);
        pstatement.setInt(6, adminID);

        usersPstatement.setInt(1, userID);
        usersPstatement.setString(2, firstName);
        usersPstatement.setString(3, lastName);
        usersPstatement.setString(4, phoneNum);
        usersPstatement.setInt(5, storeID);

        updateQuery = pstatement.executeUpdate();
        updateQuery = usersPstatement.executeUpdate();



        // Teacher's code to print out enteries in database
//        out.println("Initial entries in table \"adminusers\": <br/>");
//        Statement stmt = con.createStatement();
//        Statement storeStmt = con.createStatement();
//        ResultSet rs = stmt.executeQuery("SELECT * FROM adminusers;");
//        ResultSet storeRS = storeStmt.executeQuery("Select * FROM store;");

%>
<div class="reg-header">
    <h1>Inventory Manager</h1>
    <h2>Thank you for registering as an employee,<br>
        <%out.println(firstName + " " + lastName + "!");%>
    </h2>
    <h3>Your Employee ID:
        <%out.println(userID); %>
    </h3>
    <div class="reg-button-container">
        <button>
            <a href="login.jsp">Log in</a>
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
