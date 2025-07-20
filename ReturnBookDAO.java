package library.DAO;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import library.connection.connectionManager;

public class ReturnBookDAO {
    public static void returnBook(String title, String authorName, String username) throws SQLException {
        Connection connection = connectionManager.getConnection();
        try {
            // Remove the record from borrowed_books table
            String query = "DELETE FROM borrowed_books WHERE title = ? AND authorName = ? AND username = ?";
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setString(1, title);
            ps.setString(2, authorName);
            ps.setString(3, username);
            int affectedRows = ps.executeUpdate();
            ps.close();

            // Optionally, update the book's availability in the book table
            String updateBook = "UPDATE book SET availability = availability + 1 WHERE title = ? AND authorName = ?";
            PreparedStatement ps2 = connection.prepareStatement(updateBook);
            ps2.setString(1, title);
            ps2.setString(2, authorName);
            ps2.executeUpdate();
            ps2.close();

            if (affectedRows == 0) {
                throw new SQLException("No matching borrowed book found for return.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
    }
}