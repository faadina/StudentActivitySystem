package com.activity.controller;

import com.activity.model.Resource;
import com.activity.DAO.ResourceDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/BookResourceServlet")
public class BookResourceServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Resource resource = new Resource();
        resource.setDate(request.getParameter("date"));
        resource.setDuration(request.getParameter("duration"));
        resource.setTime(request.getParameter("time"));
        resource.setResourceName(request.getParameter("resourceName"));
        resource.setQuantity(Integer.parseInt(request.getParameter("quantity")));

        ResourceDAO dao = new ResourceDAO();
        boolean result = dao.insertResourceBooking(resource);

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        if (result) {
            out.println("<script>alert('Resource booking submitted successfully!'); location='orgDashboard.jsp';</script>");
        } else {
            out.println("<script>alert('Failed to book resource. Try again.'); location='orgBookResource.jsp';</script>");
        }
    }
}
