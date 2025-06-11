package com.activity.controller;

import com.activity.dao.DashboardDAO;
import com.activity.model.Event;
import com.activity.model.User;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import java.util.List;

@WebServlet("/StudentDashboardServlet")
public class StudentDashboardServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || !"student".equals(user.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }

        DashboardDAO dao = new DashboardDAO();
        String studentName = user.getUsername(); // You can query real name if needed

        request.setAttribute("studentName", studentName);
        request.setAttribute("joinedCount", dao.getJoinedEventCount(user.getUserId()));
        request.setAttribute("certificateCount", dao.getCertificateCount(user.getUserId()));
        request.setAttribute("pendingFeedback", dao.getPendingFeedbackCount(user.getUserId()));
        request.setAttribute("upcomingEvents", dao.getUpcomingEvents());

        RequestDispatcher dispatcher = request.getRequestDispatcher("studentDashboard.jsp");
        dispatcher.forward(request, response);
    }
}
