package com.activity.controller;

import com.activity.model.Event;
import com.activity.DAO.EventDAO;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import java.io.*;
import java.util.UUID;

@WebServlet("/CreateEventServlet")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,        // 1MB threshold
    maxFileSize = 1024 * 1024 * 2,          // 2MB max file size
    maxRequestSize = 1024 * 1024 * 10       // 10MB max total size
)
public class CreateEventServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("orgCreateEvent.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Event event = new Event();
        event.setName(request.getParameter("name"));
        event.setDate(request.getParameter("date"));
        event.setTime(request.getParameter("time"));
        event.setDescription(request.getParameter("description"));
        event.setParticipants(Integer.parseInt(request.getParameter("participants")));
        event.setCategory(request.getParameter("category"));
        event.setDepartment(request.getParameter("department"));

        // Handle registration fee safely
        String feeStr = request.getParameter("fee");
        try {
            event.setFee(feeStr == null || feeStr.isEmpty() ? 0.0 : Double.parseDouble(feeStr));
        } catch (NumberFormatException e) {
            showPopup(response, "Invalid registration fee.", "orgCreateEvent.jsp");
            return;
        }

        Part filePart = request.getPart("paperwork");
        String fileName = getFileName(filePart);

        // Check file is PDF only
        String contentType = filePart.getContentType();
        if (!"application/pdf".equals(contentType) || !fileName.toLowerCase().endsWith(".pdf")) {
            showPopup(response, "Only PDF files are allowed (max 2MB).", "orgCreateEvent.jsp");
            return;
        }

        // Generate UUID to prevent file name collision
        String uniqueFileName = UUID.randomUUID().toString() + "_" + fileName;

        // Save uploaded file to /uploads directory
        String uploadPath = getServletContext().getRealPath("/uploads");
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdirs();

        try (InputStream fileContent = filePart.getInputStream();
             FileOutputStream fos = new FileOutputStream(new File(uploadPath, uniqueFileName))) {

            byte[] buffer = new byte[1024];
            int bytesRead;
            while ((bytesRead = fileContent.read(buffer)) != -1) {
                fos.write(buffer, 0, bytesRead);
            }

        } catch (IOException ex) {
            showPopup(response, "Error saving file: " + ex.getMessage(), "orgCreateEvent.jsp");
            return;
        }

        event.setPaperworkFileName(uniqueFileName);

        EventDAO dao = new EventDAO();
        boolean result = dao.insertEvent(event);

        if (result) {
            // ✅ Show success popup and redirect to dashboard
            showPopup(response, "Event created successfully!", "orgDashboard.jsp");
        } else {
            showPopup(response, "Event creation failed. Please try again.", "orgCreateEvent.jsp");
        }
    }

    private String getFileName(Part part) {
        for (String content : part.getHeader("content-disposition").split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf('=') + 2).replace("\"", "");
            }
        }
        return "";
    }

    private void showPopup(HttpServletResponse response, String message, String redirectPage) throws IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        out.println("<script type='text/javascript'>");
        out.println("alert('" + message.replace("'", "\\'") + "');");
        out.println("location='" + redirectPage + "';");
        out.println("</script>");
    }
}
