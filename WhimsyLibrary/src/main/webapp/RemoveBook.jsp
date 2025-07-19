<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Whimsigirl Library - Remove Book</title>
<style>
/* Import Google fonts */
@import url('https://fonts.googleapis.com/css2?family=Miniver&family=Poppins:ital,wght@0,400;0,500;0,600;0,700;1,400&display=swap');

/* Logo Styling */
.nav-logo {
    display: flex;
    align-items: center;
    gap: 10px;
    text-decoration: none;
}

.logo-image {
    height: 40px;
    width: auto;
    border-radius: 50%;
}

.logo-text {
    color: var(--white-color);
    font-size: var(--font-size-xl);
    font-weight: var(--font-weight-semibold);
}

*{
	margin: 0;
	padding:0;
	box-sizing:border-box;
	font-family: "Poppins", sans-serif;
}

:root{
	--white-color: #fff;
	--dark-color: #252525;
	--primary-color: #3b141c;
	--secondary-color: #f3961c;
	--light-pink-color: #faf4f5;
	--medium-gray-color: #ccc;
	--font-size-s:0.9rem;
	--font-size-n:1rem;
	--font-size-m:1.12rem;
	--font-size-l:1.5rem;
	--font-size-xl:2rem;
	--font-size-xxl:2.3rem;
	--font-weight-normal:400;
	--font-weight-medium:500;
	--font-weight-semibold:600;
	--font-weight-bold:700;
	--border-radius-s:8px;
	--border-radius-m:30px;
	--border-radius-circle:50%;
	--site-max-width:1300px;
}

ul{
	list-style:none;
}

a{
	text-decoration:none;
}

button{
	cursor:pointer;
	border: none;
	background:none;
}

img{
	width:100%;
}

.section-content{
	margin: 0 auto;
	padding:0 20px;
	max-width: 1300px;
}

/* Navbar Styling*/
header {
	background: #3c0d0d;
}

header .navbar{
	display:flex;
	padding:20px;
	align-items:center;
	justify-content:space-between;
}

.navbar .nav-logo .logo-text{
	color: #fff;
	font-size:2rem;
	font-weight:600;
}

.navbar .nav-menu{
	display:flex;
	gap:10px;
}

.navbar .nav-menu .nav-link{
	padding:10px 18px;
	color: #fff;
	font-size:1.12rem;
	border-radius:30px;
	transition:0.3s ease; 
}

.navbar .nav-menu .nav-link:hover{
	color: #3b141c;
	background: #f3961c;
}

/* Delete Book Page Styling */
.deleteBook-page {
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 2rem;
    background-color: #f4e1e4;
    min-height: 100vh;
}

.form-container {
    background-color: #ffffff;
    padding: 2rem;
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    max-width: 500px;
    width: 100%;
}

.form-title {
    font-size: 1.8rem;
    color: #b68d40;
    margin-bottom: 1rem;
    text-align: center;
}

.form-description {
    font-size: 1rem;
    color: #333333;
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
    color: #333333;
    margin-bottom: 0.5rem;
}

.form-group input,
.form-group textarea {
    font-size: 1rem;
    padding: 0.8rem;
    border: 1px solid #ddd;
    border-radius: 8px;
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
    border-radius: 8px;
    background-color: #fff;
    transition: border-color 0.3s ease;
}

.file-hint {
    font-size: 0.85rem;
    color: #666666;
    margin-top: 0.3rem;
}

.form-actions {
    display: flex;
    justify-content: center;
}

.submit-btn {
    padding: 0.8rem 2rem;
    font-size: 1rem;
    color: #ffffff;
    background-color: #c44d4d;
    border: none;
    border-radius: 8px;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

.submit-btn:hover {
    background-color: #c44d4d;
}
</style>
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
                    <a href="#" class="nav-link">Add</a>
                </li>
                <li class="nav-item">
                    <a href="#" class="nav-link">Update</a>
                </li>
                <li class="nav-item">
                    <a href="#" class="nav-link">Delete</a>
                </li>
                <li class="nav-item">
                    <a href="#" class="nav-link">Return</a>
                </li>
                <li class="nav-item">
                    <a href="#" class="nav-link">Fine Record</a>
                </li>
                <li class="nav-item">
                    <a href="#" class="nav-link">Log Out</a>
                </li>
            </ul>
        </nav>
    </header>

    <main class="deleteBook-page">
        <div class="form-container">
            <h2 class="form-title">Delete Book</h2>
            <form action="#" method="POST" class="issue-form" id="deleteForm">
                <div class="form-group">
                    <label for="BookId">Book Id</label>
                    <input type="text" id="bookId" name="bookId">
                </div>
                <div class="form-group">
                    <label for="Title">Title</label>
                    <input type="text" id="title" name="title">
                </div>
                <div class="form-group">
                    <label for="Author">Author</label>
                    <input type="text" id="author" name="author">
                </div>
                <div class="form-group">
                    <label for="ISBN">ISBN</label>
                    <input type="text" id="isbn" name="isbn">
                </div>
                <div class="form-group">
                    <label for="Category">Category</label>
                    <input type="text" id="category" name="category">
                </div>
                <div class="form-actions">
                    <button type="submit" class="submit-btn" id="deleteButton">Delete Book</button>
                </div>
            </form>
        </div>
    </main>
    <script>
        // Attach an event listener to the delete button
        document.getElementById('deleteForm').addEventListener('submit', function(event) {
            // Show a confirmation dialog
            const userConfirmed = confirm("Are you sure you want to delete this book?");
            // If the user cancels, prevent the form submission
            if (!userConfirmed) {
                event.preventDefault();
            }
        });
    </script>
</body>
</html>