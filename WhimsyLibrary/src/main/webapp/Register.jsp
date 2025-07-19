<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Join LibraryThing</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f7f7f7;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
    }

    .form-container {
      background-color: #fdfaf7;
      padding: 30px;
      border: 1px solid #ddd;
      border-radius: 8px;
      width: 400px;
    }

    label {
      display: block;
      margin-bottom: 5px;
      font-weight: bold;
    }

    input[type="text"],
    input[type="email"],
    input[type="password"],
    select {
      width: 100%;
      padding: 10px;
      margin-bottom: 15px;
      border: 1px solid #ccc;
      border-radius: 4px;
    }

    .password-strength {
      display: flex;
      align-items: center;
      font-size: 12px;
      color: #666;
      margin-top: -10px;
      margin-bottom: 10px;
    }

    .bar {
      height: 5px;
      width: 25%;
      background-color: #ddd;
      margin-right: 3px;
      border-radius: 2px;
    }

    .submit-btn {
      width: 100%;
      padding: 12px;
      background-color: #a23c3c;
      color: white;
      border: none;
      border-radius: 4px;
      font-size: 16px;
      cursor: pointer;
    }

    .or-join {
      text-align: center;
      margin: 20px 0 10px;
      color: #666;
    }

    .facebook-join {
      display: flex;
      justify-content: center;
      align-items: center;
      gap: 5px;
      color: #3b5998;
      font-size: 14px;
      cursor: pointer;
    }

    .facebook-join img {
      width: 16px;
      height: 16px;
    }
  </style>
</head>
<body>
  <div class="form-container">
    <form>
      <label for="username">Username</label>
      <input type="text" id="username" name="username" />

      <label for="password">Password</label>
      <input type="password" id="password" name="password" />

      <div class="password-strength">
        <div class="bar"></div>
        <div class="bar"></div>
        <div class="bar"></div>
        <span style="margin-left: 8px;">password strength</span>
      </div>

      <label for="confirm">Confirm Password</label>
      <input type="password" id="confirm" name="confirm" />

      <label for="email">Email</label>
      <input type="email" id="email" name="email" />

      <label for="type">Type</label>
      <select id="type" name="type">
        <option value="personal">personal</option>
        <option value="organization">organization</option>
      </select>

      <button type="submit" class="submit-btn">Join Whimsigirl Library</button>

    </form>
  </div>
</body>
</html>>