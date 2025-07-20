package library.DAO;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import library.model.Issue;
import library.connection.connectionManager;

public class IssueDAO {
    private static Connection connection = null;

    // CREATE
    public static void addIssue(Issue issue) throws SQLException {
        try {
            String query = "INSERT INTO issue (UserID, BookID, issue, proof) VALUES (?, ?, ?, ?)";
            connection = connectionManager.getConnection();
            PreparedStatement ps = connection.prepareStatement(query);

            ps.setInt(1, issue.getUserID());
            ps.setInt(2, issue.getBookID());
            ps.setString(3, issue.getIssue());
            ps.setString(4, issue.getProof());

            ps.executeUpdate();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // READ ALL
    public static List<Issue> getIssuesByUserId(int userId) throws SQLException {
        List<Issue> issues = new ArrayList<>();
        String query = "SELECT * FROM issue WHERE UserID = ?";
        Connection connection = connectionManager.getConnection();
        PreparedStatement ps = connection.prepareStatement(query);
        ps.setInt(1, userId);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Issue issue = new Issue();
            issue.setIssueID(rs.getInt("issueID"));
            issue.setUserID(rs.getInt("UserID"));
            issue.setBookID(rs.getInt("BookID"));
            issue.setIssue(rs.getString("issue"));
            issue.setProof(rs.getString("proof")); // image filename
            issues.add(issue);
        }
        rs.close();
        ps.close();
        return issues;
    }

    // READ BY ID
    public static Issue getIssueById(int issueID) throws SQLException {
        Issue issue = null;
        try {
            String query = "SELECT * FROM issue WHERE issueID = ?";
            connection = connectionManager.getConnection();
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, issueID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                issue = new Issue();
                issue.setIssueID(rs.getInt("issueID"));
                issue.setUserID(rs.getInt("UserID"));
                issue.setBookID(rs.getInt("BookID"));
                issue.setIssue(rs.getString("issue"));
                issue.setProof(rs.getString("proof"));
            }
            rs.close();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return issue;
    }

    // UPDATE
    public static void updateIssue(Issue issue) throws SQLException {
        try {
            String query = "UPDATE issue SET UserID=?, BookID=?, issue=?, proof=? WHERE issueID=?";
            connection = connectionManager.getConnection();
            PreparedStatement ps = connection.prepareStatement(query);

            ps.setInt(1, issue.getUserID());
            ps.setInt(2, issue.getBookID());
            ps.setString(3, issue.getIssue());
            ps.setString(4, issue.getProof());
            ps.setInt(5, issue.getIssueID());

            ps.executeUpdate();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // DELETE
    public static void deleteIssue(int issueID) throws SQLException {
        try {
            String query = "DELETE FROM issue WHERE issueID = ?";
            connection = connectionManager.getConnection();
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, issueID);
            ps.executeUpdate();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}