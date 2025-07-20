<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pay Fine</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #e7d3d3;
            margin: 0;
        }
        .navbar {
            background-color: #3c0d0d;
            color: #fff;
            display: flex;
            align-items: center;
            padding: 10px 20px;
            height: 60px;
            justify-content: space-between;
        }
        .navbar .logo {
            display: flex;
            align-items: center;
        }
        .navbar .logo img {
            height: 36px;
            margin-right: 12px;
        }
        .navbar .title {
            font-size: 24px;
            font-weight: bold;
            margin-left: 10px;
        }
        .navbar .menu {
            display: flex;
            gap: 32px;
        }
        .navbar .menu a {
            color: #fff;
            text-decoration: none;
            font-size: 16px;
            font-weight: 500;
            transition: color 0.2s;
        }
        .navbar .menu a:hover, .navbar .menu a.active {
            color: #ffd7d7;
            text-decoration: underline;
        }
        /*Main page*/
        .container {
            max-width: 600px;
            margin: 32px auto;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.08);
            padding: 32px 40px;
        }
        .container h2 {
            color: #7c5a1f;
            margin-bottom: 24px;
            font-size: 32px;
        }
        .info {
            margin-bottom: 24px;
        }
        .info label {
            font-weight: bold;
            color: #333;
            display: block;
            margin-bottom: 4.8px;
        }
        .info .value {
            margin-bottom: 16px;
            color: #555;
        }
        .fine-amount {
            font-size: 24px;
            color: #b22222;
            font-weight: bold;
            margin-bottom: 24px;
        }
        .pay-btn {
            background: #c44d4d;
            color: #fff;
            border: none;
            border-radius: 5px;
            padding: 12.8px 32px;
            font-size: 17.6px;
            cursor: pointer;
            transition: background 0.2s;
        }
        .pay-btn:hover {
            background: #0056b3;
        }
    </style>
</head>
<body>
  <!-- Users Navigation Bar -->
    <div class="navbar">
        <div class="logo">
            <img src="logo.jpg" alt="Library Logo" />
            <span class="title">Whimsigirl Library</span>
        </div>
        <div class="menu">
            <a href="#">Home</a>
            <a href="#">Search</a>
            <a href="#">Reserve</a>
            <a href="#">Issue</a>
            <a href="#" class="active">Fine</a>
            <a href="#">Log Out</a>
        </div>
    </div>
    <div class="container">
        <h2>Pay Fine</h2>
        <div class="info">
            <label>Username:</label>
            <div class="value">john_doe</div>
            <label>Book Reserved:</label>
            <div class="value">The Awkward Human</div>
            <label>Reason:</label>
            <div class="value">Late return</div>
        </div>
        <div class="fine-amount">Amount Due: $15.00</div>
        <button class="pay-btn">Pay Now</button>
    </div>
</body>
</html> 