package library.model;

import java.io.Serializable;

public class Issue implements Serializable {
    private static final long serialVersionUID = 1L;
    private int issueID;
    private int userID;
    private int bookID;
    private String issue;
    private String proof;

    public Issue() {}

    public int getIssueID() {
        return issueID;
    }
    public void setIssueID(int issueID) {
        this.issueID = issueID;
    }
    public int getUserID() {
        return userID;
    }
    public void setUserID(int userID) {
        this.userID = userID;
    }
    public int getBookID() {
        return bookID;
    }
    public void setBookID(int bookID) {
        this.bookID = bookID;
    }
    public String getIssue() {
        return issue;
    }
    public void setIssue(String issue) {
        this.issue = issue;
    }
    public String getProof() {
        return proof;
    }
    public void setProof(String proof) {
        this.proof = proof;
    }
}