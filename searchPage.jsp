<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="library.model.Book" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Whimsigirl Library - Search Books</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }

        body {
            background-color: #f8e6e6;
        }

        .navbar {
            background-color: #5c1a1a;
            padding: 1rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .navbar-brand {
            color: white;
            font-size: 1.5rem;
            text-decoration: none;
            font-weight: bold;
        }

        .nav-links {
            display: flex;
            gap: 2rem;
        }

        .nav-links a {
            color: white;
            text-decoration: none;
            font-weight: 500;
        }

        .container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 2rem;
            background-color: rgba(255, 192, 203, 0.3);
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h1 {
            text-align: center;
            color: #5c1a1a;
            margin-bottom: 2rem;
            font-size: 2.5rem;
        }

        .search-form {
            display: flex;
            justify-content: center;
            gap: 1rem;
            margin-bottom: 2rem;
        }
        .search-input {
            padding: 0.8rem;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 1rem;
            width: 300px;
        }
        .search-btn {
            background-color: #b84141;
            color: white;
            border: none;
            padding: 0.8rem 2rem;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1.1rem;
            font-weight: bold;
            transition: background-color 0.3s;
        }
        .search-btn:hover {
            background-color: #8b2f2f;
        }
        .results-title {
            text-align: center;
            color: #5c1a1a;
            margin-bottom: 1.5rem;
            font-size: 2rem;
        }
        .book-list {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 2rem;
        }
        .book-card {
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
            display: flex;
            flex-direction: column;
            align-items: center;
            width: 350px;
            padding-bottom: 1.5rem;
        }
        .book-image {
            width: 100%;
            height: 220px;
            object-fit: cover;
            border-top-left-radius: 16px;
            border-top-right-radius: 16px;
        }
        .book-info {
            padding: 1.2rem;
            width: 100%;
        }
        .book-title {
            font-size: 1.3rem;
            font-weight: bold;
            margin-bottom: 0.5rem;
        }
        .book-author, .book-isbn, .book-category, .book-year, .book-synopsis {
            margin: 0.2rem 0;
            color: #5c1a1a;
        }
       
    </style>
</head>
<body>
    <nav class="navbar">
        <a href="index.jsp" class="navbar-brand">Whimsigirl Library</a>
        <div class="nav-links">
            <a href="index.jsp">Home</a>
            <a href="searchPage.jsp">Search</a>
            <a href="ReserveBook.jsp">Reserve</a>
            <a href="returnBook.jsp">Issue</a>
            <a href="payFine.jsp">Fine Payment</a>
            <a href="logout.jsp">Log Out</a>
        </div>
    </nav>

    <div class="container">
        <h1>Search for Books</h1>
        
        <form action="BookController" method="get" class="search-form">
            <input type="text" name="keyword" placeholder="Enter book title..." class="search-input" />
            <button type="submit" class="search-btn">Search Books</button>
        </form>

        <h2 class="results-title">Search Results</h2>
        <div class="book-list">
        <%
            List<Book> books = (List<Book>) request.getAttribute("books");
            if (books != null && !books.isEmpty()) {
                for (Book book : books) {
        %>
            <div class="book-card">
                <img src="<%= book.getImage() %>" alt="Book Cover" class="book-image"/>
                <div class="book-info">
                    <h3 class="book-title"><%= book.getTitle() %></h3>
                    <p class="book-author">by <%= book.getAuthorName() %></p>
                    <p class="book-isbn">ISBN: <%= book.getIsbn() %></p>
                    <p class="book-category"><%= book.getCategory() %></p>
                    <p class="book-year">Published: <%= book.getPublishYear() %></p>
                    <p class="book-synopsis"><%= book.getSynopsis() %></p>
                    <button class="reserve-btn">Reserve This Book</button>
                </div>
            </div>
        <%
                }
            } else if (books != null) {
        %>
            <p>No books found.</p>
        <%
            }
        %>
        </div>
    </div>
</body>
</html>
