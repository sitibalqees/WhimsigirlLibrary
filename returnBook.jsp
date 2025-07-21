<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Return Book</title>
    <style>
        /* Page background and font styling */
        body {
            background-color: #e7d3d3;
            font-family: Arial, sans-serif;
            margin: 0;
        }
        /* Admin navigation bar styling */
        .admin-navbar {
            background-color: #3c0d0d;
            color: #fff;
            display: flex;
            align-items: center;
            padding: 10px 20px;
            height: 60px;
            justify-content: space-between;
        }
        .admin-navbar .admin-title {
            font-size: 25.6px;
            font-weight: bold;
            font-family: 'Georgia', serif;
            letter-spacing: 0.5px;
        }
        .admin-navbar .admin-menu {
            display: flex;
            gap: 32px;
        }
        .admin-navbar .admin-menu a {
            color: #fff;
            text-decoration: none;
            font-size: 16px;
            font-weight: 500;
            transition: color 0.2s;
        }
        .admin-navbar .admin-menu a:hover, .admin-navbar .admin-menu a.active {
            color: #ffd7d7;
            text-decoration: underline;
        }
        /* Centered container for the return book card */
        .return-container {
            background: #f5cfcf; /* Lighter pink card */
            max-width: 400px;
            margin: 48px auto;
            border-radius: 16px;
            box-shadow: 0 4px 16px rgba(0,0,0,0.08);
            padding: 40px 32px 32px 32px;
            display: flex;
            flex-direction: column;
            align-items: stretch;
        }
        /* Title styling */
        .return-container h2 {
            text-align: center;
            color: #7a2e2e;
            margin-bottom: 32px;
        }
        /* Label for each info field */
        .info-label {
            font-weight: bold;
            color: #7a2e2e;
            margin-bottom: 3.2px;
        }
        /* Value display for each info field */
        .info-value {
            background: #fff;
            border-radius: 6px;
            padding: 11.2px 16px;
            margin-bottom: 17.6px;
            color: #333;
            border: 1px solid #e6bcbc;
        }
        /* Return Book button styling */
        .return-btn {
            background: #c44d4d;
            color: #fff;
            border: none;
            border-radius: 6px;
            padding: 14.4px;
            font-size: 17.6px;
            font-weight: bold;
            cursor: pointer;
            margin-top: 16px;
            transition: background 0.2s;
        }
        .return-btn:hover {
            background: #a83a3a;
        }
    </style>
</head>
<body>
    <!-- Admin Navigation Bar -->
    <div class="admin-navbar">
        <span class="admin-title">Library Admin</span>
        <div class="admin-menu">
            <a href="#">Add Book</a>
            <a href="#">Update Book</a>
            <a href="#">Delete Book</a>
            <a href="#" class="active">Return Book</a>
            <a href="#">Fine Record</a>
            
        </div>
    </div>
    <!-- Main container for the return book form -->
    <div class="return-container">
        <h2>Return a Book</h2>
        <form action="ReturnBookController" method="post">
            <b>User ID: </b><br>
            <input type="text" name="userId" required><br><br>
            <b>Book ID: </b><br>
            <input type="text" name="bookId" required><br><br>
            <input type="submit" value="Return Book">
            <input type="reset">
        </form>
    </div>
</body>
</html> 