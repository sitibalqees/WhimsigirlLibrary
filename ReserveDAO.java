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
}    
    
