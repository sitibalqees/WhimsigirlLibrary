
package library.DAO;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import library.model.Reserve;
import library.connection.connectionManager;

public class ReserveDAO {
    private static Connection connection = null;

    // CREATE
    public static void addReserve(Reserve reserve) throws SQLException {
        String query = "INSERT INTO reserve (UserID, BookID, comments, ReserveDate, dueDate) VALUES (?, ?, ?, ?, ?)";
        connection = connectionManager.getConnection();
        PreparedStatement ps = connection.prepareStatement(query);

        ps.setInt(1, reserve.getUserId());
        ps.setInt(2, reserve.getBookId());
        ps.setString(3, reserve.getComments());
        ps.setDate(4, reserve.getReserveDate());
        ps.setDate(5, reserve.getDueDate());

        ps.executeUpdate();
        ps.close();
    }
    
    public static List<Reserve> getReservesByUserId(int userId) throws SQLException {
        List<Reserve> reserves = new ArrayList<>();
        String query = "SELECT * FROM reserve WHERE UserID = ?";
        connection = connectionManager.getConnection();
        PreparedStatement ps = connection.prepareStatement(query);
        ps.setInt(1, userId);
        ResultSet rs = ps.executeQuery();
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
        rs.close();
        ps.close();
        return reserves;
    }
    
    public static boolean isBookAvailable(int bookId, Date requestedStart, Date requestedEnd) throws SQLException {
        String query = "SELECT COUNT(*) FROM reserve WHERE BookID = ? AND " +
                       "((ReserveDate <= ? AND DueDate >= ?) OR (ReserveDate <= ? AND DueDate >= ?) OR (ReserveDate >= ? AND DueDate <= ?))";
        Connection connection = connectionManager.getConnection();
        PreparedStatement ps = connection.prepareStatement(query);
        ps.setInt(1, bookId);
        ps.setDate(2, requestedEnd);   // Existing reservation ends after requested start
        ps.setDate(3, requestedStart); // Existing reservation starts before requested end
        ps.setDate(4, requestedEnd);
        ps.setDate(5, requestedStart);
        ps.setDate(6, requestedStart);
        ps.setDate(7, requestedEnd);
        ResultSet rs = ps.executeQuery();
        boolean available = true;
        if (rs.next()) {
            available = rs.getInt(1) == 0;
        }
        rs.close();
        ps.close();
        return available;
    }
    
    public static Reserve getReserveById(int reserveId) throws SQLException {
        Reserve reserve = null;
        String query = "SELECT * FROM reserve WHERE ReserveID = ?";
        Connection connection = connectionManager.getConnection();
        PreparedStatement ps = connection.prepareStatement(query);
        ps.setInt(1, reserveId);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            reserve = new Reserve();
            reserve.setReserveId(rs.getInt("ReserveID"));
            reserve.setUserId(rs.getInt("UserID"));
            reserve.setBookId(rs.getInt("BookID"));
            reserve.setComments(rs.getString("comments"));
            reserve.setReserveDate(rs.getDate("ReserveDate"));
            reserve.setDueDate(rs.getDate("dueDate"));
        }
        rs.close();
        ps.close();
        return reserve;
    }
}    
    
