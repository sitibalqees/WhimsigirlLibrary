package library.model;


import java.io.Serializable;

public class Fine implements Serializable {
    private int fineId;
    private int userId;
    private String username;
    private String bookTitle;
    private String reason;
    private double amount;

    public Fine() {}

    public int getFineId() {
        return fineId;
    }
    public void setFineId(int fineId) {
        this.fineId = fineId;
    }
    public String getUsername() {
        return username;
    }
    public void setUsername(String username) {
        this.username = username;
    }
    public String getBookTitle() {
        return bookTitle;
    }
    public void setBookTitle(String bookTitle) {
        this.bookTitle = bookTitle;
    }
    public String getReason() {
        return reason;
    }
    public void setReason(String reason) {
        this.reason = reason;
    }
    public double getAmount() {
        return amount;
    }
    public void setAmount(double amount) {
        this.amount = amount;
    }

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}
} 
