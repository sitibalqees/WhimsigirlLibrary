// ReturnBookDAO.java
package library.DAO;

import java.sql.*;
import java.util.*;
import library.connection.connectionManager;
import library.model.*;

public class ReturnBookDAO {
	public static void processReturn(int adminId, int reserveId, java.sql.Date returnDate) throws SQLException {
	    Connection conn = null;
	    PreparedStatement psGetReserve = null;
	    PreparedStatement psInsertReturn = null;
	    ResultSet rs = null;

	    String getReserveQuery = "SELECT UserID, BookID FROM reserve WHERE ReserveID=?";
	    String insertReturnQuery = "INSERT INTO `return` (AdminID, UserID, BookID, ReserveID, returnDate) VALUES (?, ?, ?, ?, ?)";

	    try {
	        conn = connectionManager.getConnection();
	        conn.setAutoCommit(false);

	        // 1. Get UserID and BookID from the reservation
	        psGetReserve = conn.prepareStatement(getReserveQuery);
	        psGetReserve.setInt(1, reserveId);
	        rs = psGetReserve.executeQuery();

	        int userId = -1;
	        int bookId = -1;
	        if (rs.next()) {
	            userId = rs.getInt("UserID");
	            bookId = rs.getInt("BookID");
	        } else {
	            throw new SQLException("Reservation with ID " + reserveId + " not found.");
	        }

	        // 2. Insert into the 'return' table
	        psInsertReturn = conn.prepareStatement(insertReturnQuery);
	        psInsertReturn.setInt(1, adminId);
	        psInsertReturn.setInt(2, userId);
	        psInsertReturn.setInt(3, bookId);
	        psInsertReturn.setInt(4, reserveId);
	        psInsertReturn.setDate(5, returnDate);
	        psInsertReturn.executeUpdate();

	        // 3. Do NOT delete from the 'reserve' table (keep history)

	        conn.commit();
	    } catch (SQLException e) {
	        if (conn != null) conn.rollback();
	        throw e;
	    } finally {
	        if (rs != null) rs.close();
	        if (psGetReserve != null) psGetReserve.close();
	        if (psInsertReturn != null) psInsertReturn.close();
	        if (conn != null) {
	            conn.setAutoCommit(true);
	            conn.close();
	        }
	    }
	}

    public static List<Object[]> getRecentReturns() throws SQLException {
        List<Object[]> list = new ArrayList<>();
        String sql = "SELECT r.ReturnID, a.adminName, u.UserName, r.returnDate " +
                     "FROM `return` r " +
                     "JOIN admin a ON r.AdminID = a.adminId " +
                     "JOIN users u ON r.UserID = u.UserID " +
                     "ORDER BY r.returnDate DESC LIMIT 10";
        try (Connection conn = connectionManager.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new Object[]{
                    rs.getInt(1), rs.getString(2), rs.getString(3), rs.getDate(4)
                });
            }
        }
        return list;
    }

    public static Set<Integer> getReturnedReserveIdsForUser(int userId) throws SQLException {
        Set<Integer> returned = new HashSet<>();
        String sql = "SELECT ReserveID FROM `return` WHERE UserID = ?";
        try (Connection conn = connectionManager.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    returned.add(rs.getInt(1));
                }
            }
        }
        return returned;
    }
}