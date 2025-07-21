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
import java.sql.SQLException;
import java.util.List;
import library.model.Book;
import library.DAO.BookDAO;
import library.connection.connectionManager;
import java.sql.Date;
import java.util.HashMap;
import java.util.Map;
import library.DAO.ReserveDAO;

/**
 * Servlet implementation class BookController
 */
@WebServlet("/BookController")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, // 1 MB
    maxFileSize = 1024 * 1024 * 10,  // 10 MB
    maxRequestSize = 1024 * 1024 * 50 // 50 MB
)
public class BookController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public BookController() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        try {
        	if ("fullDetails".equals(action)) {
        	    int bookId = Integer.parseInt(request.getParameter("bookId"));
        	    Book book = BookDAO.getBookById(bookId);

        	    // Get the same date range as homepage (from request or default to today)
        	    String reserveDateStr = request.getParameter("reserveDate");
        	    String dueDateStr = request.getParameter("dueDate");
        	    Date selectedReserveDate = (reserveDateStr != null && !reserveDateStr.isEmpty())
        	        ? Date.valueOf(reserveDateStr)
        	        : new Date(System.currentTimeMillis());
        	    Date selectedDueDate = (dueDateStr != null && !dueDateStr.isEmpty())
        	        ? Date.valueOf(dueDateStr)
        	        : selectedReserveDate;

        	    // Check availability for this book and date range
        	    boolean available = ReserveDAO.isBookAvailable(bookId, selectedReserveDate, selectedDueDate);

        	    // Pass as a map for JSP compatibility
        	    Map<Integer, Boolean> bookAvailableMap = new HashMap<>();
        	    bookAvailableMap.put(bookId, available);

        	    request.setAttribute("book", book);
        	    request.setAttribute("bookAvailableMap", bookAvailableMap);
        	    request.setAttribute("selectedReserveDate", selectedReserveDate);
        	    request.setAttribute("selectedDueDate", selectedDueDate);
        	    request.getRequestDispatcher("BookDetailsPage.jsp").forward(request, response);
        	    return;
        	}
            switch (action) {
                case "list":
                    listBooks(request, response);
                    break;
                case "delete": // Changed to show confirmation page
                    showDeleteConfirmPage(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "showDeleteConfirm": // New action for clarity
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

    private String escapeJson(String value) {
        if (value == null) return "";
        return value.replace("\"", "\\\"").replace("\n", "\\n").replace("\r", "\\r");
    }
	
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String bookId = request.getParameter("bookId");
        System.out.println("doPost: action=" + action + ", bookId=" + bookId);
        try {
            if ("delete".equals(action)) {
                if (bookId != null && !bookId.isEmpty()) {
                    deleteBook(request, response);
                } else {
                    // Optionally, handle error: bookId missing for delete
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

    // 1. LIST all books
    private void listBooks(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        List<Book> bookList = BookDAO.getAllBooks();
        request.setAttribute("books", bookList);
        RequestDispatcher dispatcher = request.getRequestDispatcher("listBooks.jsp");
        dispatcher.forward(request, response);
    }

    // Show delete confirmation page
    private void showDeleteConfirmPage(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        int bookId = Integer.parseInt(request.getParameter("bookId"));
        Book existingBook = BookDAO.getBookById(bookId);
        request.setAttribute("book", existingBook);
        RequestDispatcher dispatcher = request.getRequestDispatcher("RemoveBook.jsp");
        dispatcher.forward(request, response);
    }

    // 2. DELETE a book and redirect
    private void deleteBook(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ServletException {
        int bookId = Integer.parseInt(request.getParameter("bookId"));
        BookDAO.deleteBook(bookId);
        System.out.println("Book deleted successfully.");
        // Set a session attribute to show a success message on the book list page
        request.getSession().setAttribute("deleteSuccess", true);
        response.sendRedirect(request.getContextPath() + "/BookController?action=list");
    }

    // 3. SHOW edit form for a book
    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        int bookId = Integer.parseInt(request.getParameter("bookId"));
        Book existingBook = BookDAO.getBookById(bookId);
        request.setAttribute("book", existingBook);
        RequestDispatcher dispatcher = request.getRequestDispatcher("editBook.jsp");
        dispatcher.forward(request, response);
    }

    // 4. ADD a new book with image
    private void addBook(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ServletException {
        String title = request.getParameter("title");
        String authorName = request.getParameter("authorName");
        String synopsis = request.getParameter("synopsis");
        String category = request.getParameter("category");
        int isbn = Integer.parseInt(request.getParameter("isbn"));
        String publisher = request.getParameter("publisher");
        int publishYear = Integer.parseInt(request.getParameter("publishYear"));
        double price = Double.parseDouble(request.getParameter("price"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String availability = request.getParameter("availability");

        // Optional fields
        String reserveIdStr = request.getParameter("reserveId");
        String fineIdStr = request.getParameter("fineId");
        Integer reserveId = (reserveIdStr != null && !reserveIdStr.isEmpty()) ? Integer.parseInt(reserveIdStr) : null;
        Integer fineId = (fineIdStr != null && !fineIdStr.isEmpty()) ? Integer.parseInt(fineIdStr) : null;

        Book book = new Book();
        book.setTitle(title);
        book.setAuthorName(authorName);
        book.setSynopsis(synopsis);
        book.setCategory(category);
        book.setIsbn(isbn);
        book.setPublisher(publisher);
        book.setPublishYear(publishYear);
        book.setPrice(price);
        book.setReserveId(reserveId);
        book.setFineId(fineId);

        // Handle image upload
        Part filePart = request.getPart("image");
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = getSubmittedFileName(filePart);
            String contentType = filePart.getContentType();
            InputStream inputStream = filePart.getInputStream();
            
            // Create BLOB from input stream
            Connection connection = connectionManager.getConnection();
            Blob blob = connection.createBlob();
            blob.setBytes(1, inputStream.readAllBytes());
            
            book.setImage(blob);
            book.setImageFileName(fileName);
            book.setImageContentType(contentType);
            
            inputStream.close();
            connection.close();
        }

        BookDAO.addBook(book);
        System.out.println("Book added successfully.");
        response.sendRedirect("BookController?action=list");
    }

    // update book
    private void updateBook(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String bookIdStr = request.getParameter("bookId");
        String isbnStr = request.getParameter("isbn");
        String publisher = request.getParameter("publisher");
        String priceStr = request.getParameter("price");

        if (bookIdStr == null || bookIdStr.isEmpty() ||
            isbnStr == null || isbnStr.isEmpty() ||
            publisher == null || publisher.isEmpty() ||
            priceStr == null || priceStr.isEmpty()) {
            request.setAttribute("error", "All fields are required.");
            try {
                int bookId = Integer.parseInt(bookIdStr);
                Book book = BookDAO.getBookById(bookId);
                request.setAttribute("book", book);
            } catch (Exception e) {}
            request.getRequestDispatcher("editBook.jsp").forward(request, response);
            return;
        }

        try {
            int bookId = Integer.parseInt(bookIdStr);
            int isbn = Integer.parseInt(isbnStr);
            double price = Double.parseDouble(priceStr);

            Book book = BookDAO.getBookById(bookId);
            book.setIsbn(isbn);
            book.setPublisher(publisher);
            book.setPrice(price);

            // Handle image upload
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
            } catch (Exception ex) {}
            request.getRequestDispatcher("editBook.jsp").forward(request, response);
        }
    }

    private String getSubmittedFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] tokens = contentDisp.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf("=") + 2, token.length() - 1);
            }
        }
        return "";
    }
}