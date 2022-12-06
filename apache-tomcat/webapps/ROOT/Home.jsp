<%@ page import="java.sql.*"%>
<html>
<head>
    <title>Home Page</title>
    <style><%@include file="/css/style.css"%></style>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
</head>
<body>
    <div class="text-container">
        <h1>Inventory Manager</h1>

        <a href="login.jsp">
            <h2>Login</h2>
        </a>
        <div class="register-container">
            <a href="register_adminusers.jsp">
                <h2>Register New Admin User</h2>
            </a>
            <a href="register_empusers.jsp">
                <h2>Register New Employee User</h2>
            </a>
        </div>

<%--        <a href="add_store.jsp">--%>
<%--            <h2>Add Store</h2>--%>
<%--        </a>--%>
    </div>



</body>
</html>
