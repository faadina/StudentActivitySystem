package com.activity.controller;

import com.activity.dao.UserDAO;
import com.activity.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/signupController")
public class signupController extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phoneNo = request.getParameter("phone_no");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirm_password");
        String role = request.getParameter("role");

        if (!password.equals(confirmPassword)) {
            response.sendRedirect("signup.jsp?error=pass_mismatch");
            return;
        }

        User user = new User();
        user.setName(name);
        user.setEmail(email);
        user.setPhoneNo(phoneNo);
        user.setPassword(password);
        user.setRole(role);

        // Role-specific data
        if ("student".equals(role)) {
            user.setMatrixNo(request.getParameter("matrix_no"));
            user.setProgram(request.getParameter("program"));
            user.setFaculty(request.getParameter("faculty"));
        } else if ("staff".equals(role)) {
            user.setStaffRole(request.getParameter("staff_role"));
            user.setDepartment(request.getParameter("department"));
        } else if ("admin".equals(role)) {
            user.setStaffNo(request.getParameter("staff_no"));
        } else if ("organization".equals(role)) {
            user.setAdvisorName(request.getParameter("advisor_name"));
        }

        UserDAO userDAO = new UserDAO();
        boolean success = userDAO.register(user);

        if (success) {
            response.sendRedirect("signin.jsp?register=success");
        } else {
            response.sendRedirect("signup.jsp?error=exists");
        }
    }
}