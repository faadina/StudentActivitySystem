package com.activity.controller;

import com.activity.dao.UserDAO;
import com.activity.model.User;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/signinController")
public class signinController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        UserDAO userDAO = new UserDAO();
        User user = userDAO.login(email, password);

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("currentUser", user);
            session.setAttribute("currentRole", user.getRole());

            switch (user.getRole()) {
                case "student":
                    response.sendRedirect("studentDashboard.jsp");
                    break;
                case "staff":
                    response.sendRedirect("staffDashboard.jsp");
                    break;
                case "admin":
                    response.sendRedirect("adminDashboard.jsp");
                    break;
                case "organization":
                    response.sendRedirect("orgDashboard.jsp");
                    break;
                default:
                    response.sendRedirect("signin.jsp?error=invalid");
            }
        } else {
            response.sendRedirect("signin.jsp?error=invalid");
        }
    }
}