package library.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import library.model.Book;
import library.DAO.BookDAO;
import library.DAO.ReserveDAO;
import library.connection.connectionManager;

@WebServlet("/BookController")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize = 1024 * 1024 * 10,
    maxRequestSize = 1024 * 1024 * 50
)
public class BookController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        try {
            // Handle search
            String keyword = request.getParameter("keyword");
            if (keyword != null) {
                List<Book> books;
                if (!keyword.trim().isEmpty()) {
                    books = BookDAO.searchBooks(keyword);
                } else {
                	books = BookDAO.getAllBooks(); 
                }
                request.setAttribute("books", books);
                RequestDispatcher dispatcher = request.getRequestDispatcher("searchPage.jsp");
                dispatcher.forward(request, response);
                return;
            }

            // Handle full details
            if ("fullDetails".equals(action)) {
                int bookId = Integer.parseInt(request.getParameter("bookId"));
                Book book = BookDAO.getBookById(bookId);

                String reserveDateStr = request.getParameter("reserveDate");
                String dueDateStr = request.getParameter("dueDate");
                Date selectedReserveDate = (reserveDateStr != null && !reserveDateStr.isEmpty())
                        ? Date.valueOf(reserveDateStr) : new Date(System.currentTimeMillis());
                Date selectedDueDate = (dueDateStr != null && !dueDateStr.isEmpty())
                        ? Date.valueOf(dueDateStr) : selectedReserveDate;

                boolean available = ReserveDAO.isBookAvailable(bookId, selectedReserveDate, selectedDueDate);
                Map<Integer, Boolean> bookAvailableMap = new HashMap<>();
                bookAvailableMap.put(bookId, available);

                request.setAttribute("book", book);
                request.setAttribute("bookAvailableMap", bookAvailableMap);
                request.setAttribute("selectedReserveDate", selectedReserveDate);
                request.setAttribute("selectedDueDate", selectedDueDate);
                request.getRequestDispatcher("BookDetailsPage.jsp").forward(request, response);
                return;
            }

            // Handle other actions
            switch (action) {
                case "list":
                    listBooks(request, response);
                    break;
                case "delete":
                    showDeleteConfirmPage(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "showDeleteConfirm":
                    showDeleteConfirmPage(request, response);
                    break;
                default:
                    listBooks(request, response);
                    break;
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String bookId = request.getParameter("bookId");
        try {
            if ("delete".equals(action)) {
                if (bookId != null && !bookId.isEmpty()) {
                    deleteBook(request, response);
                } else {
                    response.getWriter().write("Book ID is required for deletion.");
                }
            } else {
                if (bookId == null || bookId.isEmpty()) {
                    addBook(request, response);
                } else {
                    updateBook(request, response);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void listBooks(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        List<Book> bookList = BookDAO.getAllBooks();
        request.setAttribute("books", bookList);
        RequestDispatcher dispatcher = request.getRequestDispatcher("listBooks.jsp");
        dispatcher.forward(request, response);
    }

    private void showDeleteConfirmPage(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        int bookId = Integer.parseInt(request.getParameter("bookId"));
        Book existingBook = BookDAO.getBookById(bookId);
        request.setAttribute("book", existingBook);
        RequestDispatcher dispatcher = request.getRequestDispatcher("RemoveBook.jsp");
        dispatcher.forward(request, response);
    }

    private void deleteBook(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ServletException {
        int bookId = Integer.parseInt(request.getParameter("bookId"));
        BookDAO.deleteBook(bookId);
        request.getSession().setAttribute("deleteSuccess", true);
        response.sendRedirect(request.getContextPath() + "/BookController?action=list");
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        int bookId = Integer.parseInt(request.getParameter("bookId"));
        Book existingBook = BookDAO.getBookById(bookId);
        request.setAttribute("book", existingBook);
        RequestDispatcher dispatcher = request.getRequestDispatcher("editBook.jsp");
        dispatcher.forward(request, response);
    }

    private void addBook(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ServletException {
        Book book = extractBookFromRequest(request);
        BookDAO.addBook(book);
        response.sendRedirect("BookController?action=list");
    }

    private void updateBook(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String bookIdStr = request.getParameter("bookId");
        try {
            Book book = extractBookFromRequest(request);
            book.setBookId(Integer.parseInt(bookIdStr));
            BookDAO.updateBook(book);
            request.setAttribute("updateSuccess", true);
            listBooks(request, response);
        } catch (NumberFormatException | SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Invalid input. Please check your entries.");
            try {
                int bookId = Integer.parseInt(bookIdStr);
                Book book = BookDAO.getBookById(bookId);
                request.setAttribute("book", book);
            } catch (Exception ignored) {}
            request.getRequestDispatcher("editBook.jsp").forward(request, response);
        }
    }

    private Book extractBookFromRequest(HttpServletRequest request) throws IOException, ServletException, SQLException {
        Book book = new Book();
        book.setTitle(request.getParameter("title"));
        book.setAuthorName(request.getParameter("authorName"));
        book.setSynopsis(request.getParameter("synopsis"));
        book.setCategory(request.getParameter("category"));
        book.setIsbn(Integer.parseInt(request.getParameter("isbn")));
        book.setPublisher(request.getParameter("publisher"));
        book.setPublishYear(Integer.parseInt(request.getParameter("publishYear")));
        book.setPrice(Double.parseDouble(request.getParameter("price")));

        String reserveIdStr = request.getParameter("reserveId");
        String fineIdStr = request.getParameter("fineId");
        Integer reserveId = (reserveIdStr != null && !reserveIdStr.isEmpty()) ? Integer.parseInt(reserveIdStr) : null;
        Integer fineId = (fineIdStr != null && !fineIdStr.isEmpty()) ? Integer.parseInt(fineIdStr) : null;
        book.setReserveId(reserveId);
        book.setFineId(fineId);

        Part filePart = request.getPart("image");
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = getSubmittedFileName(filePart);
            String contentType = filePart.getContentType();
            InputStream inputStream = filePart.getInputStream();

            Connection connection = connectionManager.getConnection();
            Blob blob = connection.createBlob();
            blob.setBytes(1, inputStream.readAllBytes());

            book.setImage(blob);
            book.setImageFileName(fileName);
            book.setImageContentType(contentType);

            inputStream.close();
            connection.close();
        }
        return book;
    }

    private String getSubmittedFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        if (contentDisp == null) return "";
        for (String token : contentDisp.split(";")) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf("=") + 2, token.length() - 1);
            }
        }
        return "";
    }
}
