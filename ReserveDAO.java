package library.DAO;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import library.model.Reserve;
import library.connection.connectionManager;

public class ReserveDAO {

    // CREATE
    public static void addReserve(Reserve reserve) throws SQLException {
        String query = "INSERT INTO reserve (UserID, BookID, comments, ReserveDate, dueDate) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = connectionManager.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setInt(1, reserve.getUserId());
            ps.setInt(2, reserve.getBookId());
            ps.setString(3, reserve.getComments());
            ps.setDate(4, reserve.getReserveDate());
            ps.setDate(5, reserve.getDueDate());

            ps.executeUpdate();
        }
    }
    
    public static List<Reserve> getReservesByUserId(int userId) throws SQLException {
        List<Reserve> reserves = new ArrayList<>();
        String query = "SELECT * FROM reserve WHERE UserID = ?";
        try (Connection conn = connectionManager.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Reserve reserve = new Reserve();
                    reserve.setReserveId(rs.getInt("ReserveID"));
                    reserve.setUserId(rs.getInt("UserID"));
                    reserve.setBookId(rs.getInt("BookID"));
                    reserve.setComments(rs.getString("comments"));
                    reserve.setReserveDate(rs.getDate("ReserveDate"));
                    reserve.setDueDate(rs.getDate("dueDate"));
                    reserves.add(reserve);
                }
            }
        }
        return reserves;
    }
    
    public static boolean isBookAvailable(int bookId, Date requestedStart, Date requestedEnd) throws SQLException {
        // This query checks for any reservation that conflicts with the requested dates.
        // A conflict exists if a book is reserved for an overlapping period AND 
        // it has either not been returned yet, or it was returned after the requested period starts.
        String query = "SELECT COUNT(r.ReserveID) FROM reserve r " +
                       "LEFT JOIN `return` ret ON r.ReserveID = ret.ReserveID " +
                       "WHERE r.BookID = ? " +
                       "AND r.ReserveDate < ? " +      // Existing reserve starts before the requested period ends
                       "AND r.DueDate > ? " +          // Existing reserve ends after the requested period starts
                       "AND (ret.ReturnID IS NULL OR ret.returnDate > ?)"; // And it's not returned before the start of the request

        try (Connection connection = connectionManager.getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {
            
            ps.setInt(1, bookId);
            ps.setDate(2, new java.sql.Date(requestedEnd.getTime()));
            ps.setDate(3, new java.sql.Date(requestedStart.getTime()));
            ps.setDate(4, new java.sql.Date(requestedStart.getTime()));

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    // if count is 0, no conflicting reservations were found, so the book is available.
                    return rs.getInt(1) == 0;
                }
            }
        }
        // Default to not available in case of an issue.
        return false;
    }
    
    public static Reserve getReserveById(int reserveId) throws SQLException {
        Reserve reserve = null;
        String query = "SELECT * FROM reserve WHERE ReserveID = ?";
        try (Connection conn = connectionManager.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, reserveId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    reserve = new Reserve();
                    reserve.setReserveId(rs.getInt("ReserveID"));
                    reserve.setUserId(rs.getInt("UserID"));
                    reserve.setBookId(rs.getInt("BookID"));
                    reserve.setComments(rs.getString("comments"));
                    reserve.setReserveDate(rs.getDate("ReserveDate"));
                    reserve.setDueDate(rs.getDate("dueDate"));
                }
            }
        }
        return reserve;
    }

    public static List<Reserve> getAllReserves() throws SQLException {
        List<Reserve> reserves = new ArrayList<>();
        String query = "SELECT * FROM reserve ORDER BY ReserveDate DESC";
        try (Connection conn = connectionManager.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Reserve reserve = new Reserve();
                reserve.setReserveId(rs.getInt("ReserveID"));
                reserve.setUserId(rs.getInt("UserID"));
                reserve.setBookId(rs.getInt("BookID"));
                reserve.setComments(rs.getString("comments"));
                reserve.setReserveDate(rs.getDate("ReserveDate"));
                reserve.setDueDate(rs.getDate("dueDate"));
                reserves.add(reserve);
            }
        }
        return reserves;
    }
}