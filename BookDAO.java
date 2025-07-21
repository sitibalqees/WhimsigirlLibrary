package library.DAO;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import library.model.Book;
import library.connection.connectionManager;

public class BookDAO {
    // CREATE
    public static void addBook(Book book) throws SQLException {
        String query = "INSERT INTO book (Title, AuthorName, synopsis, Category, ISBN, Publisher, PublishYear, Price, ReserveID, fineID, image, imageFileName, imageContentType) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = connectionManager.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, book.getTitle());
            ps.setString(2, book.getAuthorName());
            ps.setString(3, book.getSynopsis());
            ps.setString(4, book.getCategory());
            ps.setInt(5, book.getIsbn());
            ps.setString(6, book.getPublisher());
            ps.setInt(7, book.getPublishYear());
            ps.setDouble(8, book.getPrice());
            if (book.getReserveId() != null) {
                ps.setInt(9, book.getReserveId());
            } else {
                ps.setNull(9, Types.INTEGER);
            }
            if (book.getFineId() != null) {
                ps.setInt(10, book.getFineId());
            } else {
                ps.setNull(10, Types.INTEGER);
            }
            if (book.getImage() != null) {
                ps.setBlob(11, book.getImage());
            } else {
                ps.setNull(11, Types.BLOB);
            }
            ps.setString(12, book.getImageFileName());
            ps.setString(13, book.getImageContentType());
            ps.executeUpdate();
        }
    }

    // READ - Get all books
    public static List<Book> getAllBooks() throws SQLException {
        List<Book> books = new ArrayList<>();
        String query = "SELECT * FROM book";
        try (Connection conn = connectionManager.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                books.add(extractBook(rs));
            }
        }
        return books;
    }

    // READ - Get a book by ID
    public static Book getBookById(int bookId) throws SQLException {
        String query = "SELECT * FROM book WHERE BookID = ?";
        try (Connection conn = connectionManager.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, bookId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return extractBook(rs);
                }
            }
        }
        return null;
    }

    // UPDATE
    public static void updateBook(Book book) throws SQLException {
        String query = "UPDATE book SET Title=?, AuthorName=?, synopsis=?, Category=?, ISBN=?, Publisher=?, PublishYear=?, Price=?, ReserveID=?, fineID=?, image=?, imageFileName=?, imageContentType=? WHERE BookID=?";
        try (Connection conn = connectionManager.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, book.getTitle());
            ps.setString(2, book.getAuthorName());
            ps.setString(3, book.getSynopsis());
            ps.setString(4, book.getCategory());
            ps.setInt(5, book.getIsbn());
            ps.setString(6, book.getPublisher());
            ps.setInt(7, book.getPublishYear());
            ps.setDouble(8, book.getPrice());
            if (book.getReserveId() != null) {
                ps.setInt(9, book.getReserveId());
            } else {
                ps.setNull(9, Types.INTEGER);
            }
            if (book.getFineId() != null) {
                ps.setInt(10, book.getFineId());
            } else {
                ps.setNull(10, Types.INTEGER);
            }
            if (book.getImage() != null) {
                ps.setBlob(11, book.getImage());
            } else {
                ps.setNull(11, Types.BLOB);
            }
            ps.setString(12, book.getImageFileName());
            ps.setString(13, book.getImageContentType());
            ps.setInt(14, book.getBookId());
            ps.executeUpdate();
        }
    }

    // DELETE
    public static void deleteBook(int bookId) throws SQLException {
        String query = "DELETE FROM book WHERE BookID = ?";
        try (Connection conn = connectionManager.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, bookId);
            ps.executeUpdate();
        }
    }

    // SEARCH
    public static List<Book> searchBooks(String title, String author, String isbn, String genre) throws SQLException {
        List<Book> books = new ArrayList<>();
        StringBuilder query = new StringBuilder("SELECT * FROM book WHERE 1=1");
        List<Object> params = new ArrayList<>();

        if (title != null && !title.trim().isEmpty()) {
            query.append(" AND Title LIKE ?");
            params.add("%" + title.trim() + "%");
        }
        if (author != null && !author.trim().isEmpty()) {
            query.append(" AND AuthorName LIKE ?");
            params.add("%" + author.trim() + "%");
        }
        if (isbn != null && !isbn.trim().isEmpty()) {
            query.append(" AND CAST(ISBN AS CHAR) LIKE ?");
            params.add("%" + isbn.trim() + "%");
        }
        if (genre != null && !genre.trim().isEmpty()) {
            query.append(" AND Category = ?");
            params.add(genre.trim());
        }

        try (Connection conn = connectionManager.getConnection();
             PreparedStatement ps = conn.prepareStatement(query.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    books.add(extractBook(rs));
                }
            }
        }
        return books;
    }

    // Helper to extract a Book from ResultSet
    private static Book extractBook(ResultSet rs) throws SQLException {
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
        book.setImage(rs.getBlob("image"));
        book.setImageFileName(rs.getString("imageFileName"));
        book.setImageContentType(rs.getString("imageContentType"));
        return book;
    }
}