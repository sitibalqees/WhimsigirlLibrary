package library.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import library.connection.connectionManager;
import library.model.ReserveBook;

public class ReserveBookDAO {
    private static Connection con = null;
    private static PreparedStatement ps = null;
    private static ResultSet rs = null;

    // SQL queries
    private static final String CHECK_BOOK_AVAILABILITY = 
        "SELECT * FROM books WHERE title = ? AND status = 'Available'";
    
    private static final String INSERT_RESERVATION = 
        "INSERT INTO reservations (book_title, author, category, ic_no, comments, reserve_date, status) " +
        "VALUES (?, ?, ?, ?, ?, CURRENT_DATE, 'Pending')";
    
    private static final String UPDATE_BOOK_STATUS = 
        "UPDATE books SET status = 'Reserved' WHERE title = ?";

    // ✅ Check if the book is available for reservation
    public static boolean isBookAvailable(String bookTitle) throws SQLException {
        boolean available = false;
        try {
            con = connectionManager.getConnection();
            ps = con.prepareStatement(CHECK_BOOK_AVAILABILITY);
            ps.setString(1, bookTitle);
            rs = ps.executeQuery();
            available = rs.next(); // true if any row found
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (con != null) con.close();
        }
        return available;
    }

    // ✅ Reserve the book (insert reservation + update book status)
    public static boolean reserveBook(ReserveBook reserve) throws SQLException {
        try {
            con = connectionManager.getConnection();
            con.setAutoCommit(false); // Start transaction

            // Insert into reservations table
            ps = con.prepareStatement(INSERT_RESERVATION);
            ps.setString(1, reserve.getBookTitle());
            ps.setString(2, reserve.getAuthor());
            ps.setString(3, reserve.getCategory());
            ps.setString(4, reserve.getIcNo());
            ps.setString(5, reserve.getComments());
            int rowsInserted = ps.executeUpdate();

            // Update books table to set status = 'Reserved'
            ps = con.prepareStatement(UPDATE_BOOK_STATUS);
            ps.setString(1, reserve.getBookTitle());
            int rowsUpdated = ps.executeUpdate();

            if (rowsInserted > 0 && rowsUpdated > 0) {
                con.commit();
                return true;
            } else {
                con.rollback();
                return false;
            }

        } catch (SQLException e) {
            e.printStackTrace();
            if (con != null) con.rollback();
            throw e;
        } finally {
            if (ps != null) ps.close();
            if (con != null) con.close();
        }
    }
}
