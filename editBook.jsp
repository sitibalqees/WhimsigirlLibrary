<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Book</title>
    <style>
        body {
            background: #f4e1e4;
            font-family: Georgia, serif;
            margin: 0;
            padding: 0;
        }
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
        .container {
            max-width: 500px;
            margin: 48px auto 0 auto;
            background: #fff;
            border-radius: 14px;
            box-shadow: 0 4px 24px rgba(60,40,10,0.10);
            padding: 36px 32px 32px 32px;
        }
        h1 {
            color: #4b2e2e;
            text-align: center;
            margin-bottom: 28px;
            letter-spacing: 1px;
            font-size: 2em;
        }
        .form-section {
            margin-bottom: 18px;
        }
        .form-label {
            display: block;
            font-weight: 600;
            color: #3d2c0f;
            margin-bottom: 4px;
        }
        .readonly-field {
            display: block;
            background: #f5e1e4;
            color: #4b2e2e;
            border: none;
            font-size: 1em;
            padding: 8px 10px;
            border-radius: 5px;
            margin-bottom: 8px;
        }
        input[type="text"], input[type="number"], input[type="file"] {
            width: 100%;
            padding: 8px 10px;
            border: 1px solid #cfc6b1;
            border-radius: 5px;
            background: #f9f7f2;
            font-size: 1em;
            margin-bottom: 8px;
            transition: border 0.2s;
            box-sizing: border-box;
        }
        input[type="text"]:focus, input[type="number"]:focus, input[type="file"]:focus {
            border: 1.5px solid #bfa76f;
            outline: none;
        }
        .actions {
            text-align: center;
            padding-top: 10px;
        }
        input[type="submit"], input[type="reset"] {
            background: #bfa76f;
            color: #fff;
            border: none;
            border-radius: 5px;
            padding: 10px 28px;
            font-size: 1em;
            font-weight: 600;
            margin: 0 8px;
            cursor: pointer;
            transition: background 0.2s;
        }
        input[type="submit"]:hover, input[type="reset"]:hover {
            background: #a68b4c;
        }
        .back-link {
            display: inline-block;
            margin-bottom: 18px;
            color: #7a5c1e;
            text-decoration: none;
            font-weight: 500;
            transition: color 0.2s;
        }
        .back-link:hover {
            color: #bfa76f;
            text-decoration: underline;
        }
        .error-msg {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
            padding: 12px;
            border-radius: 6px;
            margin-bottom: 18px;
            text-align: center;
            font-weight: bold;
        }
        @media (max-width: 600px) {
            .container {
                padding: 16px 4px 12px 4px;
            }
        }
    </style>
</head>
<body>
    <!-- Admin Navigation Bar -->
    <div class="admin-navbar">
        <span class="admin-title">Library Admin</span>
        <div class="admin-menu">
            <a href="AdminPage.jsp">Home</a>
            <a href="AddBook.jsp">Add Book</a>
            <a href="BookController?action=list" class="active">Update</a>
            <a href="RemoveBook.jsp">Delete Book</a>
            <a href="returnBook.jsp">Return Book</a>
            <a href="#">Fine Record</a>
        </div>
    </div>
    <div class="container">
        <a class="back-link" href="BookController?action=list">&larr; Back to Book List</a>
        <h1>Edit Book</h1>
        <c:if test="${not empty error}">
            <div class="error-msg">${error}</div>
        </c:if>
        <form action="BookController" method="post" enctype="multipart/form-data">
            <input type="hidden" name="action" value="update"/>
            <input type="hidden" name="bookId" value="${book.bookId}"/>

            <div class="form-section">
                <label class="form-label">Title:</label>
                <span class="readonly-field">${book.title}</span>
            </div>
            <div class="form-section">
                <label class="form-label">Author Name:</label>
                <span class="readonly-field">${book.authorName}</span>
            </div>
            <div class="form-section">
                <label class="form-label">Category:</label>
                <span class="readonly-field">${book.category}</span>
            </div>
            <div class="form-section">
                <label class="form-label">Synopsis:</label>
                <span class="readonly-field" style="white-space:pre-line;">${book.synopsis}</span>
            </div>
            <div class="form-section">
                <label class="form-label" for="isbn">ISBN:</label>
                <input type="number" id="isbn" name="isbn" value="${book.isbn}" required>
            </div>
            <div class="form-section">
                <label class="form-label" for="publisher">Publisher:</label>
                <input type="text" id="publisher" name="publisher" value="${book.publisher}" required>
            </div>
            <div class="form-section">
                <label class="form-label" for="price">Price:</label>
                <input type="number" step="0.01" id="price" name="price" value="${book.price}" required>
            </div>
            <div class="form-section">
                <label class="form-label" for="image">Book Image (leave blank to keep current):</label>
                <input type="file" id="image" name="image">
            </div>
            <div class="actions">
                <input type="submit" value="Update Book">
                <input type="reset" value="Reset">
            </div>
        </form>
    </div>
</body>
</html>