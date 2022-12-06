<html>
<head>
    <title>Inventory Manager</title>
    <style><%@include file="/css/add.css"%></style>
</head>
<body>
    <h1>Employee Home</h1>

    <%
        String firstName = request.getParameter("FirstName");
        String lastName = request.getParameter("FirstName");
    %>

    <h1>
        <%out.println(firstName + " " + lastName + "'s ");%>
        Admin Home
    </h1>

    <a href="itemsEmp.jsp?FirstName=<%=firstName%>&LastName=<%=lastName%>">
        <h2>Show All Items</h2>
    </a>
	
	<a href="sortCatEmp.jsp">
        <h2>Sort by Category</h2>
    </a>

    <a href="Home.jsp">
        <h2>Log Out</h2>
    </a>
</body>
</html>