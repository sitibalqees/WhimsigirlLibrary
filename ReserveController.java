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
import java.util.ArrayList;
import java.util.List;
import java.util.Set; // <-- Import Set
import library.model.Book;
import library.model.Reserve;
import library.DAO.BookDAO;
import library.DAO.ReserveDAO;
import library.DAO.ReturnBookDAO; // <-- Import ReturnBookDAO
import library.DAO.UserDAO;

@WebServlet("/ReserveController")
public class ReserveController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public ReserveController() { super(); }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        try {
            if ("listUser".equals(action)) {
                Integer userId = (Integer) request.getSession().getAttribute("userID");
                if (userId == null) {
                    response.sendRedirect("Login.jsp");
                    return;
                }
                List<Reserve> reserves = ReserveDAO.getReservesByUserId(userId);
                List<Book> books = new ArrayList<>();
                for (Reserve r : reserves) {
                    books.add(BookDAO.getBookById(r.getBookId()));
                }
                // Get the set of returned IDs
                Set<Integer> returnedReserveIds = ReturnBookDAO.getReturnedReserveIdsForUser(userId);

                request.setAttribute("reserves", reserves);
                request.setAttribute("books", books);
                // Pass the set to the JSP
                request.setAttribute("returnedReserveIds", returnedReserveIds);

                request.getRequestDispatcher("ReserveRecord.jsp").forward(request, response);
                return;
            }
            
            // Admin: list all reserves
            if ("listAll".equals(action)) {
                List<Reserve> reserves = ReserveDAO.getAllReserves();
                List<Book> books = new ArrayList<>();
                List<library.model.User> users = UserDAO.getAllUsers();
                for (Reserve r : reserves) {
                    books.add(BookDAO.getBookById(r.getBookId()));
                }
                // Sorting logic
                String sort = request.getParameter("sort");
                String order = request.getParameter("order");
                if ("reserveDate".equals(sort)) {
                    reserves.sort((a, b) -> {
                        int cmp = a.getReserveDate().compareTo(b.getReserveDate());
                        return ("asc".equals(order)) ? cmp : -cmp;
                    });
                }
                request.setAttribute("reserves", reserves);
                request.setAttribute("books", books);
                request.setAttribute("users", users);
                request.getRequestDispatcher("AdminReserveRecord.jsp").forward(request, response);
                return;
            }

            // Default action: Show the form to reserve a book
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
            throw new ServletException(e);
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

            // Check for overlapping reservation
            if (!ReserveDAO.isBookAvailable(bookId, reserveDate, dueDate)) {
                response.sendRedirect("ReserveBook.jsp?error=notavailable");
                return;
            }

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