package library.model;

public class User {
    private int UserID;
    private String UserName;
    private int ICNum;
    private String UserPassword;
    private String UserEmail;
    private boolean loggedIn;

    public User() {}

    
    public User(int userID, String userName, int iCNum, String userPassword, String userEmail, boolean loggedIn) {
		super();
		UserID = userID;
		UserName = userName;
		ICNum = iCNum;
		UserPassword = userPassword;
		UserEmail = userEmail;
		this.loggedIn = loggedIn;
	}

    

	public int getUserID() {
		return UserID;
	}


	public void setUserID(int userID) {
		UserID = userID;
	}


	public String getUserName() {
		return UserName;
	}


	public void setUserName(String userName) {
		UserName = userName;
	}


	public int getICNum() {
		return ICNum;
	}


	public void setICNum(int iCNum) {
		ICNum = iCNum;
	}


	public String getUserPassword() {
		return UserPassword;
	}


	public void setUserPassword(String userPassword) {
		UserPassword = userPassword;
	}


	public String getUserEmail() {
		return UserEmail;
	}


	public void setUserEmail(String userEmail) {
		UserEmail = userEmail;
	}


	public boolean isLoggedIn() { return loggedIn; }
    public void setLoggedIn(boolean loggedIn) { this.loggedIn = loggedIn; }
}