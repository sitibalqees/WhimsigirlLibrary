package library.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import library.model.Book;
import library.DAO.BookDAO;

/**
 * Servlet implementation class BookController
 */
@WebServlet("/BookController")
public class BookController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public BookController() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            switch (action) {
                case "list":
                    listBooks(request, response);
                    break;
                case "delete":
                    deleteBook(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
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
        String bookId = request.getParameter("bookId");
        try {
            if (bookId == null || bookId.isEmpty())
                addBook(request, response);
            else
                updateBook(request, response);

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

    // 2. DELETE a book
    private void deleteBook(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        int bookId = Integer.parseInt(request.getParameter("bookId"));
        BookDAO.deleteBook(bookId);
        System.out.println("Book deleted successfully.");
        response.sendRedirect("BookController?action=list");
    }

    // 3. SHOW edit form for a book
    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        int bookId = Integer.parseInt(request.getParameter("bookId"));
        Book existingBook = BookDAO.getBookById(bookId);
        request.setAttribute("book", existingBook);
        RequestDispatcher dispatcher = request.getRequestDispatcher("editBook.jsp");
        dispatcher.forward(request, response);
    }

    // 4. ADD a new book
    private void addBook(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
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
        book.setQuantity(quantity);
        book.setReserveId(reserveId);
        book.setFineId(fineId);
        book.setAvailability(availability);

        BookDAO.addBook(book);
        System.out.println("Book added successfully.");
        response.sendRedirect("BookController?action=list");
    }

    // 5. UPDATE an existing book
    private void updateBook(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        int bookId = Integer.parseInt(request.getParameter("bookId"));
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
        book.setBookId(bookId);
        book.setTitle(title);
        book.setAuthorName(authorName);
        book.setSynopsis(synopsis);
        book.setCategory(category);
        book.setIsbn(isbn);
        book.setPublisher(publisher);
        book.setPublishYear(publishYear);
        book.setPrice(price);
        book.setQuantity(quantity);
        book.setReserveId(reserveId);
        book.setFineId(fineId);
        book.setAvailability(availability);

        BookDAO.updateBook(book);
        System.out.println("Book updated successfully.");
        response.sendRedirect("BookController?action=list");
    }
}