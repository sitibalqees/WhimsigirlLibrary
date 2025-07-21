package library.controller;

import java.io.IOException;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import library.model.Book;
import library.DAO.AddBookDAO;

@WebServlet("/AddBookServlet")
public class AddBookController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get form parameters
        String bookId = request.getParameter("bookId");
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String isbn = request.getParameter("isbn");
        String category = request.getParameter("category");

        // Simple validation
        if (bookId == null || title == null || author == null || isbn == null || category == null ||
            bookId.isEmpty() || title.isEmpty() || author.isEmpty() || isbn.isEmpty() || category.isEmpty()) {
            request.setAttribute("errorMessage", "All fields are required.");
            request.getRequestDispatcher("add.jsp").forward(request, response);
            return;
        }

        // Create Book object
        Book book = new Book();
        book.setBookId(bookId);
        book.setTitle(title);
        book.setAuthor(author);
        book.setIsbn(isbn);
        book.setCategory(category);

        // Call DAO to add book
        try {
            boolean success = AddBookDAO.addBook(book);

            if (success) {
                response.sendRedirect("add.jsp?status=success");
            } else {
                request.setAttribute("errorMessage", "Failed to add book. Book ID or ISBN may already exist.");
                request.getRequestDispatcher("add.jsp").forward(request, response);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error. Please try again.");
            request.getRequestDispatcher("add.jsp").forward(request, response);
        }
    }
}
