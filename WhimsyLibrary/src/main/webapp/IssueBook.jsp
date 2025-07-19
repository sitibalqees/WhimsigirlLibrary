<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
/* Import Google fonts */
@import url('https://fonts.googleapis.com/css2?family=Miniver&family=Poppins:ital,wght@0,400;0,500;0,600;0,700;1,400&display=swap');

/* Logo Styling */
.nav-logo {
    display: flex;
    align-items: center;
    gap: 10px; /* Space between the logo and text */
    text-decoration: none; /* Remove underline */
}

.logo-image {
    height: 40px; /* Adjust size of the logo */
    width: auto; /* Maintain aspect ratio */
    border-radius: 50%; /* Optional: make the logo circular */
}

.logo-text {
    color: var(--white-color); /* Ensure text matches your color scheme */
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
	/* Colors*/
	--white-color: #fff;
	--dark-color: #252525;
	--primary-color: #3b141c;
	--secondary-color: #f3961c;
	--light-pink-color: #faf4f5;
	--medium-gray-color: #ccc;
	
	/* Font Size*/
	--font-size-s:0.9rem;
	--font-size-n:1rem;
	--font-size-m:1.12rem;
	--font-size-l:1.5rem;
	--font-size-xl:2rem;
	--font-size-xxl:2.3rem;
	
	/* Font Weight*/
	--font-weight-normal:400;
	--font-weight-medium:500;
	--font-weight-semibold:600;
	--font-weight-bold:700;
	
	/* Border radius*/
	--border-radius-s:8px;
	--border-radius-m:30px;
	--border-radius-circle:50%;
	
	/* Site max width*/
	--site-max-width:1300px;
}

/*Styling for whole site*/
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

.navbar .nav-menu .navlnk:hover{
	color: #3b141c;
	background: #f3961c;
}

/*--------------------------------------------------------------*/
/* Main Content */
.main-content {
    padding: 2rem;
    justify-content: center;
    background-color: #f4e1e4; /* Light pink background */
    min-height: 100vh;
}
.main-content h2 {
    color: #b68d40; /* Soft brown */
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
/*-------------------------------------------------------------*/
/* Issue Page Styling */
.issue-page {
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 2rem;
    background-color:#f4e1e4; /* Light pink background */
    min-height: 100vh;
}

.form-container {
    background-color: #ffffff; /* White form background */
    padding: 2rem;
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    max-width: 500px;
    width: 100%;
}

/* Form Title and Description */
.form-title {
    font-size: 1.8rem;
    color:#c44d4d; /* red pink */
    margin-bottom: 1rem;
    text-align: center;
}

.form-description {
    font-size: 1rem;
    color: #333333; /* Dark gray */
    margin-bottom: 1.5rem;
    text-align: center;
    line-height: 1.5;
}

/* Form Styling */
.issue-form {
    display: flex;
    flex-direction: column;
    gap: 1rem;
}

.form-group label {
    font-size: 1rem;
    color: #333333; /* Dark gray */
    margin-bottom: 0.5rem;
}

.form-group input,
.form-group textarea {
    font-size: 1rem;
    padding: 0.8rem;
    border: 1px solid #ddd;
    border-radius: 8px;
    background-color: #fff; /* White background */
    transition: border-color 0.3s ease, box-shadow 0.3s ease;
    width: 100%;
    resize: none;
}

.form-group input:focus,
.form-group textarea:focus {
    border-color: #b68d40; /* Soft brown */
    box-shadow: 0 0 5px rgba(182, 141, 64, 0.3);
}

/* File Upload Styling */
.form-group input[type="file"] {
    font-size: 0.9rem;
    padding: 0.5rem;
    border: 1px solid #ddd;
    border-radius: 8px;
    background-color: #fff;
    transition: border-color 0.3s ease;
}

.file-hint {
    font-size: 0.85rem;
    color: #666666; /* Muted gray */
    margin-top: 0.3rem;
}

/* Submit Button */
.form-actions {
    display: flex;
    justify-content: center;
}

.submit-btn {
    padding: 0.8rem 2rem;
    font-size: 1rem;
    color: #ffffff; /* White text */
    background-color: #c44d4d; /* Muted green */
    border: none;
    border-radius: 8px;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

.submit-btn:hover {
    background-color: #c44d4d; /* Darker green */
}
/*--------------------------------------------------------------*/
/* Delete Book Page Styling */
.deleteBook-page {
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 2rem;
    background-color: #f4e1e4; /* Light pink background */
    min-height: 100vh;
}

.form-container {
    background-color: #ffffff; /* White form background */
    padding: 2rem;
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    max-width: 500px;
    width: 100%;
}

/* Form Title and Description */
.form-title {
    font-size: 1.8rem;
    color: #b68d40; /* Soft brown */
    margin-bottom: 1rem;
    text-align: center;
}

.form-description {
    font-size: 1rem;
    color: #333333; /* Dark gray */
    margin-bottom: 1.5rem;
    text-align: center;
    line-height: 1.5;
}

/* Form Styling */
.issue-form {
    display: flex;
    flex-direction: column;
    gap: 1rem;
}

.form-group label {
    font-size: 1rem;
    color: #333333; /* Dark gray */
    margin-bottom: 0.5rem;
}

.form-group input,
.form-group textarea {
    font-size: 1rem;
    padding: 0.8rem;
    border: 1px solid #ddd;
    border-radius: 8px;
    background-color: #fff; /* White background */
    transition: border-color 0.3s ease, box-shadow 0.3s ease;
    width: 100%;
    resize: none;
}

.form-group input:focus,
.form-group textarea:focus {
    border-color: #b68d40; /* Soft brown */
    box-shadow: 0 0 5px rgba(182, 141, 64, 0.3);
}

/* File Upload Styling */
.form-group input[type="file"] {
    font-size: 0.9rem;
    padding: 0.5rem;
    border: 1px solid #ddd;
    border-radius: 8px;
    background-color: #fff;
    transition: border-color 0.3s ease;
}

.file-hint {
    font-size: 0.85rem;
    color: #666666; /* Muted gray */
    margin-top: 0.3rem;
}

/* Submit Button */
.form-actions {
    display: flex;
    justify-content: center;
}

.submit-btn {
    padding: 0.8rem 2rem;
    font-size: 1rem;
    color: #ffffff; /* White text */
    background-color: #c44d4d; /*red color*/
    border: none;
    border-radius: 8px;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

.submit-btn:hover {
    background-color: #c44d4d; 
}
/*------------------------------------------------------------*/
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
					<a href="#" class="nav-link">Log Out</a>
				</li>
			</ul>
		</nav>
	</header>

    <main class="issue-page">
        <div class="form-container">
            <h2 class="form-title">Report an Issue with Your Book</h2>
            <p class="form-description">
                Encountered a problem with a borrowed book? Fill out this form to let us know. Upload an image if necessary.
            </p>

            <form action="#" method="POST" class="issue-form" enctype="multipart/form-data">
                <div class="form-group">
                    <label for="name">Name</label>
                    <input type="text" id="name" name="name" placeholder="Enter your full name" required>
                </div>
                <div class="form-group">
                    <label for="ic-number">IC Number</label>
                    <input type="text" id="ic-number" name="ic-number" placeholder="Enter your IC number" required>
                </div>
                <div class="form-group">
                    <label for="book-id">Book ID</label>
                    <input type="text" id="book-id" name="book-id" placeholder="Enter the Book ID" required>
                </div>
                <div class="form-group">
                    <label for="issue">Issue</label>
                    <textarea id="issue" name="issue" rows="5" placeholder="Describe the issue (e.g., torn pages, cover damage)" required></textarea>
                </div>
                <div class="form-group">
                    <label for="proof">Upload Proof (Optional)</label>
                    <input type="file" id="proof" name="proof" accept="image/*">
                    <small class="file-hint">Accepted formats: JPEG, PNG (Max size: 5MB)</small>
                </div>
                <div class="form-actions">
                    <button type="submit" class="submit-btn">Submit Report</button>
                </div>
            </form>
        </div>
    </main>
</body>
</html>