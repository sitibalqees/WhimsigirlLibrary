<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Reserve a Book</title>
<style>
  body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    margin: 0;
    background: linear-gradient(to right, #f7d9d9, #fceae8);
  }
  .navbar {
    background-color: #8b3a3a;
    overflow: hidden;
    padding: 12px 25px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.2);
  }
  .navbar a {
    float: right;
    color: #fff;
    text-decoration: none;
    margin-left: 20px;
    font-weight: bold;
    font-size: 16px;
    transition: color 0.3s ease, background 0.3s ease;
    padding: 8px 12px;
    border-radius: 5px;
  }
  .navbar a:hover {
    background-color: #fff;
    color: #8b3a3a;
  }
  .container {
    background-color: #f9e4e4;
    max-width: 420px;
    margin: 90px auto;
    padding: 35px;
    border-radius: 15px;
    box-shadow: 0 8px 20px rgba(0,0,0,0.25);
    text-align: center;
  }
  .container h2 {
    color: #5b1f1f;
    margin-bottom: 15px;
    font-size: 24px;
  }
  .icon {
    font-size: 50px;
    color: #8b3a3a;
    margin-bottom: 10px;
    animation: bounce 2s infinite;
  }
  label {
    font-weight: bold;
    display: block;
    margin: 12px 0 5px;
    text-align: left;
    color: #333;
  }
  input[type="text"],
  select,
  textarea {
    width: 100%;
    padding: 10px;
    margin-bottom: 15px;
    border: 1px solid #ccc;
    border-radius: 6px;
    font-size: 14px;
    transition: box-shadow 0.3s ease;
  }
  input:focus,
  select:focus,
  textarea:focus {
    box-shadow: 0 0 8px #a23c3c;
    outline: none;
  }
  textarea {
    height: 90px;
  }
  button {
    width: 100%;
    padding: 12px;
    background-color: #8b3a3a;
    color: white;
    border: none;
    border-radius: 8px;
    font-size: 16px;
    cursor: pointer;
    transition: transform 0.2s ease, background-color 0.3s ease;
  }
  button:hover {
    background-color: #6e2b2b;
    transform: scale(1.05);
  }
  @keyframes bounce {
    0%, 100% {
      transform: translateY(0);
    }
    50% {
      transform: translateY(-8px);
    }
  }
</style>
</head>
<body>

<div class="navbar">
  <a href="logout.jsp">Log Out</a>
  <a href="payfine.jsp">Fine</a>
  <a href="issue.jsp">Issue</a>
  <a href="search.jsp">Search</a>
  <a href="home.jsp">Home</a>
</div>

<div class="container">
  <div class="icon">📚</div>
  <h2>Reserve a Book</h2>
  <form action="ReserveServlet" method="post">
    <label for="title">Title of the Book:</label>
    <input type="text" id="title" name="title" placeholder="Enter book title" required>

    <label for="author">Author:</label>
    <input type="text" id="author" name="author" placeholder="Enter author name" required>

    <label for="category">Category:</label>
    <select id="category" name="category">
      <option value="Fiction">Fiction</option>
      <option value="Non-fiction">Non-fiction</option>
      <option value="Reference">Reference</option>
      <option value="Magazine">Magazine</option>
    </select>

    <label for="icno">IC No:</label>
    <input type="text" id="icno" name="icno" placeholder="Enter your IC number" required>

    <label for="comments">Additional Comments (Optional):</label>
    <textarea id="comments" name="comments" placeholder="Any additional information..."></textarea>

    <button type="submit">Reserve Now</button>
  </form>
</div>

</body>
</html>
