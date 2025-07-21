<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <style>
        body {
            font-family: Georgia, serif;
            margin: 0;
            padding: 0;
            background-color: #f4e1e4;
        }
        .admin-navbar {
            background-color: #3c0d0d;
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 14px 32px;
            box-shadow: 0 2px 8px rgba(60,13,13,0.08);
        }
        .logo {
            font-size: 28px;
            font-weight: bold;
            letter-spacing: 1px;
        }
        .admin-navbar ul {
            list-style: none;
            display: flex;
            margin: 0;
            padding: 0;
        }
        .admin-navbar ul li {
            margin-left: 22px;
        }
        .admin-navbar ul li a {
            color: white;
            text-decoration: none;
            font-weight: bold;
            font-size: 1.08em;
            transition: color 0.2s;
        }
        .admin-navbar ul li a:hover {
            color: #f4e1e4;
            text-decoration: underline;
        }
        .logout-link {
            margin-left: 32px;
            color: #f4e1e4;
            font-weight: bold;
            text-decoration: none;
            border: 1px solid #f4e1e4;
            border-radius: 4px;
            padding: 6px 16px;
            transition: background 0.2s, color 0.2s;
        }
        .logout-link:hover {
            background: #f4e1e4;
            color: #3c0d0d;
        }
        .admin-container {
            max-width: 900px;
            margin: 48px auto 0 auto;
            padding: 36px 32px 32px 32px;
            background-color: rgba(255, 255, 255, 0.92);
            border-radius: 14px;
            box-shadow: 0 4px 24px rgba(60,40,10,0.10);
            text-align: center;
        }
        h1 {
            color: #4b2e2e;
            margin-bottom: 8px;
            font-size: 2.2em;
            letter-spacing: 1px;
        }
        h2 {
            color: #8b3f3f;
            margin-bottom: 32px;
            font-size: 1.4em;
            font-weight: 500;
        }
        .admin-stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(210px, 1fr));
            gap: 24px;
            margin-top: 18px;
        }
        .stat-box {
            background-color: #8b3f3f;
            color: white;
            padding: 28px 0;
            border-radius: 8px;
            font-size: 1.18em;
            font-weight: 500;
            box-shadow: 0 2px 8px rgba(139,63,63,0.08);
            transition: transform 0.15s;
        }
        .stat-box:hover {
            transform: translateY(-4px) scale(1.03);
            background-color: #a05252;
        }
        @media (max-width: 600px) {
            .admin-container {
                padding: 18px 6px;
            }
            .admin-navbar {
                flex-direction: column;
                align-items: flex-start;
                padding: 10px 10px;
            }
            .admin-navbar ul {
                flex-direction: column;
                width: 100%;
            }
            .admin-navbar ul li {
                margin: 8px 0 0 0;
            }
            .logout-link {
                margin-left: 0;
                margin-top: 10px;
            }
        }
    </style>
</head>
<body>

    <!-- Admin Navigation Bar -->
    <div class="admin-navbar">
        <div class="logo">Library Admin</div>
        <div style="display: flex; align-items: center;">
            <ul>
                <li><a href="add.html">Add</a></li>
               <li><a href="BookController?action=list">Update</a></li>
                <li><a href="delete.html">Delete</a></li>
               <li><a href="returnBook.jsp">Return</a></li>
                <li><a href="payment.html">Fine Record</a></li>
            </ul>
            <a class="logout-link" href="Logout.jsp">Log Out</a>
        </div>
    </div>

    <!-- Admin Dashboard -->
    <div class="admin-container">
        <h1>WhimsiGirl Library</h1>
        <h2>Admin Dashboard</h2>
        <div class="admin-stats">
            <div class="stat-box">Books Listed: 2</div>
            <div class="stat-box">Times Book Issued: 6</div>
            <div class="stat-box">Times Books Returned: 3</div>
            <div class="stat-box">Registered Users: 6</div>
            <div class="stat-box">Authors Listed: 2</div>
            <div class="stat-box">Listed Categories: 6</div>
        </div>
    </div>

</body>