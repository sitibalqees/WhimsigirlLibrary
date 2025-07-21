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
                    session.setAttribute("adminName", admin.getAdminName()); // Store admin name for display
                    session.setAttribute("adminEmail", admin.getAdminEmail());
                    session.setAttribute("role", "admin");
                    response.sendRedirect("AdminPage.jsp");
                    return;
                } else {
                    request.setAttribute("errorMessage", "Invalid admin email or password. Please try again.");
                    request.getRequestDispatcher("Login.jsp").forward(request, response);
                    return;
                }
            } else {
                // User login
                User user = UserDAO.login(email, password);
                if (user != null && user.isLoggedIn()) {
                    HttpSession session = request.getSession(true);
                    session.setAttribute("userID", user.getUserID());
                    session.setAttribute("userEmail", user.getUserEmail());
                    session.setAttribute("userName", user.getUserName());
                    session.setAttribute("role", "user");
                    response.sendRedirect("HomeController");
                    return;
                } else {
                    request.setAttribute("errorMessage", "Invalid user email or password. Please try again.");
                    request.getRequestDispatcher("Login.jsp").forward(request, response);
                    return;
                }
            }
        } catch (Throwable ex) {
            ex.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred. Please try again.");
            request.getRequestDispatcher("Login.jsp").forward(request, response);
        }
    }
}