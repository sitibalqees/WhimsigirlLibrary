package library.DAO;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.io.InputStream;
import library.model.Book;
import library.connection.connectionManager;

public class BookDAO {
    private static Connection connection = null;

    // SELECT - get all books from database
    public static List<Book> getAllBooks() throws SQLException {
        List<Book> books = new ArrayList<>();
        try {
            String query = "SELECT * FROM book";
            connection = connectionManager.getConnection();
            PreparedStatement ps = connection.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Book book = new Book();
                book.setBookId(rs.getInt("BookID"));
                book.setTitle(rs.getString("Title"));
                book.setAuthorName(rs.getString("AuthorName"));
                book.setSynopsis(rs.getString("synopsis"));
                book.setCategory(rs.getString("Category"));
                book.setIsbn(rs.getInt("ISBN"));
                book.setPublisher(rs.getString("Publisher"));
                book.setPublishYear(rs.getInt("PublishYear"));
                book.setPrice(rs.getDouble("Price"));
                int reserveId = rs.getInt("ReserveID");
                book.setReserveId(rs.wasNull() ? null : reserveId);
                int fineId = rs.getInt("fineID");
                book.setFineId(rs.wasNull() ? null : fineId);
                
                // Handle image fields
                Blob imageBlob = rs.getBlob("image");
                book.setImage(imageBlob);
                book.setImageFileName(rs.getString("imageFileName"));
                book.setImageContentType(rs.getString("imageContentType"));
                
                books.add(book);
            }
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return books;
    }
    
    // Get book by ID with image
    public static Book getBookById(int bookId) throws SQLException {
        Book book = null;
        try {
            String query = "SELECT * FROM book WHERE BookID = ?";
            connection = connectionManager.getConnection();
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, bookId);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                book = new Book();
                book.setBookId(rs.getInt("BookID"));
                book.setTitle(rs.getString("Title"));
                book.setAuthorName(rs.getString("AuthorName"));
                book.setSynopsis(rs.getString("synopsis"));
                book.setCategory(rs.getString("Category"));
                book.setIsbn(rs.getInt("ISBN"));
                book.setPublisher(rs.getString("Publisher"));
                book.setPublishYear(rs.getInt("PublishYear"));
                book.setPrice(rs.getDouble("Price"));
                int reserveId = rs.getInt("ReserveID");
                book.setReserveId(rs.wasNull() ? null : reserveId);
                int fineId = rs.getInt("fineID");
                book.setFineId(rs.wasNull() ? null : fineId);
                
                // Handle image fields
                Blob imageBlob = rs.getBlob("image");
                book.setImage(imageBlob);
                book.setImageFileName(rs.getString("imageFileName"));
                book.setImageContentType(rs.getString("imageContentType"));
            }
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return book;
    }
    
 // Add book with image
    public static void addBook(Book book) throws SQLException {
        try {
            String query = "INSERT INTO book (Title, AuthorName, synopsis, Category, ISBN, Publisher, PublishYear, Price, Quantity, ReserveID, fineID, availability, image, imageFileName, imageContentType) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            connection = connectionManager.getConnection();
            PreparedStatement ps = connection.prepareStatement(query);
            
            ps.setString(1, book.getTitle());
            ps.setString(2, book.getAuthorName());
            ps.setString(3, book.getSynopsis());
            ps.setString(4, book.getCategory());
            ps.setInt(5, book.getIsbn());
            ps.setString(6, book.getPublisher());
            ps.setInt(7, book.getPublishYear());
            ps.setDouble(8, book.getPrice());
            
            if (book.getReserveId() != null) {
                ps.setInt(10, book.getReserveId());
            } else {
                ps.setNull(10, Types.INTEGER);
            }
            
            if (book.getFineId() != null) {
                ps.setInt(11, book.getFineId());
            } else {
                ps.setNull(11, Types.INTEGER);
            }
            
            
            // Handle image
            if (book.getImage() != null) {
                ps.setBlob(13, book.getImage());
            } else {
                ps.setNull(13, Types.BLOB);
            }
            
            ps.setString(14, book.getImageFileName());
            ps.setString(15, book.getImageContentType());
            
            ps.executeUpdate();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
    }
    
    // Update book with image
    public static void updateBook(Book book) throws SQLException {
        try {
            String query = "UPDATE book SET Title=?, AuthorName=?, synopsis=?, Category=?, ISBN=?, Publisher=?, PublishYear=?, Price=?, Quantity=?, ReserveID=?, fineID=?, availability=?, image=?, imageFileName=?, imageContentType=? WHERE BookID=?";
            connection = connectionManager.getConnection();
            PreparedStatement ps = connection.prepareStatement(query);
            
            ps.setString(1, book.getTitle());
            ps.setString(2, book.getAuthorName());
            ps.setString(3, book.getSynopsis());
            ps.setString(4, book.getCategory());
            ps.setInt(5, book.getIsbn());
            ps.setString(6, book.getPublisher());
            ps.setInt(7, book.getPublishYear());
            ps.setDouble(8, book.getPrice());
            
            if (book.getReserveId() != null) {
                ps.setInt(10, book.getReserveId());
            } else {
                ps.setNull(10, Types.INTEGER);
            }
            
            if (book.getFineId() != null) {
                ps.setInt(11, book.getFineId());
            } else {
                ps.setNull(11, Types.INTEGER);
            }
            
            
            // Handle image
            if (book.getImage() != null) {
                ps.setBlob(13, book.getImage());
            } else {
                ps.setNull(13, Types.BLOB);
            }
            
            ps.setString(14, book.getImageFileName());
            ps.setString(15, book.getImageContentType());
            ps.setInt(16, book.getBookId());
            
            ps.executeUpdate();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
    }
    
    // Delete book
    public static void deleteBook(int bookId) throws SQLException {
        try {
            String query = "DELETE FROM book WHERE BookID = ?";
            connection = connectionManager.getConnection();
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, bookId);
            ps.executeUpdate();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
    }
}