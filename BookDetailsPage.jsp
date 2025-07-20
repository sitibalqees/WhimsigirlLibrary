<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    library.model.Book book = (library.model.Book) request.getAttribute("book");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${book.title} - Book Details</title>
    <style>
        body { font-family: 'Poppins', sans-serif; background: #f4e1e4; margin: 0; }
        .container { max-width: 600px; margin: 40px auto; background: #fff; border-radius: 10px; box-shadow: 0 4px 16px rgba(0,0,0,0.1); padding: 30px; }
        .book-cover { width: 100%; max-width: 220px; display: block; margin: 0 auto 20px auto; border-radius: 8px; }
        h1 { text-align: center; color: #b68d40; margin-bottom: 10px; }
        .details { margin-bottom: 20px; }
        .details p { margin: 8px 0; color: #333; }
        .availability { display: inline-block; padding: 4px 8px; border-radius: 4px; font-size: 0.9rem; font-weight: bold; margin-top: 10px; }
        .available { background-color: #d4edda; color: #155724; }
        .not-available { background-color: #f8d7da; color: #721c24; }
        .btn-reserve { background:#28a745; color:#fff; border:none; padding:10px 24px; border-radius:4px; cursor:pointer; font-size:1rem; margin-top:20px; }
        .btn-reserve:hover { background:#218838; }
        .btn-back { background:#007bff; color:#fff; border:none; padding:8px 18px; border-radius:4px; cursor:pointer; font-size:1rem; margin-top:20px; margin-right:10px;}
        .btn-back:hover { background:#0056b3; }
        .synopsis { background: #faf4f5; border-radius: 6px; padding: 12px; margin-top: 15px; color: #444; }
    </style>
</head>
<body>
    <div class="container">
        <img src="image?bookId=${book.bookId}" alt="${book.title}" class="book-cover">
        <h1>${book.title}</h1>
        <div class="details">
            <p><strong>Author:</strong> ${book.authorName}</p>
            <p><strong>Category:</strong> ${book.category}</p>
            <p><strong>ISBN:</strong> ${book.isbn}</p>
            <p><strong>Publisher:</strong> ${book.publisher}</p>
            <p><strong>Year:</strong> ${book.publishYear}</p>
            <p><strong>Price:</strong> RM ${book.price}</p>
            <c:choose>
                <c:when test="${bookAvailableMap[book.bookId]}">
                    <span class="availability available">Available</span>
                </c:when>
                <c:otherwise>
                    <span class="availability not-available">Not Available</span>
                </c:otherwise>
            </c:choose>
        </div>
        <div class="synopsis">
            <strong>Synopsis:</strong>
            <p>${book.synopsis}</p>
        </div>
        <c:if test="${bookAvailableMap[book.bookId]}">
            <button class="btn-reserve" onclick="window.location.href='ReserveController?bookId=${book.bookId}'">Reserve</button>
        </c:if>
        <a href="HomeController" class="btn-back">Back to Library</a>
    </div>
</body>
</html>