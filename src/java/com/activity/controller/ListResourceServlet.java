package com.activity.controller;

import com.activity.DAO.ResourceDAO;
import com.activity.model.Resource;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.servlet.RequestDispatcher;
import java.io.IOException;
import java.util.List;

@WebServlet("/ListResourceServlet")
public class ListResourceServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ResourceDAO dao = new ResourceDAO();
        List<Resource> resourceList = dao.getAllBookings();

        request.setAttribute("resourceList", resourceList);
        RequestDispatcher dispatcher = request.getRequestDispatcher("orgListResourceBookings.jsp");
        dispatcher.forward(request, response);
    }
}
