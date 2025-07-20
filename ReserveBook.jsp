<%@ page import="java.util.List" %>
<%@ page import="library.model.Book" %>
<%
    List<Book> bookList = (List<Book>) request.getAttribute("bookList");
    String userName = (String) session.getAttribute("userName");
    Integer userId = (Integer) session.getAttribute("userID");
    library.model.Book selectedBook = (library.model.Book) request.getAttribute("selectedBook");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Reserve Book</title>
<style>
  body {
    font-family: 'Poppins', sans-serif;
    margin: 0;
    background-color: #f4e1e4;
  }
  .navbar {
    background-color: #3c0d0d;
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
    color: #b68d40;
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
  textarea,
  input[type="date"] {
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
    background-color: #28a745;
    color: white;
    border: none;
    border-radius: 8px;
    font-size: 16px;
    font-weight: 600;
    cursor: pointer;
    transition: background-color 0.3s ease;
  }
  button:hover {
    background-color: #218838;
  }
  .success, .error {
    text-align: center;
    margin-bottom: 15px;
    font-weight: bold;
    font-size: 1.1rem;
  }
  .success { color: #28a745; }
  .error { color: #c44d4d; }
</style>
</head>
<body>

<div class="navbar">
  <div class="logo">
    <img src="image/Whimsigirl Logo.jpg" alt="Library Logo">
    Whimsigirl Library
  </div>
  <div>
    <a href="HomeController">Home</a>
    <a href="#">Search</a>
    <a href="ReserveBook.jsp">Reserve</a>
    <a href="IssueBook.jsp">Issue</a>
    <a href="#">Fine</a>
    <a href="#">Log Out</a>
  </div>
</div>

<div class="form-container">
  <h2>Reserve Book</h2>
  <% if ("true".equals(request.getParameter("success"))) { %>
    <div class="success">Book reserved successfully!</div>
  <% } else if ("true".equals(request.getParameter("error"))) { %>
    <div class="error">Failed to reserve book. Please try again.</div>
  <% } %>
  <form action="ReserveController" method="post">
    <label>User</label>
    <input type="text" value="<%= userName %>" readonly>
    <input type="hidden" name="userId" value="<%= userId %>">

    <label for="bookId">Book</label>
    <% if (selectedBook != null) { %>
        <input type="text" value="<%= selectedBook.getTitle() %> by <%= selectedBook.getAuthorName() %> (<%= selectedBook.getCategory() %>)" readonly>
        <input type="hidden" name="bookId" value="<%= selectedBook.getBookId() %>">
    <% } else { %>
        <select id="bookId" name="bookId" required>
          <option value="">Select Book</option>
          <% if (bookList != null) {
               for (Book book : bookList) {
                   if (book.getAvailability() == 1) { %>
            <option value="<%= book.getBookId() %>">
              <%= book.getTitle() %> by <%= book.getAuthorName() %> (<%= book.getCategory() %>)
            </option>
          <%     }
               }
             } %>
        </select>
    <% } %>

    <label for="comments">Additional Comments (Optional)</label>
    <textarea id="comments" name="comments" placeholder="Any additional information..."></textarea>

    <label for="reserveDate">Reserve Date</label>
    <input type="date" id="reserveDate" name="reserveDate" required>

    <label for="dueDate">Due Date</label>
    <input type="date" id="dueDate" name="dueDate" required>

    <button type="submit">Reserve Book</button>
  </form>
</div>
</body>
</html>