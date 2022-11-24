<%@ page import="java.sql.*"%>

<html>
  <head>
    <title>Inventory Manager | Login</title>
    </head>
  <body>
    <h1>Inventory Manager</h1>
	<h2>Login</h2>
    
     <div class="login-body">
        <form action="${pageContext.request.contextPath}/login" method="post">
            <div class="login-input-container">
                <label>First Name</label>
                <input name="FirstName" />
            </div>
            <div class="login-input-container">
                <label>Last Name</label>
                <input name="LastName" />
            </div>
            <div class="login-input-container">
                <label>Phone Number</label>
                <input name="phoneNumber" />
            </div>
            <div class="login-button-container">
                <button>Login</button>
            </div>
        </form>
    </div>
  </body>
</html>
