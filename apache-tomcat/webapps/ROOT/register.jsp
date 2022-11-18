<%@ page import="java.sql.*"%>
<%@ page import="javax.swing.JOptionPane"%>

<html>
  <head>
    <title>Inventory Manager | Register</title>
    </head>
  <body>
    <h1>Register</h1>

    <form action="${pageContext.request.contextPath}/registerSubmit" method="post">
      <tr>
        <th>Name</th>
        <td><input type="text" name="name"></td>
      </tr>

      <tr>
        <th>Username</th>
        <td><input type="text" name="username"></td>
      </tr>

      <tr>
        <th>Password</th>
        <td><input type="text" name="password"></td>
      </tr>

      <button type="submit" id="submitButton">Submit</button>
    </form>
  </body>
</html>
