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
import java.util.List;
import library.model.Book;
import library.model.Reserve;
import library.DAO.BookDAO;
import library.DAO.ReserveDAO;

@WebServlet("/ReserveController")
public class ReserveController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public ReserveController() { super(); }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<Book> bookList = BookDAO.getAllBooks();
            request.setAttribute("bookList", bookList);

            String bookIdParam = request.getParameter("bookId");
            Book selectedBook = null;
            if (bookIdParam != null && !bookIdParam.isEmpty()) {
                try {
                    int selectedBookId = Integer.parseInt(bookIdParam);
                    selectedBook = BookDAO.getBookById(selectedBookId);
                } catch (NumberFormatException ignored) {}
            }
            request.setAttribute("selectedBook", selectedBook);

            RequestDispatcher dispatcher = request.getRequestDispatcher("ReserveBook.jsp");
            dispatcher.forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Integer userId = (Integer) request.getSession().getAttribute("userID");
            if (userId == null) {
                response.sendRedirect("Login.jsp");
                return;
            }
            String bookIdStr = request.getParameter("bookId");
            if (bookIdStr == null || bookIdStr.isEmpty()) {
                response.sendRedirect("ReserveController?error=true");
                return;
            }
            int bookId = Integer.parseInt(bookIdStr);
            String comments = request.getParameter("comments");
            Date reserveDate = Date.valueOf(request.getParameter("reserveDate"));
            Date dueDate = Date.valueOf(request.getParameter("dueDate"));

            System.out.println("userId=" + userId + ", bookId=" + bookId + ", reserveDate=" + reserveDate + ", dueDate=" + dueDate + ", comments=" + comments);

            Reserve reserve = new Reserve();
            reserve.setUserId(userId);
            reserve.setBookId(bookId);
            reserve.setComments(comments);
            reserve.setReserveDate(reserveDate);
            reserve.setDueDate(dueDate);

            ReserveDAO.addReserve(reserve);
            response.sendRedirect("ReserveController?success=true");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("ReserveController?error=true");
        }
    }
}