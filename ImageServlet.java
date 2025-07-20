package library.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.FileInputStream;
import java.io.File;
import java.sql.Blob;
import java.sql.SQLException;
import library.DAO.BookDAO;
import library.model.Book;

@WebServlet("/image")
public class ImageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String bookId = request.getParameter("bookId");
        
        if (bookId == null || bookId.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Book ID is required");
            return;
        }
        
        try {
            int id = Integer.parseInt(bookId);
            Book book = BookDAO.getBookById(id);
            
            if (book == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Book not found");
                return;
            }
            
            // First try to get image from database BLOB
            if (book.getImage() != null) {
                serveBlobImage(book, response);
                return;
            }
            
            // If no BLOB, try to serve from file system
            if (book.getImageFileName() != null && !book.getImageFileName().isEmpty()) {
                serveFileImage(book, response);
                return;
            }
            
            // If no image at all, serve default image
            serveDefaultImage(response);
            
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Book ID");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
        }
    }
    
    private void serveBlobImage(Book book, HttpServletResponse response) throws IOException, SQLException {
        Blob blob = book.getImage();
        InputStream inputStream = blob.getBinaryStream();
        
        // Set content type
        String contentType = book.getImageContentType();
        if (contentType == null || contentType.isEmpty()) {
            contentType = "image/jpeg"; // Default to JPEG
        }
        response.setContentType(contentType);
        
        // Set content length
        response.setContentLength((int) blob.length());
        
        // Write image data to response
        OutputStream outputStream = response.getOutputStream();
        byte[] buffer = new byte[4096];
        int bytesRead;
        
        while ((bytesRead = inputStream.read(buffer)) != -1) {
            outputStream.write(buffer, 0, bytesRead);
        }
        
        inputStream.close();
        outputStream.flush();
        outputStream.close();
    }
    
    private void serveFileImage(Book book, HttpServletResponse response) throws IOException {
        String imageFileName = book.getImageFileName();
        String contentType = book.getImageContentType();
        
        if (contentType == null || contentType.isEmpty()) {
            contentType = "image/png"; // Default to PNG since your images are PNG
        }
        
        // Construct file path
        String imagePath = getServletContext().getRealPath("/image/" + imageFileName);
        File imageFile = new File(imagePath);
        
        if (!imageFile.exists()) {
            serveDefaultImage(response);
            return;
        }
        
        response.setContentType(contentType);
        response.setContentLength((int) imageFile.length());
        
        // Write file to response
        try (FileInputStream fileInputStream = new FileInputStream(imageFile);
             OutputStream outputStream = response.getOutputStream()) {
            
            byte[] buffer = new byte[4096];
            int bytesRead;
            
            while ((bytesRead = fileInputStream.read(buffer)) != -1) {
                outputStream.write(buffer, 0, bytesRead);
            }
        }
    }
    
    private void serveDefaultImage(HttpServletResponse response) throws IOException {
        String defaultImagePath = getServletContext().getRealPath("/image/default-book-cover.jpg");
        File defaultImage = new File(defaultImagePath);
        
        if (defaultImage.exists()) {
            response.setContentType("image/jpeg");
            response.setContentLength((int) defaultImage.length());
            
            try (FileInputStream fileInputStream = new FileInputStream(defaultImage);
                 OutputStream outputStream = response.getOutputStream()) {
                
                byte[] buffer = new byte[4096];
                int bytesRead;
                
                while ((bytesRead = fileInputStream.read(buffer)) != -1) {
                    outputStream.write(buffer, 0, bytesRead);
                }
            }
        } else {
            // If no default image, send a simple text response
            response.setContentType("text/plain");
            response.getWriter().write("No image available");
        }
    }
}