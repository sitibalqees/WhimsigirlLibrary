<%@ page import="java.util.List" %>
<%@ page import="library.model.Reserve" %>
<%@ page import="library.model.Book" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    List<Reserve> reserves = (List<Reserve>) request.getAttribute("reserves");
    List<Book> books = (List<Book>) request.getAttribute("books");
    List<library.model.User> users = (List<library.model.User>) request.getAttribute("users");
%>
<!DOCTYPE html>
<html>
<head>
    <title>All Reservation Records</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Miniver&family=Poppins:wght@400;500;600;700&display=swap');
        body { font-family: 'Poppins', Arial, sans-serif; background: #faf4f5; margin: 0; }
        header { background: #3c0d0d; }
        .navbar { display: flex; padding: 20px; align-items: center; justify-content: space-between; max-width: 1300px; margin: 0 auto; }
        .nav-logo { display: flex; align-items: center; gap: 10px; text-decoration: none; }
        .logo-image { height: 40px; width: auto; border-radius: 50%; }
        .logo-text { color: #fff; font-size: 2rem; font-weight: 600; }
        .nav-menu { display: flex; gap: 10px; list-style: none; margin: 0; }
        .nav-item { }
        .nav-link { padding: 10px 18px; color: #fff; font-size: 1.12rem; border-radius: 30px; transition: 0.3s; text-decoration: none; }
        .nav-link:hover { color: #3b141c; background: #f3961c; }
        h2 { color: #c44d4d; margin-top: 2rem; text-align: center; }
        .records-container { max-width: 900px; margin: 2rem auto; background: #fff; border-radius: 12px; box-shadow: 0 4px 16px rgba(0,0,0,0.07); padding: 2rem; }
        table { border-collapse: collapse; width: 100%; background: #fff; border-radius: 8px; overflow: hidden; }
        th, td { border: 1px solid #eee; padding: 14px 10px; text-align: center; }
        th { background: #f3961c; color: #fff; font-size: 1.1rem; }
        tr:nth-child(even) { background: #f9f9f9; }
        tr:hover { background: #f4e1e4; }
        @media (max-width: 700px) {
            .records-container { padding: 0.5rem; }
            table, th, td { font-size: 0.95rem; }
            .navbar { flex-direction: column; gap: 10px; }
        }
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
                <li class="nav-item"><a href="AdminPage.jsp" class="nav-link">Admin Home</a></li>
                <li class="nav-item"><a href="BookController?action=list" class="nav-link">Books</a></li>
                <li class="nav-item"><a href="ReserveController?action=listAll" class="nav-link">All Reservations</a></li>
                <li class="nav-item"><a href="returnBook.jsp" class="nav-link">Return</a></li>
                <li class="nav-item"><a href="Logout.jsp" class="nav-link">Log Out</a></li>
            </ul>
        </nav>
    </header>
    <div class="records-container">
    <h2>All Reservation Records</h2>
    <!-- Sorting controls above the table -->
    <div style="margin-bottom: 1em; text-align: right;">
        <form method="get" action="ReserveController" style="display: inline;">
            <input type="hidden" name="action" value="listAll"/>
            <input type="hidden" name="sort" value="reserveDate"/>
            <input type="hidden" name="order" value="asc"/>
            <button type="submit" style="background:none;border:none;color:#c44d4d;cursor:pointer;">
                Reserve Date Ascending &#9650;
            </button>
        </form>
        <form method="get" action="ReserveController" style="display: inline;">
            <input type="hidden" name="action" value="listAll"/>
            <input type="hidden" name="sort" value="reserveDate"/>
            <input type="hidden" name="order" value="desc"/>
            <button type="submit" style="background:none;border:none;color:#c44d4d;cursor:pointer;">
                Reserve Date Descending &#9660;
            </button>
        </form>
    </div>
    <table>
        <tr>
            <th>Reserve ID</th>
            <th>User Name</th>
            <th>Book Title</th>
            <th>Reserve Date</th>
            <th>Due Date</th>
        </tr>
        <c:forEach var="reserve" items="${reserves}">
            <tr>
                <td>${reserve.reserveId}</td>
                <td>
                    <c:forEach var="user" items="${users}">
                        <c:if test="${user.userID == reserve.userId}">${user.userName}</c:if>
                    </c:forEach>
                </td>
                <td>
                    <c:forEach var="book" items="${books}">
                        <c:if test="${book.bookId == reserve.bookId}">${book.title}</c:if>
                    </c:forEach>
                </td>
                <td>${reserve.reserveDate}</td>
                <td>${reserve.dueDate}</td>
            </tr>
        </c:forEach>
    </table>
</div>
</body>
</html>