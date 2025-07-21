package library.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import library.connection.connectionManager;
import library.model.Book;

public class AddBookDAO {
    private static Connection con = null;
    private static PreparedStatement ps = null;

    private static final String INSERT_BOOK = 
        "INSERT INTO books (book_id, title, author, isbn, category, status) VALUES (?, ?, ?, ?, ?, 'Available')";

    // Method to add a book
    public static boolean addBook(Book book) throws SQLException {
        try {
            con = connectionManager.getConnection();
            ps = con.prepareStatement(INSERT_BOOK);
            ps.setString(1, book.getBookId());
            ps.setString(2, book.getTitle());
            ps.setString(3, book.getAuthor());
            ps.setString(4, book.getIsbn());
            ps.setString(5, book.getCategory());

            int rowsInserted = ps.executeUpdate();
            return rowsInserted > 0; // Return true if a row was inserted

        } catch (SQLException e) {
            e.printStackTrace();
            throw e; // Rethrow to be handled by Controller
        } finally {
            if (con != null) con.close();
        }
    }
}
