<html>
<head>
    <title>Inventory Manager | Register Admin</title>
</head>
<body>
<h1>Register Admin</h1>

<form action="${pageContext.request.contextPath}/registerAdmin" method="post">
    <tr>
        <th>First Name</th>
        <td><input type="text" name="FirstName"></td>
    </tr>

    <tr>
        <th>Last Name</th>
        <td><input type="text" name="LastName"></td>
    </tr>

    <tr>
        <th>Phone Number</th>
        <td><input type="text" name="phoneNumber"></td>
    </tr>

    <tr>
        <th>Store ID</th>
        <td><input type="text" name="storeID"></td>
    </tr>

    <button type="submit" id="submitButton">Submit</button>
</form>
</body>
</html>
