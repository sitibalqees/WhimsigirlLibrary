<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Book List</title>
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
            max-width: 1100px;
            margin: 48px auto 0 auto;
            background: #fff;
            border-radius: 14px;
            box-shadow: 0 4px 24px rgba(60,40,10,0.10);
            padding: 36px 32px 32px 32px;
        }
        .search-container {
            margin-bottom: 24px;
            text-align: center;
        }
        .search-input {
            width: 50%;
            padding: 10px 15px;
            font-size: 1em;
            border: 1px solid #cfc6b1;
            border-radius: 6px;
            font-family: Georgia, serif;
        }
        .search-input:focus {
            outline: none;
            border-color: #bfa76f;
            box-shadow: 0 0 5px rgba(191,167,111,0.5);
        }
        .search-button {
            padding: 11px 20px;
            font-size: 1em;
            font-family: Georgia, serif;
            color: #fff;
            background-color: #7a5c1e;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            margin-left: 8px;
            transition: background-color 0.2s;
            vertical-align: top;
        }
        .search-button:hover {
            background-color: #4b2e2e;
        }
        h2 {
            color: #4b2e2e;
            text-align: center;
            margin-bottom: 28px;
            letter-spacing: 1px;
            font-size: 2em;
        }
        .add-link {
            display: inline-block;
            margin-bottom: 18px;
            color: #7a5c1e;
            text-decoration: none;
            font-weight: 500;
            font-size: 1.08em;
            transition: color 0.2s;
        }
        .add-link:hover {
            color: #bfa76f;
            text-decoration: underline;
        }
        table {
            border-collapse: separate;
            border-spacing: 0 8px;
            width: 100%;
            background: #f9f7f2;
        }
        th, td {
            border: 1px solid #cfc6b1;
            padding: 10px 8px;
            text-align: left;
        }
        th {
            background-color: #e7dfc6;
            color: #4b2e2e;
            font-weight: 700;
            font-size: 1.05em;
        }
        tr:nth-child(even) {
            background-color: #f5e1e4;
        }
        tr:hover {
            background-color: #f1e9d2;
        }
        .action-link {
            color: #bfa76f;
            font-weight: 600;
            text-decoration: none;
            padding: 6px 16px;
            border-radius: 4px;
            background: #f5f3e7;
            transition: background 0.2s, color 0.2s;
            border: 1px solid #bfa76f;
            display: inline-block;
        }
        .action-link:hover {
            background: #bfa76f;
            color: #fff;
        }
        .action-link.remove {
            color: #d9534f;
            border-color: #d9534f;
        }
        .action-link.remove:hover {
            background: #d9534f;
            color: #fff;
        }
        .success-msg {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
            padding: 16px;
            border-radius: 6px;
            margin-bottom: 18px;
            text-align: center;
            font-weight: bold;
            font-size: 1.1em;
            animation: fadeout 0.5s 2.5s forwards;
        }
        @keyframes fadeout {
            to { opacity: 0; display: none; }
        }
        .book-title {
            font-weight: bold;
            color: #7a5c1e;
            font-size: 1.08em;
        }
        .book-meta {
            color: #4b2e2e;
            font-size: 0.98em;
        }
        .book-numbers {
            color: #8b3f3f;
            font-size: 0.97em;
            text-align: center;
        }
        .book-actions {
            text-align: center;
        }
        @media (max-width: 900px) {
            .container {
                padding: 16px 4px 12px 4px;
        }
            table, th, td {
                font-size: 0.98em;
            }
        }
        @media (max-width: 600px) {
            .container {
                padding: 6px 2px 6px 2px;
            }
            table, th, td {
                font-size: 0.92em;
            }
            th, td {
                padding: 6px 4px;
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
            <a href="returnBook.jsp">Return Book</a>
            <a href="#">Fine Record</a>
        </div>
    </div>
    <div class="container">
        <c:if test="${updateSuccess}">
            <div class="success-msg" id="successMsg">
                Book updated successfully!
            </div>
            <script>
                setTimeout(function() {
                    var msg = document.getElementById('successMsg');
                    if(msg) msg.style.display = 'none';
                }, 3000);
            </script>
        </c:if>
        <c:if test="${not empty sessionScope.deleteSuccess}">
            <div class="success-msg" id="deleteSuccessMsg">
                Book deleted successfully!
            </div>
            <c:remove var="deleteSuccess" scope="session" />
        </c:if>

        <!-- Search Bar -->
        <div class="search-container">
            <form id="searchForm" onsubmit="searchBooks(event)">
                <input type="text" id="searchInput" class="search-input" onkeyup="searchBooks()" placeholder="Search for books by title or author...">
                <button type="submit" class="search-button">Search</button>
            </form>
        </div>

        <h2>Book List</h2>
        <a class="add-link" href="BookController?action=add">+ Add New Book</a>
        <table id="bookTable">
            <thead>
                <tr>
                    <th>Title &amp; Author</th>
                    <th>Category</th>
                    <th>Publisher</th>
                    <th>Year</th>
                    <th>ISBN</th>
                    <th>Synopsis</th>
                    <th>Price</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="book" items="${books}">
                    <tr>
                        <td>
                            <div class="book-title">${book.title}</div>
                            <div class="book-meta">by ${book.authorName}</div>
                        </td>
                        <td class="book-meta">${book.category}</td>
                        <td class="book-meta">${book.publisher}</td>
                        <td class="book-numbers">${book.publishYear}</td>
                        <td class="book-numbers">${book.isbn}</td>
                        <td class="book-meta" style="max-width:180px; white-space:pre-line; overflow:hidden; text-overflow:ellipsis;">${book.synopsis}</td>
                        <td class="book-numbers">${book.price}</td>
                        <td class="book-actions">
                            <a class="action-link" href="BookController?action=edit&bookId=${book.bookId}">Edit</a>
                            <a class="action-link remove" href="BookController?action=delete&bookId=${book.bookId}">Remove</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <script>
        function searchBooks(event) {
            if(event) {
              event.preventDefault(); // Prevents form from submitting and reloading the page
            }
            var input, filter, table, tr, td, i, txtValue;
            input = document.getElementById("searchInput");
            filter = input.value.toUpperCase();
            table = document.getElementById("bookTable");
            tr = table.getElementsByTagName("tr");

            // Loop through all table rows (excluding the header), and hide those who don't match the search query
            for (i = 1; i < tr.length; i++) {
                td = tr[i].getElementsByTagName("td")[0]; // Column for Title & Author
                if (td) {
                    txtValue = td.textContent || td.innerText;
                    if (txtValue.toUpperCase().indexOf(filter) > -1) {
                        tr[i].style.display = "";
                    } else {
                        tr[i].style.display = "none";
                    }
                }       
            }
        }
    </script>
</body>
</html>