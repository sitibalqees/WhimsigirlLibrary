package library.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import library.DAO.ReturnBookDAO;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/ReturnBookController")
public class ReturnBookController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public ReturnBookController() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String title = request.getParameter("title");
        String authorName = request.getParameter("authorName");
        String username = request.getParameter("username");
        try {
            ReturnBookDAO.returnBook(title, authorName, username);
            request.setAttribute("message", "Book returned successfully!");
        } catch (SQLException e) {
            request.setAttribute("message", "Error returning book: " + e.getMessage());
        }
        RequestDispatcher dispatcher = request.getRequestDispatcher("returnBook.jsp");
        dispatcher.forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("returnBook.jsp");
        dispatcher.forward(request, response);
    }
}