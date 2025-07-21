package library.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import library.DAO.AdminDAO;
import library.DAO.BookDAO;
import library.DAO.ReserveDAO;
import library.DAO.ReturnBookDAO;
import library.DAO.UserDAO;
import library.model.Admin;
import library.model.Book;
import library.model.Reserve;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

@WebServlet("/ReturnBookController")
public class ReturnBookController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public ReturnBookController() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<Admin> admins = AdminDAO.getAllAdmins();
            request.setAttribute("admins", admins);
            request.setAttribute("returnedBooks", ReturnBookDAO.getRecentReturns());
        } catch (SQLException e) {
            e.printStackTrace();
        }

        String username = request.getParameter("username");
        if (username != null && !username.isEmpty()) {
            try {
                int userId = UserDAO.getUserIdByUsername(username);
                List<Reserve> allReserves = ReserveDAO.getReservesByUserId(userId);
                Set<Integer> returnedReserveIds = ReturnBookDAO.getReturnedReserveIdsForUser(userId);
                List<Reserve> unreturnedReserves = new ArrayList<>();
                for (Reserve reserve : allReserves) {
                    if (returnedReserveIds == null || !returnedReserveIds.contains(reserve.getReserveId())) {
                        unreturnedReserves.add(reserve);
                    }
                }
                request.setAttribute("reserves", unreturnedReserves);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("returnBook.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String adminIdStr = request.getParameter("adminId");
        String username = request.getParameter("username");
        String reserveIdStr = request.getParameter("reserveId");
        String returnDateStr = request.getParameter("returnDate");
        String message = null;

        try {
            int adminId = Integer.parseInt(adminIdStr);
            int reserveId = Integer.parseInt(reserveIdStr);
            java.sql.Date returnDate = java.sql.Date.valueOf(returnDateStr);

            Reserve reserve = ReserveDAO.getReserveById(reserveId);
            java.sql.Date dueDate = reserve.getDueDate();

            if (returnDate.after(dueDate)) {
                long diffMillis = returnDate.getTime() - dueDate.getTime();
                long daysLate = diffMillis / (1000 * 60 * 60 * 24);
                message = "You need to pay fine because you are late for " + daysLate + " days.";
            } else {
            	  ReturnBookDAO.processReturn(adminId, reserveId, returnDate);
                message = "Book returned successfully and recorded.";
            }
        } catch (Exception e) {
            message = "Error returning book: " + e.getMessage();
        }

        try {
            List<Admin> admins = AdminDAO.getAllAdmins();
            request.setAttribute("admins", admins);
            request.setAttribute("returnedBooks", ReturnBookDAO.getRecentReturns());
        } catch (SQLException e) {
            e.printStackTrace();
        }

        // Repopulate reserves for the username so the dropdown stays populated after POST
        if (username != null && !username.isEmpty()) {
            try {
                int userId = UserDAO.getUserIdByUsername(username);
                List<Reserve> reserves = ReserveDAO.getReservesByUserId(userId);
                request.setAttribute("reserves", reserves);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        request.setAttribute("message", message);
        RequestDispatcher dispatcher = request.getRequestDispatcher("returnBook.jsp");
        dispatcher.forward(request, response);
    }
}