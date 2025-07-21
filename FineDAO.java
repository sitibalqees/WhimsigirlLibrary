package library.DAO;

import java.sql.*;
import java.util.*;
import library.connection.connectionManager;

public class FineDAO {
    public static List<Map<String, Object>> getFinesByUser(int userId) throws SQLException {
        List<Map<String, Object>> fines = new ArrayList<>();
        Connection conn = connectionManager.getConnection();
        PreparedStatement ps = conn.prepareStatement("SELECT * FROM finepayment WHERE userID = ?");
        ps.setInt(1, userId);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Map<String, Object> fine = new HashMap<>();
            fine.put("fineID", rs.getInt("fineID"));
            fine.put("bookID", rs.getInt("bookID"));
            fine.put("fine_amount", rs.getDouble("fine_amount"));
            fine.put("status", rs.getString("status"));
            fine.put("payment_date", rs.getDate("payment_date"));
            fine.put("reason", rs.getString("reason"));
            fines.add(fine);
        }
        rs.close();
        ps.close();
        conn.close();
        return fines;
    }

    public static void payFine(int fineID) throws SQLException {
        Connection conn = connectionManager.getConnection();
        PreparedStatement ps = conn.prepareStatement("UPDATE finepayment SET status = 'paid', payment_date = CURDATE() WHERE fineID = ?");
        ps.setInt(1, fineID);
        ps.executeUpdate();
        ps.close();
        conn.close();
    }

    public static List<Map<String, Object>> getAllFines(String userEmail, String status) throws SQLException {
        List<Map<String, Object>> fines = new ArrayList<>();
        Connection conn = connectionManager.getConnection();
        StringBuilder query = new StringBuilder(
            "SELECT f.*, u.UserEmail, b.Title as bookTitle FROM finepayment f " +
            "JOIN users u ON f.userID = u.UserID " +
            "JOIN book b ON f.bookID = b.BookID WHERE 1=1 "
        );
        List<Object> params = new ArrayList<>();
        if (userEmail != null && !userEmail.isEmpty()) {
            query.append(" AND u.UserEmail LIKE ?");
            params.add("%" + userEmail + "%");
        }
        if (status != null && !status.isEmpty()) {
            query.append(" AND f.status = ?");
            params.add(status);
        }
        PreparedStatement ps = conn.prepareStatement(query.toString());
        for (int i = 0; i < params.size(); i++) {
            ps.setObject(i + 1, params.get(i));
        }
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Map<String, Object> fine = new HashMap<>();
            fine.put("fineID", rs.getInt("fineID"));
            fine.put("userID", rs.getInt("userID"));
            fine.put("userEmail", rs.getString("UserEmail"));
            fine.put("bookID", rs.getInt("bookID"));
            fine.put("bookTitle", rs.getString("bookTitle"));
            fine.put("fine_amount", rs.getDouble("fine_amount"));
            fine.put("status", rs.getString("status"));
            fine.put("payment_date", rs.getDate("payment_date"));
            fine.put("reason", rs.getString("reason"));
            fines.add(fine);
        }
        rs.close();
        ps.close();
        conn.close();
        return fines;
    }

    public static boolean hasUnpaidFines(int userId) throws SQLException {
        Connection conn = connectionManager.getConnection();
        PreparedStatement ps = conn.prepareStatement(
            "SELECT COUNT(*) FROM finepayment WHERE userID = ? AND status = 'unpaid'");
        ps.setInt(1, userId);
        ResultSet rs = ps.executeQuery();
        boolean hasUnpaid = false;
        if (rs.next()) {
            hasUnpaid = rs.getInt(1) > 0;
        }
        rs.close();
        ps.close();
        conn.close();
        return hasUnpaid;
    }
}