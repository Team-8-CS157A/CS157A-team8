<%@ page import="java.util.ArrayList" %>

<html>
<head>
    <title>Inventory Manager | Get All Items</title>
</head>

<%
    // If a user is not logged in and tries to go to "items.jsp", redirect to login
    String firstName = (String) session.getAttribute("FirstName");
    if (firstName == null) {
        System.out.println("Current user is not logged in and is trying to go to 'Home.jsp'");
        session.setAttribute("errorMessage", "Not logged in!");
        response.sendRedirect("login.jsp");
    }

    try {
        System.out.println("user is logged in");
        ArrayList<String[]> items = (ArrayList<String[]>) request.getSession().getAttribute("items");
        for (String[] str : items) {
            System.out.println("----");
            for (int i = 0; i < 7; i++) {
                System.out.println(str[i]);
            }
        }
    } catch (Exception e) {
        System.out.print("exception with items.jsp");
        System.out.println(e);
    }
%>

<body>
    <h1>All Item</h1>
    ${items}
    <c:forEach items="${items}" var="item" >
        <tr>
            <td>${item.name}</td>
            <td>${item.servingSize}</td>
            <td>${item.cal}</td>
            <td>${item.sugar}</td>
            <td>${item.color}</td>
            <td>${item.price}</td>
            <td>${item.stockNum}</td>
        </tr>
        <br />
        -------------------
    </c:forEach>
</body>
</html>
