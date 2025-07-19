<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
}

.book p {
    font-size: 0.9rem;
    color: #666;
    margin-bottom: 1rem;
}
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
					<a href="#" class="nav-link">Home</a>
				</li>
				<li class ="nav-item">
					<a href="#" class="nav-link">Search</a>
				</li>
				<li class ="nav-item">
					<a href="#" class="nav-link">Reserve</a>
				</li>
				<li class ="nav-item">
					<a href="#" class="nav-link">Issue</a>
				</li>
				<li class ="nav-item">
					<a href="#" class="nav-link">Fine</a>
				</li>
				<li class ="nav-item">
					<a href="Logout.jsp" class="nav-link">Log Out</a>
				</li>
			</ul>
		</nav>s
	</header>
	
	<div class="main-content">
        <h2>Welcome to Our Library!</h2>
        <p>Discover a wide range of books and resources. Use the menu above to navigate through the system.</p>

        <!-- Categories -->
        <div class="category">
            <h2>Best of Non-Fiction</h2>
            <div class="books">
                <div class="book">
                    <img src="image/Malaysian Economy.png" alt="Malaysian Economy">
                    <h3>The Malaysian Economy</h3>
                    <p>by Shankaran Nambiar</p>   
                </div>
                <div class="book">
                    <img src="image/Investigating Sherlock.png" alt="Investigating Sherlock">
                    <h3>Investigating Sherlock</h3>
                    <p>by Nikki Stafford</p>
                </div>
                <div class="book">
                    <img src="image/A Day with the Prophet.png" alt="A Day with the Prophet">
                    <h3>A Day with the Prophet</h3>
                    <p>by Ahmad Von Denffer</p>
                </div>
                <div class="book">
                    <img src="image/The Jimmy Choo Story.png" alt="The Jimmy Choo Story">
                    <h3>The Jimmy Choo Story</h3>
                    <p>by Lauren Goldstein Crowe</p>
                </div>
                <div class="book">
                    <img src="image/How Star Wars Conquered the Universe.png" alt="How Star Wars Conquered the Universe">
                    <h3>How Star Wars Conquered the Universe</h3>
                    <p>by Chris Taylor</p>
                </div>
            </div>
        </div>

        <div class="category">
            <h2>Recently Added</h2>
            <div class="books">
                <div class="book">
                    <img src="recent1.jpg" alt="New Book 1">
                    <h3>New Book 1</h3>
                    <p>by Author Name</p>
                </div>
                <div class="book">
                    <img src="recent2.jpg" alt="New Book 2">
                    <h3>New Book 2</h3>
                    <p>by Author Name</p>
                </div>
                <div class="book">
                    <img src="recent2.jpg" alt="New Book 2">
                    <h3>New Book 2</h3>
                    <p>by Author Name</p>
                </div>
                <div class="book">
                    <img src="recent2.jpg" alt="New Book 2">
                    <h3>New Book 2</h3>
                    <p>by Author Name</p>
                </div>
                <div class="book">
                    <img src="recent2.jpg" alt="New Book 2">
                    <h3>New Book 2</h3>
                    <p>by Author Name</p>
                </div>
            </div>
        </div>

        <div class="category">
            <h2>Fiction</h2>
            <div class="books">
                <div class="book">
                    <img src="fiction1.jpg" alt="Fiction Book 1">
                    <h3>Fiction Book 1</h3>
                    <p>by Author Name</p>
                </div>
                <div class="book">
                    <img src="fiction2.jpg" alt="Fiction Book 2">
                    <h3>Fiction Book 2</h3>
                    <p>by Author Name</p>
                </div>
                <div class="book">
                    <img src="recent2.jpg" alt="New Book 2">
                    <h3>New Book 2</h3>
                    <p>by Author Name</p>
                </div>
                <div class="book">
                    <img src="recent2.jpg" alt="New Book 2">
                    <h3>New Book 2</h3>
                    <p>by Author Name</p>
                </div>
                <div class="book">
                    <img src="recent2.jpg" alt="New Book 2">
                    <h3>New Book 2</h3>
                    <p>by Author Name</p>
                </div>
            </div>
        </div>
    </div>
</body>
</html>