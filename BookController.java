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
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;
import java.sql.Date;
import library.model.Book;
import library.DAO.BookDAO;
import library.connection.connectionManager;
import library.DAO.ReserveDAO;

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
        if ("search".equals(action) || isSearchRequest(request)) {
            handleSearch(request, response);
            return;
        }
        try {
            if ("fullDetails".equals(action)) {
                int bookId = Integer.parseInt(request.getParameter("bookId"));
                Book book = BookDAO.getBookById(bookId);

                String reserveDateStr = request.getParameter("reserveDate");
                String dueDateStr = request.getParameter("dueDate");
                Date selectedReserveDate = (reserveDateStr != null && !reserveDateStr.isEmpty())
                    ? Date.valueOf(reserveDateStr)
                    : new Date(System.currentTimeMillis());
                Date selectedDueDate = (dueDateStr != null && !dueDateStr.isEmpty())
                    ? Date.valueOf(dueDateStr)
                    : selectedReserveDate;

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

    private boolean isSearchRequest(HttpServletRequest request) {
        return request.getParameter("bookTitle") != null ||
               request.getParameter("author") != null ||
               request.getParameter("isbn") != null ||
               request.getParameter("genre") != null;
    }

    private void handleSearch(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String title = request.getParameter("bookTitle");
        String author = request.getParameter("author");
        String isbn = request.getParameter("isbn");
        String genre = request.getParameter("genre");

        List<String> categories = Arrays.asList("Fiction", "Non Fiction");

        try {
            List<Book> books = BookDAO.searchBooks(title, author, isbn, genre);
            request.setAttribute("books", books);
            request.setAttribute("categories", categories);

            request.setAttribute("searchTitle", title);
            request.setAttribute("searchAuthor", author);
            request.setAttribute("searchIsbn", isbn);
            request.setAttribute("searchGenre", genre);

            request.getRequestDispatcher("searchPage.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error during search.");
            request.getRequestDispatcher("searchPage.jsp").forward(request, response);
        }
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
        System.out.println("Book deleted successfully.");
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
        String title = request.getParameter("title");
        String authorName = request.getParameter("authorName");
        String synopsis = request.getParameter("synopsis");
        String category = request.getParameter("category");
        int isbn = Integer.parseInt(request.getParameter("isbn"));
        String publisher = request.getParameter("publisher");
        int publishYear = Integer.parseInt(request.getParameter("publishYear"));
        double price = Double.parseDouble(request.getParameter("price"));

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

        BookDAO.addBook(book);
        System.out.println("Book added successfully.");
        response.sendRedirect("BookController?action=list");
    }

    private void updateBook(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String bookIdStr = request.getParameter("bookId");

        if (bookIdStr == null || bookIdStr.isEmpty()) {
            request.setAttribute("error", "Book ID is missing. Cannot update.");
            try {
                listBooks(request, response);
            } catch (SQLException e) {
                e.printStackTrace();
            }
            return;
        }

        try {
            int bookId = Integer.parseInt(bookIdStr);
            Book book = BookDAO.getBookById(bookId);

            if (book == null) {
                request.setAttribute("error", "Book with ID " + bookId + " not found.");
                listBooks(request, response);
                return;
            }

            String title = request.getParameter("title");
            if (title != null && !title.isEmpty()) book.setTitle(title);

            String authorName = request.getParameter("authorName");
            if (authorName != null && !authorName.isEmpty()) book.setAuthorName(authorName);

            String synopsis = request.getParameter("synopsis");
            if (synopsis != null && !synopsis.isEmpty()) book.setSynopsis(synopsis);

            String category = request.getParameter("category");
            if (category != null && !category.isEmpty()) book.setCategory(category);

            String isbnStr = request.getParameter("isbn");
            if (isbnStr != null && !isbnStr.isEmpty()) book.setIsbn(Integer.parseInt(isbnStr));

            String publisher = request.getParameter("publisher");
            if (publisher != null && !publisher.isEmpty()) book.setPublisher(publisher);

            String publishYearStr = request.getParameter("publishYear");
            if (publishYearStr != null && !publishYearStr.isEmpty()) book.setPublishYear(Integer.parseInt(publishYearStr));

            String priceStr = request.getParameter("price");
            if (priceStr != null && !priceStr.isEmpty()) book.setPrice(Double.parseDouble(priceStr));

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

        } catch (NumberFormatException e) {
            e.printStackTrace();
            request.setAttribute("error", "Invalid number format. Please check your entries for ISBN, Year, and Price.");
            try {
                Book book = BookDAO.getBookById(Integer.parseInt(bookIdStr));
                request.setAttribute("book", book);
            } catch (Exception ex) {}
            request.getRequestDispatcher("editBook.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error during update: " + e.getMessage());
            try {
                Book book = BookDAO.getBookById(Integer.parseInt(bookIdStr));
                request.setAttribute("book", book);
            } catch (Exception ex) {}
            request.getRequestDispatcher("editBook.jsp").forward(request, response);
        }
    }

    private String getSubmittedFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        if (contentDisp == null) return "";
        String[] tokens = contentDisp.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf("=") + 2, token.length() - 1);
            }
        }
        return "";
    }
}