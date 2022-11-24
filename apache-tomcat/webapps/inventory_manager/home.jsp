<html>
<head>
    <title>Inventory Manager | Home</title>
</head>

<%
    // If a user is not logged in and tries to go to "home.jsp", redirect to login
//    String firstName = currentUser.getFirstName();
//    if (firstName == null) {
//        response.sendRedirect("login.jsp");
//    }

    String firstName = (String) session.getAttribute("FirstName");
    if (firstName == null) {
        System.out.println("Current user is not logged in and is trying to go to 'Home.jsp'");
        session.setAttribute("errorMessage", "Not logged in!");
        response.sendRedirect("login.jsp");
    }
%>

<body>
<h1>Inventory Manager</h1>

<div class="login-body">
    <h1>HOME</h1>

    <input type="text" value="Welcome, <%= session.getAttribute("FirstName") %>">

    <form action="${pageContext.request.contextPath}/logout" method="post">
        <button>logout</button>
    </form>
</div>
</body>
</html>
