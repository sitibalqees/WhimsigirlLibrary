<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Login Page</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f4f4f4;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
    }
    .login-container {
      background-color: white;
      padding: 30px;
      border: 1px solid #ddd;
      border-radius: 8px;
      width: 350px;
    }
    .login-container h2 {
      text-align: center;
      margin-bottom: 20px;
    }
    label {
      display: block;
      margin-bottom: 5px;
      font-weight: bold;
    }
    input[type="text"],
    input[type="password"] {
      width: 100%;
      padding: 10px;
      margin-bottom: 15px;
      border: 1px solid #ccc;
      border-radius: 4px;
    }
    .role-group {
      margin-bottom: 15px;
      display: flex;
      gap: 20px;
      align-items: center;
    }
    .role-group label {
      font-weight: normal;
      margin-bottom: 0;
    }
    .sign-in-btn {
      width: 100%;
      padding: 10px;
      background-color: #a23c3c;
      color: white;
      border: none;
      border-radius: 4px;
      font-size: 16px;
      cursor: pointer;
    }
    .forgot-link, .register-link {
      display: block;
      text-align: center;
      margin-top: 10px;
      font-size: 14px;
      color: #007bff;
      text-decoration: none;
    }
    .forgot-link:hover, .register-link:hover {
      text-decoration: underline;
    }
    .error-message {
      color: red;
      text-align: center;
      margin-bottom: 10px;
    }
  </style>
</head>
<body>
  <div class="login-container">
    <h2>Login</h2>
    <form action="LoginController" method="post">
     <div class="role-group">
        <span style="font-weight:bold;">Login as:</span>
        <input type="radio" id="user" name="role" value="user" checked>
        <label for="user">User</label>
        <input type="radio" id="admin" name="role" value="admin">
        <label for="admin">Admin</label>
      </div>
    
      <label for="email">Email</label>
      <input type="text" id="email" name="email" required />

      <label for="password">Password</label>
      <input type="password" id="password" name="password" required />

  
      <button type="submit" class="sign-in-btn">Sign In</button>

      <a href="#" class="forgot-link">Forgot username or password?</a>
      <a href="Register.jsp" class="register-link">Not registered? Register here</a>
    </form>
    <%
      String errorMessage = (String) request.getAttribute("errorMessage");
      if (errorMessage != null) {
    %>
      <div class="error-message"><%= errorMessage %></div>
    <%
      }
    %>
  </div>
</body>
</html>