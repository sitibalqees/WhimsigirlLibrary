<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Remove Book Confirmation</title>
    <style>
        body {
            background: #f4e1e4;
            font-family: Georgia, serif;
            margin: 0;
            padding: 2rem;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }
        .form-container {
            background-color: #fff;
            padding: 2.5rem;
            border-radius: 14px;
            box-shadow: 0 6px 20px rgba(0,0,0,0.1);
            max-width: 550px;
            width: 100%;
            text-align: center;
        }
        .form-title {
            font-size: 2em;
            color: #d9534f;
            margin-bottom: 1rem;
        }
        .form-description {
            font-size: 1.1em;
            color: #333;
            margin-bottom: 1.5rem;
            line-height: 1.6;
        }
        .book-details {
            text-align: left;
            margin-bottom: 2rem;
            padding: 1rem;
            background: #f9f9f9;
            border-left: 5px solid #d9534f;
        }
        .book-details p {
            margin: 0.5rem 0;
            font-size: 1.05em;
        }
        .book-details strong {
            color: #4b2e2e;
        }
        .form-actions {
            display: flex;
            justify-content: center;
            gap: 1rem;
        }
        .submit-btn, .cancel-btn {
            padding: 0.8rem 1.8rem;
            font-size: 1em;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .submit-btn {
            color: #fff;
            background-color: #d9534f;
        }
        .submit-btn:hover {
            background-color: #c9302c;
        }
        .cancel-btn {
            color: #333;
            background-color: #eee;
            text-decoration: none; /* For 'a' tag */
        }
        .cancel-btn:hover {
            background-color: #ddd;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h2 class="form-title">Confirm Deletion</h2>
        <p class="form-description">Are you sure you want to permanently remove this book from the library?</p>

        <!-- Display book details for confirmation -->
        <c:if test="${not empty book}">
            <div class="book-details">
                <p><strong>Book ID:</strong> ${book.bookId}</p>
                <p><strong>Title:</strong> ${book.title}</p>
                <p><strong>Author:</strong> ${book.authorName}</p>
                <p><strong>ISBN:</strong> ${book.isbn}</p>
            </div>
        </c:if>

        <form action="BookController" method="POST" class="issue-form">
            <input type="hidden" name="action" value="delete">
            <input type="hidden" name="bookId" value="${book.bookId}">
            
            <div class="form-actions">
                <button type="submit" class="submit-btn">Yes, Delete Book</button>
                <a href="BookController?action=list" class="cancel-btn">Cancel</a>
            </div>
        </form>
    </div>
</body>
</html>