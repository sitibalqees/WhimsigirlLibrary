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
	private static final String SELECT_USER_LOGIN = "SELECT * FROM admin WHERE email = ? AND password = ?";
	//login
	public static Admin login(String email, String password) throws SQLException, NoSuchAlgorithmException {
	    MessageDigest md = MessageDigest.getInstance("MD5");
	    md.update(password.getBytes());
	    byte byteData[] = md.digest();
	    StringBuffer sb = new StringBuffer();
	    for (int i = 0; i < byteData.length; i++) {
	        sb.append(String.format("%02x", byteData[i]));
	    }

	    Admin admin = new Admin();
	    try {
	        con = connectionManager.getConnection();
	        ps = con.prepareStatement(SELECT_USER_LOGIN);
	        ps.setString(1, email);
	        ps.setString(2, sb.toString());
	        rs = ps.executeQuery();
	        if (rs.next()) {
	            admin.setAdminId(rs.getInt("adminId"));
	            admin.setAdminEmail(rs.getString("email"));
	            admin.setAdminPassword(rs.getString("password"));
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
}