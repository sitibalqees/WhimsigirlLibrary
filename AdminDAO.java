package library.DAO;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import library.connection.connectionManager;
import library.model.Admin;

public class AdminDAO {
    private static Connection con = null;
    private static PreparedStatement ps = null;
    private static ResultSet rs = null;
    private static final String SELECT_ADMIN_LOGIN = "SELECT * FROM admin WHERE adminEmail = ? AND adminPassword = ?";
    private static final String INSERT_ADMIN = "INSERT INTO admin (adminName, adminPassword, adminEmail) VALUES (?, ?, ?)";

    // Login method
    public static Admin login(String email, String password) throws SQLException, NoSuchAlgorithmException {
        // Hash the password using MD5
        MessageDigest md = MessageDigest.getInstance("MD5");
        md.update(password.getBytes());
        byte byteData[] = md.digest();
        StringBuilder sb = new StringBuilder();
        for (byte b : byteData) {
            sb.append(String.format("%02x", b));
        }

        Admin admin = new Admin();
        try {
            con = connectionManager.getConnection();
            ps = con.prepareStatement(SELECT_ADMIN_LOGIN);
            ps.setString(1, email);
            ps.setString(2, sb.toString());
            rs = ps.executeQuery();
            if (rs.next()) {
                admin.setAdminId(rs.getInt("adminId"));
                admin.setAdminName(rs.getString("adminName"));
                admin.setAdminEmail(rs.getString("adminEmail"));
                admin.setAdminPassword(rs.getString("adminPassword"));
                admin.setLoggedIn(true);
            } else {
                admin.setLoggedIn(false);
            }
            con.close();
        } catch(SQLException e) {
            e.printStackTrace();
        }
        return admin;
    }

    // Register method
    public static boolean register(Admin admin) throws SQLException, NoSuchAlgorithmException {
        try {
            // Hash the password using MD5
            MessageDigest md = MessageDigest.getInstance("MD5");
            md.update(admin.getAdminPassword().getBytes());
            byte byteData[] = md.digest();
            StringBuilder sb = new StringBuilder();
            for (byte b : byteData) {
                sb.append(String.format("%02x", b));
            }

            con = connectionManager.getConnection();
            ps = con.prepareStatement(INSERT_ADMIN);
            ps.setString(1, admin.getAdminName());
            ps.setString(2, sb.toString());
            ps.setString(3, admin.getAdminEmail());
            int rows = ps.executeUpdate();
            con.close();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
    }

    public static java.util.List<Admin> getAllAdmins() throws SQLException {
        java.util.List<Admin> admins = new java.util.ArrayList<>();
        String query = "SELECT * FROM admin";
        try {
            con = connectionManager.getConnection();
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                Admin admin = new Admin();
                admin.setAdminId(rs.getInt("adminId"));
                admin.setAdminName(rs.getString("adminName"));
                admin.setAdminPassword(rs.getString("adminPassword"));
                admin.setAdminEmail(rs.getString("adminEmail"));
                admins.add(admin);
            }
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
        return admins;
    }
}