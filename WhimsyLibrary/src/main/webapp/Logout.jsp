<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Logout</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f4f4f4;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
    }
    .logout-container {
      background-color: white;
      padding: 30px;
      border: 1px solid #ddd;
      border-radius: 8px;
      width: 300px;
      text-align: center;
    }
    .logout-container h2 {
      margin-bottom: 20px;
      color: #333;
    }
    .button-group {
      display: flex;
      justify-content: space-between;
      gap: 10px;
    }
    .logout-btn,
    .cancel-btn {
      flex: 1;
      padding: 10px;
      border: none;
      border-radius: 4px;
      font-size: 16px;
      cursor: pointer;
    }
    .logout-btn {
      background-color: #a23c3c;
      color: white;
    }
    .logout-btn:hover {
      background-color: #811f1f;
    }
    .cancel-btn {
      background-color: #6c757d;
      color: white;
    }
    .cancel-btn:hover {
      background-color: #5a6268;
    }
  </style>
</head>
<body>
  <div class="logout-container">
    <h2>Are you sure you want to log out?</h2>
    <form action="LogoutServlet" method="post">
      <div class="button-group">
        <button type="submit" class="logout-btn">Yes</button>
        <button type="button" class="cancel-btn" onclick="window.history.back()">No</button>
      </div>
    </form>
  </div>
</body>
</html>
