<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="library.model.Book" %>
<%
    List<Book> bookList = (List<Book>) request.getAttribute("bookList");
    String userName = (String) session.getAttribute("userName");
    Integer userId = (Integer) session.getAttribute("userID");
    Book selectedBook = (Book) request.getAttribute("selectedBook");
    Map<Integer, Boolean> bookAvailableMap = (Map<Integer, Boolean>) request.getAttribute("bookAvailableMap");
    String error = request.getParameter("error");
    String success = request.getParameter("success");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Reserve Book</title>
<style>
  <style>
body {
    font-family: 'Segoe UI', Arial, sans-serif;
    background: #faf6f2;
    margin: 0;
    padding: 0;
}
header {
    background: #7a1f2b;
    padding: 0;
}
.navbar {
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 0 40px;
    background: #7a1f2b;
}
.nav-logo {
    display: flex;
    align-items: center;
    text-decoration: none;
}
.logo-image {
    height: 80px;
    margin-right: 15px;
}
.logo-text {
    color: #fff;
    font-size: 2rem;
    margin: 0;
    font-weight: 700;
    letter-spacing: 2px;
}
.nav-menu {
    list-style: none;
    display: flex;
    gap: 25px;
    margin: 0;
    padding: 0;
}
.nav-item {
}
.nav-link {
    color: #fff;
    text-decoration: none;
    font-size: 1.1rem;
    font-weight: 500;
    transition: color 0.2s;
}
.nav-link:hover {
    color: #ffd6d6;
}
.form-container {
    background: #fff;
    max-width: 600px;
    margin: 40px auto 0 auto;
    padding: 30px 40px 25px 40px;
    border-radius: 12px;
    box-shadow: 0 4px 24px rgba(122,31,43,0.08);
}
.form-container h2 {
    margin-top: 0;
    color: #7a1f2b;
    text-align: center;
}
label {
    display: block;
    margin-top: 18px;
    margin-bottom: 6px;
    font-weight: 500;
    color: #7a1f2b;
}
input[type="text"], input[type="date"], select, textarea {
    width: 100%;
    padding: 8px 10px;
    border: 1px solid #ccc;
    border-radius: 6px;
    font-size: 1rem;
    margin-bottom: 10px;
    box-sizing: border-box;
}
textarea {
    min-height: 60px;
    resize: vertical;
}
button[type="submit"] {
    background: #7a1f2b;
    color: #fff;
    border: none;
    padding: 12px 0;
    width: 100%;
    border-radius: 6px;
    font-size: 1.1rem;
    font-weight: 600;
    cursor: pointer;
    margin-top: 18px;
    transition: background 0.2s;
}
button[type="submit"]:hover {
    background: #a83246;
}
.error {
    background: #ffd6d6;
    color: #a83246;
    padding: 10px;
    border-radius: 6px;
    margin-bottom: 10px;
    text-align: center;
}
.success {
    background: #d6ffd6;
    color: #2e7d32;
    padding: 10px;
    border-radius: 6px;
    margin-bottom: 10px;
    text-align: center;
}
</style>
</style>
</head>
<body>

<header>
    <nav class="navbar">
        <a href="#" class="nav-logo">
            <img src="image/Whimsigirl Logo.jpg" alt="Library Logo" class="logo-image">
            <h2 class="logo-text">Whimsigirl Library</h2>
        </a>
        <ul class="nav-menu">
            <li class="nav-item"><a href="HomeController" class="nav-link">Home</a></li>
            <li class="nav-item"><a href="#" class="nav-link">Search</a></li>
            <li class="nav-item"><a href="ReserveBook.jsp" class="nav-link">Reserve</a></li>
            <li class="nav-item"><a href="ReserveController?action=listUser" class="nav-link">My Reservation</a></li>
            <li class="nav-item"><a href="IssueBook.jsp" class="nav-link">Issue</a></li>
            <li class="nav-item"><a href="#" class="nav-link">Fine</a></li>
            <li class="nav-item"><a href="#" class="nav-link">Log Out</a></li>
        </ul>
    </nav>
</header>

<div class="form-container">
  <h2>Reserve Book</h2>
  <% if ("notavailable".equals(error)) { %>
    <div class="error">This book is already reserved for the selected date range. Please choose another date or book.</div>
  <% } else if ("true".equals(error)) { %>
    <div class="error">Failed to reserve book. Please try again.</div>
  <% } %>
  <% if ("true".equals(success)) { %>
    <div class="success">Book reserved successfully!</div>
  <% } %>
  <form action="ReserveController" method="post">
    <label>User</label>
    <input type="text" value="<%= userName %>" readonly>
    <input type="hidden" name="userID" value="<%= userId %>">

    <label for="bookId">Book</label>
    <% if (selectedBook != null) { %>
        <input type="text" value="<%= selectedBook.getTitle() %> by <%= selectedBook.getAuthorName() %> (<%= selectedBook.getCategory() %>)" readonly>
        <input type="hidden" name="bookId" value="<%= selectedBook.getBookId() %>">
    <% } else { %>
        <select id="bookId" name="bookId" required>
          <option value="">Select Book</option>
          <% if (bookList != null && bookAvailableMap != null) {
               for (Book book : bookList) {
                   Boolean available = bookAvailableMap.get(book.getBookId());
                   if (available != null && available) { %>
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