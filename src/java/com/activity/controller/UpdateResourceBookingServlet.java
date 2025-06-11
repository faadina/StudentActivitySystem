package com.activity.controller;

import com.activity.DAO.ResourceDAO;
import com.activity.model.Resource;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/UpdateResourceBookingServlet")
public class UpdateResourceBookingServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Resource res = new Resource();
        res.setId(Integer.parseInt(request.getParameter("id")));
        res.setDate(request.getParameter("date"));
        res.setDuration(request.getParameter("duration"));
        res.setTime(request.getParameter("time"));
        res.setResourceName(request.getParameter("resourceName"));
        res.setQuantity(Integer.parseInt(request.getParameter("quantity")));

        ResourceDAO dao = new ResourceDAO();
        dao.updateBooking(res);

        request.setAttribute("resourceList", dao.getAllBookings());
        request.setAttribute("statusUpdated", true);
        request.getRequestDispatcher("orgListResourceBookings.jsp").forward(request, response);
    }
}
