// ReturnBookDAO.java
package library.DAO;

import java.sql.*;
import java.util.*;
import library.connection.connectionManager;
import library.model.*;

public class ReturnBookDAO {
    public static void processReturn(int adminId, String username, int reserveId, java.sql.Date returnDate) throws SQLException {
        Connection conn = null;
        try {
            conn = connectionManager.getConnection();
            conn.setAutoCommit(false);

            // Get UserID from reserve
            int userId = -1;
            try (PreparedStatement ps = conn.prepareStatement("SELECT UserID FROM reserve WHERE ReserveID=?")) {
                ps.setInt(1, reserveId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        userId = rs.getInt("UserID");
                    } else {
                        throw new SQLException("Reservation not found.");
                    }
                }
            }

            // Delete from reserve
            try (PreparedStatement ps = conn.prepareStatement("DELETE FROM reserve WHERE ReserveID=?")) {
                ps.setInt(1, reserveId);
                ps.executeUpdate();
            }

            // Insert into return table (no BookID)
            try (PreparedStatement ps = conn.prepareStatement(
                "INSERT INTO `return` (AdminID, UserID, returnDate) VALUES (?, ?, ?)")) {
                ps.setInt(1, adminId);
                ps.setInt(2, userId);
                ps.setDate(3, returnDate);
                ps.executeUpdate();
            }

            conn.commit();
        } catch (SQLException e) {
            if (conn != null) conn.rollback();
            throw e;
        } finally {
            if (conn != null) conn.setAutoCommit(true);
            if (conn != null) conn.close();
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
}