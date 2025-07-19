package library.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import library.model.User;
import library.model.Admin;
import library.DAO.UserDAO;
import library.DAO.AdminDAO;

@WebServlet("/LoginController")
public class LoginController extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String email = request.getParameter("email").trim();
            String password = request.getParameter("password").trim();
            String role = request.getParameter("role"); // "user" or "admin"

            if ("admin".equalsIgnoreCase(role)) {
                // Admin login
                Admin admin = AdminDAO.login(email, password);
                if (admin != null && admin.isLoggedIn()) {
                    HttpSession session = request.getSession(true);
                    session.setAttribute("adminId", admin.getAdminId());
                    session.setAttribute("adminEmail", admin.getAdminEmail());
                    response.sendRedirect("AdminDashboard.jsp");
                } else {
                    request.setAttribute("errorMessage", "Invalid admin email or password. Please try again.");
                    request.getRequestDispatcher("Login.jsp").forward(request, response);
                }
            } else {
                // User login
                User user = UserDAO.login(email, password);
                if (user != null && user.isLoggedIn()) {
                    HttpSession session = request.getSession(true);
                    session.setAttribute("UserID", user.getUserID());
                    session.setAttribute("UserEmail", user.getUserEmail());
                    response.sendRedirect("HomePage.jsp");
                } else {
                    request.setAttribute("errorMessage", "Invalid user email or password. Please try again.");
                    request.getRequestDispatcher("Login.jsp").forward(request, response);
                }
            }
        } catch (Throwable ex) {
            ex.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred. Please try again.");
            request.getRequestDispatcher("Login.jsp").forward(request, response);
        }
    }
}