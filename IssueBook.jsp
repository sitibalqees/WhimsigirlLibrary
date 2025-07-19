<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="library.model.Book" %>
<%
    String userName = (String) session.getAttribute("userName");
    Integer userID = (Integer) session.getAttribute("userID");
    String bookTitle = (String) request.getAttribute("bookTitle");
    Integer bookID = (Integer) request.getAttribute("bookID");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Issue Book</title>

</head>
<body>
    <header>
        <nav class="navbar section-content">
            <a href="#" class="nav-logo">
                <img src="image/Whimsigirl Logo.jpg" alt="Library Logo" class="logo-image">
                <h2 class="logo-text">Whimsigirl Library</h2>
            </a>
            <ul class="nav-menu">
                <li class="nav-item">
                    <a href="HomePage.jsp" class="nav-link">Home</a>
                </li>
                <li class="nav-item">
                    <a href="#" class="nav-link">Search</a>
                </li>
                <li class="nav-item">
                    <a href="#" class="nav-link">Reserve</a>
                </li>
                <li class="nav-item">
                    <a href="IssueBook.jsp" class="nav-link">Issue</a>
                </li>
                <li class="nav-item">
                    <a href="#" class="nav-link">Fine</a>
                </li>
                <li class="nav-item">
                    <a href="#" class="nav-link">Log Out</a>
                </li>
            </ul>
        </nav>
    </header>

    <main class="issue-page">
        <div class="form-container">
            <h2 class="form-title">Report an Issue with Your Book</h2>
            <p class="form-description">
                Encountered a problem with a borrowed book? Fill out this form to let us know. Upload an image if necessary.
            </p>
            <form action="IssueController" method="POST" class="issue-form" enctype="multipart/form-data">
                <div class="form-group">
                    <label>Name:</label>
                    <input type="text" value="<%= userName %>" readonly>
                    <input type="hidden" name="userID" value="<%= userID %>">
                </div>
                <div class="form-group">
                    <label>Book:</label>
                    <input type="text" value="<%= bookTitle %>" readonly>
                    <input type="hidden" name="bookID" value="<%= bookID %>">
                </div>
                <div class="form-group">
                    <label for="issue">Issue:</label>
                    <textarea id="issue" name="issue" required></textarea>
                </div>
                <div class="form-group">
                    <label for="proof">Upload Proof (Optional):</label>
                    <input type="file" id="proof" name="proof" accept="image/*">
                    <small class="file-hint">Accepted formats: JPEG, PNG (Max size: 5MB)</small>
                </div>
                <div class="form-actions">
                    <button type="submit" class="submit-btn">Submit Report</button>
                </div>
            </form>
        </div>
    </main>
    
    <style>
		@import url('https://fonts.googleapis.com/css2?family=Miniver&family=Poppins:ital,wght@0,400;0,500;0,600;0,700;1,400&display=swap');

/* Root Variables */
:root {
    --white-color: #fff;
    --light-pink-color: #faf4f5;
    --font-size-xl: 2rem;
    --border-radius-s: 8px;
}

/* Global Reset */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: "Poppins", sans-serif;
}

a {
    text-decoration: none;
}

img {
    width: 100%;
}

/* Navbar (minimal for logo and nav) */
header {
    background: #3c0d0d;
}

header .navbar {
    display: flex;
    padding: 20px;
    align-items: center;
    justify-content: space-between;
}

.nav-logo {
    display: flex;
    align-items: center;
    gap: 10px;
}

.logo-image {
    height: 40px;
    width: auto;
    border-radius: 50%;
}

.logo-text {
    color: var(--white-color);
    font-size: var(--font-size-xl);
    font-weight: 600;
}

.navbar .nav-menu {
    display: flex;
    gap: 10px;
}

.navbar .nav-menu .nav-link {
    padding: 10px 18px;
    color: #fff;
    font-size: 1.12rem;
    border-radius: 30px;
    transition: 0.3s ease;
}

.navbar .nav-menu .nav-link:hover {
    color: #3b141c;
    background: #f3961c;
}

/* Issue Page Styling */
.issue-page {
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 2rem;
    background-color: var(--light-pink-color);
    min-height: 100vh;
}

.form-container {
    background-color: #fff;
    padding: 2rem;
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    max-width: 500px;
    width: 100%;
}

.form-title {
    font-size: 1.8rem;
    color: #c44d4d;
    margin-bottom: 1rem;
    text-align: center;
}

.form-description {
    font-size: 1rem;
    color: #333;
    margin-bottom: 1.5rem;
    text-align: center;
    line-height: 1.5;
}

.issue-form {
    display: flex;
    flex-direction: column;
    gap: 1rem;
}

.form-group label {
    font-size: 1rem;
    color: #333;
    margin-bottom: 0.5rem;
}

.form-group input,
.form-group textarea {
    font-size: 1rem;
    padding: 0.8rem;
    border: 1px solid #ddd;
    border-radius: var(--border-radius-s);
    background-color: #fff;
    transition: border-color 0.3s ease, box-shadow 0.3s ease;
    width: 100%;
    resize: none;
}

.form-group input:focus,
.form-group textarea:focus {
    border-color: #b68d40;
    box-shadow: 0 0 5px rgba(182, 141, 64, 0.3);
}

.form-group input[type="file"] {
    font-size: 0.9rem;
    padding: 0.5rem;
    border: 1px solid #ddd;
    border-radius: var(--border-radius-s);
    background-color: #fff;
    transition: border-color 0.3s ease;
}

.file-hint {
    font-size: 0.85rem;
    color: #666;
    margin-top: 0.3rem;
}

.form-actions {
    display: flex;
    justify-content: center;
}

.submit-btn {
    padding: 0.8rem 2rem;
    font-size: 1rem;
    color: #fff;
    background-color: #c44d4d;
    border: none;
    border-radius: var(--border-radius-s);
    cursor: pointer;
    transition: background-color 0.3s ease;
}

.submit-btn:hover {
    background-color: #a83838;
}
	</style>
</body>
</html>