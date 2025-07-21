package library.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet("/AdminFineController")
public class AdminFineController extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String userEmail = request.getParameter("userEmail");
        String status = request.getParameter("status");
        try {
            List<Map<String, Object>> fines = library.DAO.FineDAO.getAllFines(userEmail, status);
            request.setAttribute("fines", fines);
            request.getRequestDispatcher("AdminFinePage.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("ErrorPage.jsp");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String fineID = request.getParameter("fineID");
        String action = request.getParameter("action");
        try {
            if ("Mark as Paid".equals(action) && fineID != null) {
                library.DAO.FineDAO.payFine(Integer.parseInt(fineID));
            }
            response.sendRedirect("AdminFineController");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("ErrorPage.jsp");
        }
    }
}