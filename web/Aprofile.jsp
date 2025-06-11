<%@ page import="com.activity.model.User" %>
<%@ page session="true" %>
<%
    User currentUser = (User) session.getAttribute("currentUser");
    if (currentUser == null) {
        response.sendRedirect("signin.jsp?error=unauthorized");
        return;
    }
    String role = (String) session.getAttribute("currentRole");
    if ("student".equals(role)) {
%>
    <jsp:include page="studentSidebar.jsp" />
<% } else if ("staff".equals(role)) { %>
    <jsp:include page="staffSidebar.jsp" />
<% } else if ("admin".equals(role)) { %>
    <jsp:include page="adminSidebar.jsp" />
<% } else if ("organization".equals(role)) { %>
    <jsp:include page="orgSidebar.jsp" />
<% } %>

<!DOCTYPE html>
<html>
<head>
    <title>PROFILE</title>
    <style>
        body {
          font-family: 'Segoe UI', sans-serif;
          margin: 0;
          background-color: #f5f5f5;
        }
        .main {
          margin-left: 220px;
          padding: 40px;
        }
        .profile-box {
            background-color: #c39bd3;
            padding: 30px;
            border-radius: 15px;
            width: 600px;
        }
        .profile-box h2 { text-align: center; margin-top: 0; }
        .profile-box p { margin: 10px 0; font-weight: bold; }
        .profile-box input[type="text"],
        .profile-box input[type="email"],
        .profile-box input[type="password"] {
            width: 100%; padding: 8px; border-radius: 5px; border: none;
        }
        .update-btn {
            margin-top: 20px;
            background-color: #ba55d3;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 8px;
            cursor: pointer;
        }
        .checkbox-inline {
            font-weight: normal;
        }
    </style>
</head>
<body>
<div class="main">
    <form action="ProfileController" method="post">

        <div class="profile-box">
            <h2>PROFILE</h2>
            <p>Role : <%= currentUser.getRole() %></p>
            <p>Name : <input type="text" name="name" value="<%= currentUser.getName() %>" required></p>
            <p>Phone No : <input type="text" name="phone_no" value="<%= currentUser.getPhoneNo() != null ? currentUser.getPhoneNo() : "" %>" required></p>
            <p>Email : <input type="email" name="email" value="<%= currentUser.getEmail() %>" readonly></p>
            <p>Password : 
                <input type="password" id="pw" name="password" value="<%= currentUser.getPassword() %>" required>
                <label class="checkbox-inline">
                    <input type="checkbox" onclick="togglePassword()"> Show
                </label>
            </p>

            <% if ("staff".equals(role)) { %>
                <p>Staff Role : <input type="text" name="staff_role"></p>
                <p>Department : <input type="text" name="department"></p>
            <% } else if ("student".equals(role)) { %>
                <p>Matrix No : <input type="text" name="matrix_no"></p>
                <p>Program : <input type="text" name="program"></p>
                <p>Faculty : <input type="text" name="faculty"></p>
            <% } else if ("admin".equals(role)) { %>
                <p>Staff No : <input type="text" name="staff_no"></p>
            <% } else if ("organization".equals(role)) { %>
                <p>Advisor Name : <input type="text" name="advisor_name"></p>
            <% } %>

            <input class="update-btn" type="submit" value="UPDATE">
        </div>
    </form>
</div>
<script>
    function togglePassword() {
        var pw = document.getElementById("pw");
        pw.type = pw.type === "password" ? "text" : "password";
    }
</script>
</body>
</html>
