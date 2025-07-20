package library.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import library.model.Book;
import library.DAO.BookDAO;

@WebServlet("/HomeController")
public class HomeController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public HomeController() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Get all books from database
            List<Book> books = BookDAO.getAllBooks();
            request.setAttribute("books", books);
            
            // You can also add featured books logic here if needed
            // For example, get books with availability = 1 as featured
            List<Book> featuredBooks = books.stream()
                .filter(book -> book.getAvailability() == 1)
                .limit(5) // Limit to 5 featured books
                .collect(java.util.stream.Collectors.toList());
            request.setAttribute("featuredBooks", featuredBooks);
            
            // Forward to HomePage.jsp
            RequestDispatcher dispatcher = request.getRequestDispatcher("HomePage.jsp");
            dispatcher.forward(request, response);
            
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle error - you can set an error message
            request.setAttribute("error", "Error loading books: " + e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("HomePage.jsp");
            dispatcher.forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}