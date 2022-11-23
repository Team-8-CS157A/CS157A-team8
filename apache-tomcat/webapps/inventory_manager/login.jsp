<%@ page import="java.sql.*"%>

<html>
  <head>
    <title>Inventory Manager | Login</title>
    </head>
  <body>
    <h1>Inventory Manager</h1>
	<h2>Login</h2>
    
     <div class="login-body">
        <form action="${pageContext.request.contextPath}/userActions" method="post">
            <div class="login-input-container">
                <label for="">Username</label>
                <input placeholder = "username" NAME = "usernameLogin" type="text" />
            </div>
            <div class="login-input-container">
                <label for="">Password</label>
                <input placeholder = "password" NAME = "passwordLogin "type="password" />
            </div>
            <div class="login-button-container">
                <button>Login</button>
            </div>
        </form>
    </div>
  </body>
</html>
