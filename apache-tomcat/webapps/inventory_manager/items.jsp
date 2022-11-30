<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Inventory Manager | Get All Items</title>
</head>

<%
    // If a user is not logged in and tries to go to "items.jsp", redirect to login
    String firstName = (String) session.getAttribute("FirstName");
    if (firstName == null) {
        System.out.println("Current user is ¡not logged in and is trying to go to 'Home.jsp'");
        session.setAttribute("errorMessage", "Not logged in!");
        response.sendRedirect("login.jsp");
    }
%>

<body>
    <h1>All Items</h1>
    <c:forEach items="${items}" var="item" >
        <tr>
            <td>Name: ${item[0]}</td><br />
            <td>Serving Size: ${item[1]}</td><br />
            <td>Calories: ${item[2]}</td><br />
            <td>Sugar: ${item[3]}</td><br />
            <td>Color: ${item[4]}</td><br />
            <td>Price: ${item[5]}</td><br />
            <td>Stock Number: ${item[6]}</td><br />
            -------------------<br />
        </tr>
        <br />
    </c:forEach>
</body>
</html>
