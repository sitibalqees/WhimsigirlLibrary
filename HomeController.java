package library.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import library.model.Book;
import library.DAO.BookDAO;
import library.DAO.ReserveDAO;

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

            // Get selected date range from request (or default to today)
            String reserveDateStr = request.getParameter("reserveDate");
            String dueDateStr = request.getParameter("dueDate");
            Date selectedReserveDate = (reserveDateStr != null && !reserveDateStr.isEmpty())
                ? Date.valueOf(reserveDateStr)
                : new Date(System.currentTimeMillis());
            Date selectedDueDate = (dueDateStr != null && !dueDateStr.isEmpty())
                ? Date.valueOf(dueDateStr)
                : selectedReserveDate;

            // Build a map of bookId -> availability for the selected date range
            Map<Integer, Boolean> bookAvailableMap = new HashMap<>();
            for (Book book : books) {
                boolean available = ReserveDAO.isBookAvailable(book.getBookId(), selectedReserveDate, selectedDueDate);
                bookAvailableMap.put(book.getBookId(), available);
            }

            request.setAttribute("books", books);
            request.setAttribute("bookAvailableMap", bookAvailableMap);
            request.setAttribute("selectedReserveDate", selectedReserveDate);
            request.setAttribute("selectedDueDate", selectedDueDate);

            // You can also add featured books logic here if needed
            List<Book> featuredBooks = books.stream()
                .filter(book -> bookAvailableMap.get(book.getBookId()))
                .limit(5)
                .collect(java.util.stream.Collectors.toList());
            request.setAttribute("featuredBooks", featuredBooks);

            // Forward to HomePage.jsp
            RequestDispatcher dispatcher = request.getRequestDispatcher("HomePage.jsp");
            dispatcher.forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error loading books: " + e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("HomePage.jsp");
            dispatcher.forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}