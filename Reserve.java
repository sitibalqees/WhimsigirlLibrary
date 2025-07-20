package library.model;

import java.io.Serializable;
import java.sql.Date;

public class Reserve implements Serializable {
    private static final long serialVersionUID = 1L;
    private int reserveId;
    private int userId;
    private int bookId;
    private String comments;
    private Date reserveDate;
    private Date dueDate;

    public Reserve() {}

    public int getReserveId() { return reserveId; }
    public void setReserveId(int reserveId) { this.reserveId = reserveId; }
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    public int getBookId() { return bookId; }
    public void setBookId(int bookId) { this.bookId = bookId; }
    public String getComments() { return comments; }
    public void setComments(String comments) { this.comments = comments; }
    public Date getReserveDate() { return reserveDate; }
    public void setReserveDate(Date reserveDate) { this.reserveDate = reserveDate; }
    public Date getDueDate() { return dueDate; }
    public void setDueDate(Date dueDate) { this.dueDate = dueDate; }
}