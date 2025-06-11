package com.activity.controller;

import com.activity.DAO.FeedbackDAO;
import com.activity.DAO.EventDAO;
import com.activity.model.Feedback;
import com.activity.model.Event;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/SubmitFeedbackServlet")
public class SubmitFeedbackServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String eventName = request.getParameter("eventName");
        String experienceRating = request.getParameter("experienceRating");
        String comment = request.getParameter("comment");

        Feedback feedback = new Feedback();
        feedback.setEventName(eventName);
        feedback.setExperienceRating(experienceRating);
        feedback.setComment(comment);

        FeedbackDAO dao = new FeedbackDAO();
        boolean result = dao.insertFeedback(feedback);

        // Reload event list for dropdown
        EventDAO eventDAO = new EventDAO();
        List<Event> eventList = eventDAO.getAllEvents();
        request.setAttribute("eventList", eventList);

        if (result) {
            request.setAttribute("feedbackSuccess", true);
        }

        request.getRequestDispatcher("studentFeedback.jsp").forward(request, response);
    }
}