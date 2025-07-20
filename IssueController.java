package library.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import library.model.Issue;
import library.model.Book;
import library.DAO.IssueDAO;
import library.DAO.BookDAO;

@WebServlet("/IssueController")
@MultipartConfig(fileSizeThreshold=1024*1024*2, // 2MB
                 maxFileSize=1024*1024*5,      // 5MB
                 maxRequestSize=1024*1024*10)  // 10MB
public class IssueController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public IssueController() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
        	if ("listUser".equals(action)) {
                Integer userId = (Integer) request.getSession().getAttribute("userID");
                if (userId == null) {
                    response.sendRedirect("Login.jsp");
                    return;
                }
                List<Issue> issues = IssueDAO.getIssuesByUserId(userId);
                List<Book> books = new ArrayList<>();
                for (Issue issue : issues) {
                    books.add(BookDAO.getBookById(issue.getBookID()));
                }
                request.setAttribute("issues", issues);
                request.setAttribute("books", books);
                request.getRequestDispatcher("IssueRecord.jsp").forward(request, response);
                return;
            }
            switch (action) {
                case "list":
                    listIssues(request, response);
                    break;
                case "delete":
                    deleteIssue(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "report": // <-- Add this
                    showReportForm(request, response);
                    break;
                default:
                    listIssues(request, response);
                    break;
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String issueID = request.getParameter("issueID");
        try {
            if (issueID == null || issueID.isEmpty())
                addIssue(request, response);
            else
                updateIssue(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    private void showReportForm(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        // Get bookID from request (e.g., /IssueController?action=report&bookID=5)
        int bookID = Integer.parseInt(request.getParameter("bookID"));
        // Fetch book from DB
        Book book = BookDAO.getBookById(bookID);
        // Set attributes for JSP
        request.setAttribute("bookTitle", book.getTitle());
        request.setAttribute("bookID", book.getBookId());
        // You may also want to set user info from session
        // Forward to JSP
        RequestDispatcher dispatcher = request.getRequestDispatcher("IssueBook.jsp");
        dispatcher.forward(request, response);
    }

    // 1. LIST all issues
    private void listIssues(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        List<Issue> issueList = IssueDAO.getAllIssues();
        request.setAttribute("issues", issueList);
        RequestDispatcher dispatcher = request.getRequestDispatcher("listIssues.jsp");
        dispatcher.forward(request, response);
    }

    // 2. DELETE an issue
    private void deleteIssue(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        int issueID = Integer.parseInt(request.getParameter("issueID"));
        IssueDAO.deleteIssue(issueID);
        System.out.println("Issue deleted successfully.");
        response.sendRedirect("IssueController?action=list");
    }

    // 3. SHOW edit form for an issue
    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        int issueID = Integer.parseInt(request.getParameter("issueID"));
        Issue existingIssue = IssueDAO.getIssueById(issueID);
        request.setAttribute("issue", existingIssue);
        RequestDispatcher dispatcher = request.getRequestDispatcher("editIssue.jsp");
        dispatcher.forward(request, response);
    }

    // 4. ADD a new issue
    private void addIssue(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ServletException {
        int userID = Integer.parseInt(request.getParameter("userID"));
        int bookID = Integer.parseInt(request.getParameter("bookID"));
        String issueText = request.getParameter("issue");

        // Handle file upload
        Part filePart = request.getPart("proof");
        String fileName = null;
        String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdir();

        if (filePart != null && filePart.getSize() > 0) {
            fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();
            filePart.write(uploadPath + File.separator + fileName);
        }

        Issue issue = new Issue();
        issue.setUserID(userID);
        issue.setBookID(bookID);
        issue.setIssue(issueText);
        issue.setProof(fileName);

        IssueDAO.addIssue(issue);
        System.out.println("Issue added successfully.");
        response.sendRedirect("IssueController?action=listUser");
    }

    // 5. UPDATE an existing issue
    private void updateIssue(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ServletException {
        int issueID = Integer.parseInt(request.getParameter("issueID"));
        int userID = Integer.parseInt(request.getParameter("userID"));
        int bookID = Integer.parseInt(request.getParameter("bookID"));
        String issueText = request.getParameter("issue");

        // Handle file upload
        Part filePart = request.getPart("proof");
        String fileName = null;
        String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdir();

        if (filePart != null && filePart.getSize() > 0) {
            fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();
            filePart.write(uploadPath + File.separator + fileName);
        }

        Issue issue = new Issue();
        issue.setIssueID(issueID);
        issue.setUserID(userID);
        issue.setBookID(bookID);
        issue.setIssue(issueText);
        issue.setProof(fileName);

        IssueDAO.updateIssue(issue);
        System.out.println("Issue updated successfully.");
        response.sendRedirect("IssueController?action=listUser");
    }
}