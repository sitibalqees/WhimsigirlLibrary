<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Whimsigirl Library - Home Page</title>
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

/* Main Content */
.main-content {
    padding: 2rem;
    justify-content: center;
    background-color: #f4e1e4;
    min-height: 100vh;
}
.main-content h2 {
    color: #b68d40;
    font-size: 1.8rem;
    margin-bottom: 1rem;
}

.main-content p {
    margin-bottom: 2rem;
    font-size: 1.2rem;
}

/* Categories */
.category {
    margin-bottom: 3rem;
}

.books {
    display: flex;
    flex-wrap: wrap;
    gap: 1rem;
    justify-content: flex-start;
}

.book {
    background-color: white;
    border: 1px solid #ddd;
    border-radius: 8px;
    width: 180px;
    text-align: center;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    transition: transform 0.2s ease;
    padding-bottom: 10px;
}

.book:hover {
    transform: translateY(-5px);
    box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
}

.book img {
    width: 100%;
    height: 220px;
    border-top-left-radius: 8px;
    border-top-right-radius: 8px;
    object-fit: cover;
}

.book h3 {
    font-size: 1rem;
    margin: 0.5rem 0;
    color: #333;
    padding: 0 5px;
    line-height: 1.3;
}

.book p {
    font-size: 0.9rem;
    color: #666;
    margin-bottom: 0.5rem;
    padding: 0 5px;
}

.book-category {
    font-size: 0.8rem;
    color: #888;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    margin-bottom: 0.5rem;
}

.availability {
    display: inline-block;
    padding: 4px 8px;
    border-radius: 4px;
    font-size: 0.8rem;
    font-weight: bold;
    margin-top: 5px;
}

.available {
    background-color: #d4edda;
    color: #155724;
}

.not-available {
    background-color: #f8d7da;
    color: #721c24;
}

.no-books {
    text-align: center;
    color: #666;
    font-size: 18px;
    margin-top: 50px;
    width: 100%;
}

.featured {
    border: 2px solid #f3961c;
}
.modal { display:none; position:fixed; z-index:1000; left:0; top:0; width:100%; height:100%; overflow:auto; background:rgba(0,0,0,0.4);}
.modal-content { background:#fff; margin:10% auto; padding:20px; border-radius:8px; width:90%; max-width:500px; position:relative;}
.close { position:absolute; top:10px; right:20px; font-size:28px; font-weight:bold; cursor:pointer;}
.btn-details { margin-top:10px; background:#007bff; color:#fff; border:none; padding:8px 16px; border-radius:4px; cursor:pointer;}
.btn-details:hover { background:#0056b3; }
.btn-reserve { background:#28a745; color:#fff; border:none; padding:8px 16px; border-radius:4px; cursor:pointer;}
.btn-reserve:hover { background:#218838; }
</style>
</head>
<body>
	<header>
		<nav class="navbar section-content">
			<a href="#" class="nav-logo">
			<img src="image/Whimsigirl Logo.jpg" alt="Library Logo" class="logo-image">
				<h2 class ="logo-text">Whimsigirl Library</h2>
			</a>
			<ul class="nav-menu">
				<li class ="nav-item">
					<a href="HomeController" class="nav-link">Home</a>
				</li>
				<li class ="nav-item">
					<a href="" class="nav-link">Search</a>
				</li>
				<li class ="nav-item">
					<a href="ReserveBook.jsp" class="nav-link">Reserve</a>
				</li>
				<li class ="nav-item">
					<a href="IssueBook.jsp" class="nav-link">Issue</a>
				</li>
				<li class ="nav-item">
					<a href="#" class="nav-link">Fine</a>
				</li>
				<li class ="nav-item">
					<a href="#" class="nav-link">Log Out</a>
				</li>
			</ul>
		</nav>
	</header>
	
	<div class="main-content">
        <h2>Welcome to Our Library!</h2>
        <p>Discover a wide range of books and resources. Use the menu above to navigate through the system.</p>

        <!-- Non Fiction Books -->
        <div class="category">
            <h2>Non Fiction</h2>
            <div class="books">
                <c:forEach var="book" items="${books}">
                    <c:if test="${fn:toLowerCase(book.category) eq 'non fiction'}">
                        <div class="book">
    						<img src="image?bookId=${book.bookId}" alt="${book.title}">
    						<h3>${book.title}</h3>
    						<p>by ${book.authorName}</p>
    						<c:if test="${book.availability == 1}">
        						<span class="availability available">Available</span>
    						</c:if>
    						<c:if test="${book.availability == 0}">
        						<span class="availability not-available">Not Available</span>
    						</c:if>
    						<a href="BookController?action=fullDetails&bookId=${book.bookId}" class="btn-details" style="margin-top:8px;display:inline-block;">View Full Details</a>
						</div>
                    </c:if>
                </c:forEach>
            </div>
        </div>

        <!-- Fiction Books -->
        <div class="category">
            <h2>Fiction</h2>
            <div class="books">
                <c:forEach var="book" items="${books}">
                    <c:if test="${fn:toLowerCase(book.category) eq 'fiction'}">
                        <div class="book">
                            <img src="image?bookId=${book.bookId}" alt="${book.title}">
                            <h3>${book.title}</h3>
                            <p>by ${book.authorName}</p>
                            <c:if test="${book.availability == 1}">
                                <span class="availability available">Available</span>
                            </c:if>
                            <c:if test="${book.availability == 0}">
                                <span class="availability not-available">Not Available</span>
                            </c:if>
                            <a href="BookController?action=fullDetails&bookId=${book.bookId}" class="btn-details" style="margin-top:8px;display:inline-block;">View Full Details</a>
                        </div>
                    </c:if>
                </c:forEach>
            </div>
        </div>

        <!-- Book Details Modal -->
        <div id="bookDetailsModal" class="modal">
          <div class="modal-content">
            <span class="close" onclick="closeModal()">&times;</span>
            <div id="bookDetailsContent">
              <!-- Book details will be loaded here -->
            </div>
          </div>
        </div>
    </div>
    <script>
    function showBookDetails(bookId) {
        fetch('BookController?action=details&bookId=' + bookId)
            .then(response => response.text())
            .then(html => {
                document.getElementById('bookDetailsContent').innerHTML = html;
                document.getElementById('bookDetailsModal').style.display = 'block';
            });
    }
    function closeModal() {
        document.getElementById('bookDetailsModal').style.display = 'none';
    }
    window.onclick = function(event) {
        var modal = document.getElementById('bookDetailsModal');
        if (event.target == modal) {
            closeModal();
        }
    }
    </script>
</body>
</html>