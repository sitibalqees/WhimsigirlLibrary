<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Reserve Book</title>
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
    margin: 70px auto;
    padding: 30px 40px;
    border-radius: 12px;
    box-shadow: 0 8px 20px rgba(0,0,0,0.2);
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
  select,
  textarea {
    width: 100%;
    padding: 12px;
    margin-bottom: 20px;
    border: 1px solid #ccc;
    border-radius: 8px;
    font-size: 15px;
    transition: border-color 0.3s ease;
  }
  input:focus,
  select:focus,
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
    <img src="logo.png" alt="Library Logo">
    Whimsigirl Library
  </div>
  <div class="nav-links">
    <a href="add.jsp">Add</a>
    <a href="update.jsp">Update</a>
    <a href="delete.jsp">Delete</a>
    <a href="return.jsp">Return</a>
    <a href="fine.jsp">Fine Record</a>
    <a href="logout.jsp">Log Out</a>
  </div>
</div>

<div class="form-container">
  <h2>Reserve Book</h2>
  <form action="ReserveServlet" method="post">
    <label for="title">Book Title</label>
    <input type="text" id="title" name="title" placeholder="Enter book title" required>

    <label for="author">Author</label>
    <input type="text" id="author" name="author" placeholder="Enter author name" required>

    <label for="category">Category</label>
    <select id="category" name="category" required>
      <option value="">Select Category</option>
      <option value="Fiction">Fiction</option>
      <option value="Non-fiction">Non-fiction</option>
      <option value="Reference">Reference</option>
      <option value="Magazine">Magazine</option>
    </select>

    <label for="icno">IC No</label>
    <input type="text" id="icno" name="icno" placeholder="Enter your IC number" required>

    <label for="comments">Additional Comments (Optional)</label>
    <textarea id="comments" name="comments" placeholder="Any additional information..."></textarea>

    <button type="submit">Reserve Book</button>
  </form>
</div>

</body>
</html>
