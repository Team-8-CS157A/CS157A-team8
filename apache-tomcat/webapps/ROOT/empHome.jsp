<html>
<head>
    <title>Inventory Manager</title>
    <style><%@include file="/css/adminHome.css"%></style>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
</head>
<body>
    <h1>Employee Home</h1>

    <%
        String firstName = request.getParameter("FirstName");
        String lastName = request.getParameter("LastName");
    %>

    <h1>
        <%out.println(firstName + " " + lastName + "'s ");%>
        Admin Home
    </h1>

    <a href="itemsEmp.jsp?FirstName=<%=firstName%>&LastName=<%=lastName%>">
        <h2>Show All Items</h2>
    </a>
	
	<a href="sortCatEmp.jsp?FirstName=<%=firstName%>&LastName=<%=lastName%>">
        <h2>Sort by Category</h2>
    </a>

    <a href="Home.jsp">
        <h2>Log Out</h2>
    </a>
</body>
</html>