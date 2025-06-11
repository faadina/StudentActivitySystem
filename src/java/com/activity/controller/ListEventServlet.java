package com.activity.controller;

import com.activity.DAO.EventDAO;
import com.activity.model.Event;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ListEventServlet", urlPatterns = {"/ListEventServlet"})
public class ListEventServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        EventDAO dao = new EventDAO();
        List<Event> eventList = dao.getAllEvents();

        request.setAttribute("eventList", eventList);
        RequestDispatcher dispatcher = request.getRequestDispatcher("orgListEvent.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
