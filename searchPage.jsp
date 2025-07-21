<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        .form-group label {
            margin-bottom: 0.5rem;
            color: #5c1a1a;
            font-weight: bold;
            font-size: 1.1rem;
        }

        .form-group input {
            padding: 0.8rem;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 1rem;
        }

        .search-button {
            grid-column: 1 / -1;
            text-align: center;
        }

        .search-button button {
            background-color: #b84141;
            color: white;
            border: none;
            padding: 1rem 2rem;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1.1rem;
            font-weight: bold;
            transition: background-color 0.3s;
        }

        .search-button button:hover {
            background-color: #8b2f2f;
        }

        .search-info {
            text-align: center;
            color: #5c1a1a;
            font-style: italic;
            margin-top: 2rem;
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
        
        <form action="BookController" method="GET" class="search-form">
            <div class="form-group">
                <label for="bookTitle">Book Title</label>
                <input type="text" id="bookTitle" name="bookTitle" placeholder="Enter book title...">
            </div>
            
            <div class="form-group">
                <label for="author">Author</label>
                <input type="text" id="author" name="author" placeholder="Enter author name...">
            </div>
            
            <div class="form-group">
                <label for="isbn">ISBN</label>
                <input type="text" id="isbn" name="isbn" placeholder="Enter ISBN...">
            </div>
            
            <div class="form-group">
                <label for="genre">Genre</label>
                <input type="text" id="genre" name="genre" placeholder="Enter genre...">
            </div>
            
            <div class="search-button">
                <button type="submit">Search Books</button>
            </div>
        </form>

        <div class="search-info">
            <p>Enter search criteria above to find books in our library.</p>
            <p>You can search by title, author, ISBN, or genre.</p>
        </div>
    </div>
</body>
</html>
