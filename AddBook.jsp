<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Add Book</title>
<style>
  body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    margin: 0;
    background-color: #f9e6e6; /* Soft pink background */
  }
  .navbar {
    background-color: #5b1f1f; /* Deep maroon */
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 10px 30px;
    color: #fff;
  }
  .navbar .logo {
    display: flex;
    align-items: center;
    font-size: 22px;
    font-weight: bold;
  }
  .navbar .logo img {
    height: 40px;
    width: 40px;
    margin-right: 10px;
    border-radius: 50%;
  }
  .navbar a {
    color: #fff;
    text-decoration: none;
    margin-left: 20px;
    font-weight: 500;
    transition: color 0.3s ease;
  }
  .navbar a:hover {
    color: #ffd7d7;
  }
  .form-container {
    background-color: #fff;
    max-width: 500px;
    margin: 40px auto;
    padding: 30px 40px;
    border-radius: 12px;
    box-shadow: 0 8px 20px rgba(0,0,0,0.1);
  }
  .form-container h2 {
    color: #a0522d;
    text-align: center;
    margin-bottom: 25px;
  }
  label {
    font-weight: 600;
    display: block;
    margin-bottom: 5px;
    color: #333;
  }
  input[type="text"],
  input[type="number"],
  textarea,
  input[type="file"] {
    width: 100%;
    padding: 12px;
    margin-bottom: 20px;
    border: 1px solid #ccc;
    border-radius: 8px;
    font-size: 15px;
    box-sizing: border-box; /* Ensures padding doesn't affect width */
    transition: border-color 0.3s ease;
  }
  input:focus,
  textarea:focus {
    border-color: #a23c3c;
    outline: none;
  }
  textarea {
      resize: vertical;
      min-height: 80px;
  }
  button {
    width: 100%;
    padding: 12px;
    background-color: #c44d4d;
    color: white;
    border: none;
    border-radius: 8px;
    font-size: 16px;
    font-weight: 600;
    cursor: pointer;
    transition: background-color 0.3s ease;
  }
  button:hover {
    background-color: #a23c3c;
  }
</style>
</head>
<body>

<div class="navbar">
  <div class="logo">
    <img src="image/Whimsigirl Logo.jpg" alt="Library Logo">
    Whimsigirl Library
  </div>
  <div class="nav-links">
    <a href="BookController?action=list">Book List</a>
    <a href="AdminPage.jsp">Admin Page</a>
    <a href="LogoutController">Log Out</a>
  </div>
</div>

<div class="form-container">
  <h2>Add New Book</h2>
  <form action="BookController" method="post" enctype="multipart/form-data">

    <label for="title">Title</label>
    <input type="text" id="title" name="title" placeholder="Enter book title" required>

    <label for="authorName">Author Name</label>
    <input type="text" id="authorName" name="authorName" placeholder="Enter author name" required>

    <label for="synopsis">Synopsis</label>
    <textarea id="synopsis" name="synopsis" placeholder="Enter a brief synopsis" required></textarea>

    <label for="category">Category</label>
    <input type="text" id="category" name="category" placeholder="Enter book category" required>

    <label for="isbn">ISBN</label>
    <input type="number" id="isbn" name="isbn" placeholder="Enter ISBN number" required>
    
    <label for="publisher">Publisher</label>
    <input type="text" id="publisher" name="publisher" placeholder="Enter publisher name" required>

    <label for="publishYear">Publication Year</label>
    <input type="number" id="publishYear" name="publishYear" placeholder="e.g., 2023" required>

    <label for="price">Price</label>
    <input type="number" id="price" name="price" step="0.01" placeholder="e.g., 29.99" required>

    <label for="image">Book Cover Image</label>
    <input type="file" id="image" name="image" accept="image/*" required>

    <button type="submit">Add Book</button>
  </form>
</div>

</body>
</html>