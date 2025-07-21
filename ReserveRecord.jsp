<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Set" %>
<%@ page import="library.model.Reserve" %>
<%@ page import="library.model.Book" %>
<%@ page import="library.DAO.BookDAO" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Reservations</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f4f4f4; margin: 0; padding: 0; }
        .navbar {
            background-color: #3c0d0d;
            color: white;
            padding: 10px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .nav-logo { display: flex; align-items: center; text-decoration: none; color: white; }
        .logo-image { height: 40px; border-radius: 50%; margin-right: 10px; }
        .logo-text { font-family: 'Georgia', serif; font-size: 24px; }
        .nav-menu { list-style: none; display: flex; gap: 20px; margin: 0; padding: 0; }
        .nav-link { color: white; text-decoration: none; font-size: 16px; padding: 5px 10px; border-radius: 5px; transition: background-color 0.3s; }
        .nav-link:hover { background-color: #5a1e1e; }
        .container { max-width: 800px; margin: 20px auto; background: #fff; padding: 20px; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
        h2 { color: #333; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { padding: 12px; border: 1px solid #ddd; text-align: left; }
        th { background-color: #3c0d0d; color: white; }
        tr:nth-child(even) { background-color: #f2f2f2; }
        .status-returned { color: green; font-weight: bold; }
        .status-not-returned { color: red; font-weight: bold; }
        .no-records { text-align: center; color: #777; padding: 20px; }
        .issue-btn {
            background-color: #c44d4d;
            color: white;
            border: none;
            padding: 8px 12px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
            transition: background-color 0.3s;
        }
        .issue-btn:hover { background-color: #a83a3a; }
    </style>
</head>
<body>
    <header>
        <nav class="navbar">
            <a href="HomeController" class="nav-logo">
                <img src="image/Whimsigirl Logo.jpg" alt="Library Logo" class="logo-image">
                <h2 class="logo-text">Whimsigirl Library</h2>
            </a>
            <ul class="nav-menu">
                <li class="nav-item"><a href="HomeController" class="nav-link">Home</a></li>
                <li class="nav-item"><a href="#" class="nav-link">Search</a></li>
                <li class="nav-item"><a href="ReserveController?action=listUser" class="nav-link">My Reservation</a></li>
                <li class="nav-item"><a href="IssueController?action=listUser" class="nav-link">Issue Record</a></li>
                <li class="nav-item"><a href="#" class="nav-link">Fine</a></li>
                <li class="nav-item"><a href="Logout.jsp" class="nav-link">Log Out</a></li>
            </ul>
        </nav>
    </header>
    <div class="container">
        
        <c:choose>
            <c:when test="${empty reserves}">
                <div class="no-records">
                    <h2>My Reservation Records</h2>
                    <p>You have no reservation records.</p>
                </div>
            </c:when>
            <c:otherwise>
                <h2>My Reservation Records</h2>
                
                <%-- Pre-computation block to avoid errors --%>
                <%
                    List<Reserve> reserves = (List<Reserve>) request.getAttribute("reserves");
                    Set<Integer> returnedReserveIds = (Set<Integer>) request.getAttribute("returnedReserveIds");
                    
                    List<String> statusList = new ArrayList<>();
                    List<String> colorClassList = new ArrayList<>();

                    if (reserves != null) {
                        for (Reserve reserve : reserves) {
                            boolean isReturned = returnedReserveIds != null && returnedReserveIds.contains(reserve.getReserveId());
                            if (isReturned) {
                                statusList.add("Returned");
                                colorClassList.add("status-returned");
                            } else {
                                statusList.add("Not Returned");
                                colorClassList.add("status-not-returned");
                            }
                        }
                    }
                    pageContext.setAttribute("statusList", statusList);
                    pageContext.setAttribute("colorClassList", colorClassList);
                %>

                <table>
                    <thead>
                        <tr>
                            <th>Book Title</th>
                            <th>Reserve Date</th>
                            <th>Due Date</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="reserve" items="${reserves}" varStatus="loop">
                            <tr>
                                <td>${books[loop.index].title}</td>
                                <td>${reserve.reserveDate}</td>
                                <td>${reserve.dueDate}</td>
                                <td>
                                    <span class="${colorClassList[loop.index]}">
                                        ${statusList[loop.index]}
                                    </span>
                                </td>
                                <td>
                                    <c:if test="${statusList[loop.index] == 'Not Returned'}">
                                        <form action="IssueController" method="get" style="margin:0;">
                                            <input type="hidden" name="action" value="report"/>
                                            <input type="hidden" name="bookID" value="${reserve.bookId}"/>
                                            <button type="submit" class="issue-btn">Issue</button>
                                        </form>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>