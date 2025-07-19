package library.controller;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import library.model.User;
import library.DAO.UserDAO;

@WebServlet("/RegisterController")
public class RegisterController extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get form parameters
        String userName = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");

        // Simple validation
        if (userName == null || password == null || email == null ||
            userName.isEmpty() ||  password.isEmpty() || email.isEmpty()) {
            request.setAttribute("errorMessage", "Please fill all fields.");
            request.getRequestDispatcher("Register.jsp").forward(request, response);
            return;
        }

        // Email format validation: must contain '@' and end with '.com'
        if (!email.contains("@") || !email.endsWith(".com")) {
            request.setAttribute("errorMessage", "Please enter a valid email address (must contain '@' and end with '.com').");
            request.getRequestDispatcher("Register.jsp").forward(request, response);
            return;
        }

        // Hash the password (MD5, as in your DAO)
        String hashedPassword = null;
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            md.update(password.getBytes());
            byte[] byteData = md.digest();
            StringBuilder sb = new StringBuilder();
            for (byte b : byteData) {
                sb.append(String.format("%02x", b));
            }
            hashedPassword = sb.toString();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Internal error. Please try again.");
            request.getRequestDispatcher("Register.jsp").forward(request, response);
            return;
        }

        // Create User object
        User user = new User();
        user.setUserName(userName);
        user.setUserPassword(hashedPassword);
        user.setUserEmail(email);

        // Save user using UserDAO
        try {
            boolean success = UserDAO.register(user);
            if (success) {
                response.sendRedirect("Login.jsp?register=success");
            } else {
                request.setAttribute("errorMessage", "Registration failed. Email may already be used.");
                request.getRequestDispatcher("Register.jsp").forward(request, response);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            request.setAttribute("errorMessage", "Database error. Please try again.");
            request.getRequestDispatcher("Register.jsp").forward(request, response);
        }
    }
}