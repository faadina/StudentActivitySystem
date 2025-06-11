package com.activity.controller;

import com.activity.DAO.ResourceDAO;
import com.activity.model.Resource;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/EditResourceBookingServlet")
public class EditResourceBookingServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        ResourceDAO dao = new ResourceDAO();
        Resource res = dao.getBookingById(id);

        request.setAttribute("res", res);
        request.getRequestDispatcher("editResourceBooking.jsp").forward(request, response);
    }
}