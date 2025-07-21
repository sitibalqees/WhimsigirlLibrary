package library.controller;

import library.DAO.FineDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet("/FineController")
public class FineController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Object userIdObj = request.getSession().getAttribute("userID");
        if (userIdObj == null) {
            response.sendRedirect("Login.jsp");
            return;
        }
        int userId = Integer.parseInt(userIdObj.toString());
        try {
            List<Map<String, Object>> fines = FineDAO.getFinesByUser(userId);
            request.setAttribute("fines", fines);
            RequestDispatcher rd = request.getRequestDispatcher("FinePage.jsp");
            rd.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("ErrorPage.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int fineID = Integer.parseInt(request.getParameter("fineID"));
        try {
            FineDAO.payFine(fineID);
            response.sendRedirect("FineController");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("ErrorPage.jsp");
        }
    }
}