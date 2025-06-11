package com.activity.controller;

import com.activity.DAO.ResourceDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/StatusResourceServlet")
public class StatusResourceServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        String action = request.getParameter("action");

        String status = action.equals("approve") ? "Approved" : "Rejected";

        ResourceDAO dao = new ResourceDAO();
        dao.updateBookingStatus(id, status);

        request.setAttribute("statusUpdated", true);
        request.setAttribute("resourceList", dao.getAllBookings());
        request.getRequestDispatcher("orgListResourceBookings.jsp").forward(request, response);
    }
}