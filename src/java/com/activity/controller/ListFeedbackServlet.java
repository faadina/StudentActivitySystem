package com.activity.controller;

import com.activity.DAO.FeedbackDAO;
import com.activity.model.Feedback;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/ListFeedbackServlet")
public class ListFeedbackServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        FeedbackDAO dao = new FeedbackDAO();
        List<Feedback> feedbackList = dao.getAllFeedback();

        request.setAttribute("feedbackList", feedbackList);
        RequestDispatcher dispatcher = request.getRequestDispatcher("orgListFeedback.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
