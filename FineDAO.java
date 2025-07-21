package library.DAO;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import library.connection.connectionManager;
import library.model.Fine;

public class FineDAO {
    private static Connection connection = null;

    //READ - Get fine by userID
    public static Fine getFineByUserId(int userId) throws SQLException {
        Fine fine = null;
        try {
            String query = "SELECT SELECT * FROM `finepayment` WHERE userid = ?";
            connection = connectionManager.getConnection();
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                fine = new Fine();
                fine.setFineId(rs.getInt("fineId"));
                fine.setUserId(rs.getInt("userId"));
                fine.setUsername(rs.getString("username"));
                fine.setBookTitle(rs.getString("title"));
                fine.setReason(rs.getString("reason"));
                fine.setAmount(rs.getDouble("amount"));
            }
            rs.close();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return fine;
    }

    public static void payFine(int fineId) throws SQLException {
        try {
            String query = "UPDATE fine SET paid = 1 WHERE fineId = ?";
            connection = connectionManager.getConnection();
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, fineId);
            ps.executeUpdate();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
} 