<html>
<head>
    <title>Inventory Manager | Register Employee</title>
</head>
<body>
<h1>Register Employee</h1>

<form action="${pageContext.request.contextPath}/registerEmployee" method="post">
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

    <tr>
        <th>Admin ID</th>
        <td><input type="text" name="adminID"></td>
    </tr>

    <button type="submit" id="submitButton">Submit</button>
</form>
</body>
</html>
