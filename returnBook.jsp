<%@ page import="java.util.List" %>
<%@ page import="library.model.Admin" %>
<%@ page import="library.model.Reserve" %>
<%@ page import="library.model.Book" %>
<%@ page import="library.DAO.BookDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Return Book</title>
    <style>
        body { background-color: #e7d3d3; font-family: Arial, sans-serif; margin: 0; }
        .admin-navbar {
            background-color: #3c0d0d;
            color: #fff;
            display: flex;
            align-items: center;
            padding: 10px 20px;
            height: 60px;
            justify-content: space-between;
        }
        .admin-title {
            font-size: 25.6px;
            font-weight: bold;
            font-family: 'Georgia', serif;
            letter-spacing: 0.5px;
        }
        .admin-menu {
            display: flex;
            gap: 32px;
        }
        .admin-menu a {
            color: #fff;
            text-decoration: none;
            font-size: 16px;
            font-weight: 500;
            transition: color 0.2s;
        }
        .admin-menu a:hover, .admin-menu a.active {
            color: #ffd7d7;
            text-decoration: underline;
        }
        .logout-link {
            margin-left: 32px;
            color: #f4e1e4;
            font-weight: bold;
            text-decoration: none;
            border: 1px solid #f4e1e4;
            border-radius: 4px;
            padding: 6px 16px;
            transition: background 0.2s, color 0.2s;
        }
        .logout-link:hover {
            background: #f4e1e4;
            color: #3c0d0d;
        }
        .return-container {
            background: #f5cfcf;
            max-width: 500px;
            margin: 48px auto;
            border-radius: 16px;
            box-shadow: 0 4px 16px rgba(0,0,0,0.08);
            padding: 40px 32px 32px 32px;
            display: flex;
            flex-direction: column;
            align-items: stretch;
        }
        .return-container h2 {
            text-align: center;
            color: #7a2e2e;
            margin-bottom: 32px;
        }
        .form-group { margin-bottom: 18px; }
        label { font-weight: bold; color: #7a2e2e; }
        select, input[type=text], input[type=date] {
            width: 100%;
            padding: 10px;
            border-radius: 6px;
            border: 1px solid #e6bcbc;
            margin-top: 4px;
        }
        .return-btn {
            background: #c44d4d;
            color: #fff;
            border: none;
            border-radius: 6px;
            padding: 14.4px;
            font-size: 17.6px;
            font-weight: bold;
            cursor: pointer;
            margin-top: 16px;
            transition: background 0.2s;
        }
        .return-btn:hover { background: #a83a3a; }
        .message { text-align: center; margin-bottom: 16px; }
        .success { color: green; }
        .error { color: red; }
        .returned-list { margin-top: 32px; }
        .returned-list table { width: 100%; border-collapse: collapse; }
        .returned-list th, .returned-list td { border: 1px solid #ccc; padding: 8px; text-align: left; }
        .returned-list th { background: #e7d3d3; }
        @media (max-width: 600px) {
            .return-container { padding: 18px 6px; }
            .admin-navbar { flex-direction: column; align-items: flex-start; padding: 10px 10px; }
            .admin-menu { flex-direction: column; gap: 10px; }
            .logout-link { margin-left: 0; margin-top: 10px; }
        }
    </style>
    <script>
    function showDueDate() {
        var select = document.getElementById('reserveId');
        var dueDate = select.options[select.selectedIndex].getAttribute('data-duedate');
        document.getElementById('dueDate').value = dueDate ? dueDate : '';
    }
    </script>
</head>
<body>
    <div class="admin-navbar">
        <span class="admin-title">Library Admin</span>
        <div class="admin-menu">
            <a href="AdminPage.jsp">Home</a>
            <a href="AddBook.jsp">Add Book</a>
            <a href="BookController?action=list">Update Book</a>
            <a href="RemoveBook.jsp">Delete Book</a>
            <a href="ReturnBookController" class="active">Return Book</a>
            <a class="logout-link" href="Logout.jsp">Log Out</a>
        </div>
    </div>
    <div class="return-container">
        <h2>Return a Book</h2>
        <% if (request.getAttribute("message") != null) { %>
            <div class="message"><%= request.getAttribute("message") %></div>
        <% } %>
        <!-- Username search form -->
        <form action="ReturnBookController" method="get">
            <div class="form-group">
                <label for="username">User Username:</label>
                <input type="text" name="username" id="username" required value="<%= request.getParameter("username") != null ? request.getParameter("username") : "" %>">
                <button type="submit">Search</button>
            </div>
        </form>
        <!-- Return book form -->
        <form action="ReturnBookController" method="post">
            <div class="form-group">
                <label for="adminId">Admin:</label>
                <select name="adminId" id="adminId" required>
                    <option value="">Select Admin</option>
                    <% 
                        List<Admin> admins = (List<Admin>) request.getAttribute("admins");
                        if (admins != null) {
                            for (Admin admin : admins) {
                    %>
                        <option value="<%= admin.getAdminId() %>"><%= admin.getAdminId() %> - <%= admin.getAdminName() %></option>
                    <%      }
                        }
                    %>
                </select>
            </div>
            <div class="form-group">
                <label for="reserveId">Reserved Book:</label>
                <select name="reserveId" id="reserveId" required onchange="showDueDate()">
                    <option value="">Select a reserved book</option>
                    <%
                        List<Reserve> reserves = (List<Reserve>) request.getAttribute("reserves");
                        if (reserves != null) {
                            for (Reserve reserve : reserves) {
                                Book book = BookDAO.getBookById(reserve.getBookId());
                                String bookTitle = (book != null) ? book.getTitle() : "Unknown Title";
                    %>
                        <option value="<%= reserve.getReserveId() %>" data-duedate="<%= reserve.getDueDate() %>">
                            <%= bookTitle %> (Due: <%= reserve.getDueDate() %>)
                        </option>
                    <%
                            }
                        }
                    %>
                </select>
            </div>
            <div class="form-group">
                <label for="dueDate">Due Date:</label>
                <input type="text" id="dueDate" name="dueDate" readonly>
            </div>
            <div class="form-group">
                <label for="returnDate">Return Date:</label>
                <input type="date" name="returnDate" id="returnDate" required>
            </div>
            <input type="hidden" name="username" value="<%= request.getParameter("username") != null ? request.getParameter("username") : "" %>">
            <input type="submit" value="Return Book" class="return-btn">
        </form>
       <!-- returnBook.jsp (table part only) -->
<div class="returned-list">
    <h3>Recently Returned Books</h3>
    <table>
        <tr>
            <th>ReturnID</th>
            <th>Admin</th>
            <th>User</th>
            <th>Return Date</th>
        </tr>
        <%
            List<Object[]> returned = (List<Object[]>) request.getAttribute("returnedBooks");
            if (returned != null && !returned.isEmpty()) {
                for (Object[] row : returned) {
        %>
        <tr>
            <td><%= row[0] %></td>
            <td><%= row[1] %></td>
            <td><%= row[2] %></td>
            <td><%= row[3] %></td>
        </tr>
        <%
                }
            } else { %>
        <tr><td colspan="4" style="text-align:center;">No books returned yet.</td></tr>
        <% } %>
    </table>
</div>
    </div>
</body>
</html>