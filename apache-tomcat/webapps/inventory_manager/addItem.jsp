<html>
<head>
    <title>Inventory Manager | Add Item</title>
</head>

<%
    // If a user is not logged in and tries to go to "addItem.jsp", redirect to login
    String firstName = (String) session.getAttribute("FirstName");
    if (firstName == null) {
        System.out.println("Current user is not logged in and is trying to go to 'Home.jsp'");
        session.setAttribute("errorMessage", "Not logged in!");
        response.sendRedirect("login.jsp");
    }
%>

<body>
<h1>Add Item</h1>

<form action="${pageContext.request.contextPath}/addItem" method="post">
    <tr>
        <th>Name</th>
        <td><input type="text" name="name"></td>
    </tr>

    <tr>
        <th>Serving Size (g)</th>
        <td><input type="text" name="servingSize"></td>
    </tr>

    <tr>
        <th>Calories</th>
        <td><input type="text" name="calories"></td>
    </tr>

    <tr>
        <th>Sugar</th>
        <td><input type="text" name="sugar"></td>
    </tr>

    <tr>
        <th>Color</th>
        <td><input type="text" name="color"></td>
    </tr>

    <tr>
        <th>Price</th>
        <td><input type="text" name="price"></td>
    </tr>

    <tr>
        <th>Stock Num</th>
        <td><input type="text" name="stockNum"></td>
    </tr>

    <button type="submit" id="submitButton">Add Item</button>
</form>
</body>
</html>
