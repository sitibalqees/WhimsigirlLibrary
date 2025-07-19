<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Update Book</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f4e1e4;
      margin: 0;
      padding: 0;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
    }

    .update-container {
      background-color: white;
      padding: 30px;
      border-radius: 10px;
      box-shadow: 0 0 10px rgba(0,0,0,0.1);
      width: 400px;
    }

    h2 {
      text-align: center;
      margin-bottom: 20px;
    }

    label {
      display: block;
      margin-top: 15px;
      font-weight: bold;
    }

    input, select {
      width: 100%;
      padding: 10px;
      margin-top: 5px;
      border: 1px solid #ccc;
      border-radius: 5px;
    }

    button {
      margin-top: 20px;
      width: 100%;
      padding: 12px;
      background-color: #a23c3c;
      border: none;
      color: white;
      font-size: 16px;
      border-radius: 5px;
      cursor: pointer;
    }

    button:hover {
      background-color: #45a049;
    }
  </style>
</head>
<body>
	
  <div class="update-container">
    <h2>Update Book</h2>
    <form action="update_book.php" method="POST">
      <label for="bookId">Book ID</label>
      <input type="text" id="bookId" name="bookId" required />

      <label for="title">Title</label>
      <input type="text" id="title" name="title" required />

      <label for="author">Author</label>
      <input type="text" id="author" name="author" required />

      <label for="isbn">ISBN</label>
      <input type="text" id="isbn" name="isbn" required />

      <label for="category">Category</label>
      <input type="text" id="category" name="category" />

      <label for="availability">Availability</label>
      <select id="availability" name="availability">
        <option value="available">Available</option>
        <option value="checked_out">Checked Out</option>
        <option value="reserved">Reserved</option>
      </select>

      <button type="submit">Update Book</button>
    </form>
  </div>

</body>
</html>
