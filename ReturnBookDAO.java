package library.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import library.connection.connectionManager;

public class ReturnBookDAO {
    public static void returnBook(String userId, String bookId) throws SQLException {
        Connection connection = connectionManager.getConnection();
        try {
            // Remove the record from reserve table
            String query = "DELETE FROM `reserve` WHERE userId = ? AND bookId = ?";
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setString(1, userId);
            ps.setString(2, bookId);
            int affectedRows = ps.executeUpdate();
            ps.close();

           // Insert into return table
            String insertReturn = "INSERT INTO `return` (`AdminID`, `UserID`, `returnDate`) VALUES (?, ?, NOW())";
            PreparedStatement ps3 = connection.prepareStatement(insertReturn);
            ps3.setString(1, "1"); // Hardcoded AdminID for now
            ps3.setString(2, userId);
            ps3.executeUpdate();
            ps3.close();

            if (affectedRows == 0) {
                throw new SQLException("No matching borrowed book found for return.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
    }
}