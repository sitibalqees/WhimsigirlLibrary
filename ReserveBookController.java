package library.controller;

import java.io.IOException;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import library.model.ReserveBook;
import library.DAO.ReserveBookDAO;

@WebServlet("/ReserveBookController")
public class ReserveBookController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get form parameters
        String bookTitle = request.getParameter("title");
        String author = request.getParameter("author");
        String category = request.getParameter("category");
        String icNo = request.getParameter("icno");
        String comments = request.getParameter("comments");

        // Simple validation
        if (bookTitle == null || author == null || category == null || icNo == null ||
            bookTitle.isEmpty() || author.isEmpty() || category.isEmpty() || icNo.isEmpty()) {
            request.setAttribute("errorMessage", "Please fill all required fields.");
            request.getRequestDispatcher("reservebook.jsp").forward(request, response);
            return;
        }

        // Create ReserveBook object
        ReserveBook reserve = new ReserveBook();
        reserve.setBookTitle(bookTitle);
        reserve.setAuthor(author);
        reserve.setCategory(category);
        reserve.setIcNo(icNo);
        reserve.setComments(comments);

        // Call DAO to reserve the book
        try {
            boolean isAvailable = ReserveBookDAO.isBookAvailable(bookTitle);
            if (!isAvailable) {
                request.setAttribute("errorMessage", "This book is not available for reservation.");
                request.getRequestDispatcher("reservebook.jsp").forward(request, response);
                return;
            }

            boolean success = ReserveBookDAO.reserveBook(reserve);
            if (success) {
                response.sendRedirect("reservebook.jsp?reserve=success");
            } else {
                request.setAttribute("errorMessage", "Reservation failed. Please try again.");
                request.getRequestDispatcher("reservebook.jsp").forward(request, response);
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
            request.setAttribute("errorMessage", "Database error. Please try again.");
            request.getRequestDispatcher("reservebook.jsp").forward(request, response);
        }
    }
}
