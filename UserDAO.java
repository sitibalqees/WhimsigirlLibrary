package library.DAO;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import library.connection.connectionManager;
import library.model.User;

public class UserDAO {
    private static Connection con = null;
    private static PreparedStatement ps = null;
    private static ResultSet rs = null;
    private static final String SELECT_USER_LOGIN = "SELECT * FROM users WHERE UserEmail = ? AND UserPassword = ?";
    private static final String INSERT_USER = "INSERT INTO users (UserName, UserPassword, UserEmail) VALUES (?, ?, ?)";

    // Login method
    public static User login(String email, String password) throws SQLException, NoSuchAlgorithmException {
        // Hash the password using MD5
        MessageDigest md = MessageDigest.getInstance("MD5");
        md.update(password.getBytes());
        byte byteData[] = md.digest();
        StringBuilder sb = new StringBuilder();
        for (byte b : byteData) {
            sb.append(String.format("%02x", b));
        }

        User user = new User();
        try {
            con = connectionManager.getConnection();
            ps = con.prepareStatement(SELECT_USER_LOGIN);
            ps.setString(1, email);
            ps.setString(2, sb.toString());
            rs = ps.executeQuery();
            if (rs.next()) {
                user.setUserID(rs.getInt("UserID"));
                user.setUserName(rs.getString("UserName"));
                user.setUserPassword(rs.getString("UserPassword"));
                user.setUserEmail(rs.getString("UserEmail"));
                user.setLoggedIn(true);
            } else {
                user.setLoggedIn(false);
            }
            con.close();
        } catch(SQLException e) {
            e.printStackTrace();
        }
        return user;
    }

    // Register method
    public static boolean register(User user) throws SQLException {
        try {
            con = connectionManager.getConnection();
            ps = con.prepareStatement(INSERT_USER);
            ps.setString(1, user.getUserName());
            ps.setString(2, user.getUserPassword());
            ps.setString(3, user.getUserEmail());
            int rows = ps.executeUpdate();
            con.close();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
    }
    
    public static List<User> getAllUsers() throws SQLException {
        List<User> users = new ArrayList<>();
        String query = "SELECT * FROM users";
        try {
            con = connectionManager.getConnection();
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setUserID(rs.getInt("UserID"));
                user.setUserName(rs.getString("UserName"));
                user.setUserPassword(rs.getString("UserPassword"));
                user.setUserEmail(rs.getString("UserEmail"));
                users.add(user);
            }
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
        return users;
    }
    
    public static int getUserIdByUsername(String username) throws SQLException {
        int userId = -1;
        try (Connection con = connectionManager.getConnection();
             PreparedStatement ps = con.prepareStatement("SELECT UserID FROM users WHERE UserName=?")) {
            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) userId = rs.getInt("UserID");
                else throw new SQLException("User not found.");
            }
        }
        return userId;
    }
}