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
    .or-signin {
      text-align: center;
      margin: 20px 0 10px;
      color: #666;
    }
    .facebook-signin {
      display: flex;
      justify-content: center;
      align-items: center;
      gap: 5px;
      color: #3b5998;
      cursor: pointer;
      font-size: 14px;
    }
    .facebook-signin img {
      width: 16px;
      height: 16px;
    }
    .forgot-link {
      display: block;
      text-align: center;
      margin-top: 10px;
      font-size: 14px;
      color: #007bff;
      text-decoration: none;
    }
    .forgot-link:hover {
      text-decoration: underline;
    }
  </style>
</head>
<body>
  <div class="login-container">
    <form>
      <label for="username">Username</label>
      <input type="text" id="username" name="username" />

      <label for="password">Password</label>
      <input type="password" id="password" name="password" />

      <button type="submit" class="sign-in-btn">Sign In</button>

 
      <a href="#" class="forgot-link">Forgot username or password?</a>
    </form>
  </div>
</body>
</html>