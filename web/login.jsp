<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Sign In</title>
    <style>
      body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
        background-color: white;
      }
      .logo {
        margin-top: 30px; 
        margin-left: 20px;
        width: 120px;
      }
      .container {
        display: flex;
        justify-content: center;
        align-items: center;
        gap: 40px;
        margin-top: 30px;
      }
      .left-box, .right-box {
        width: 400px;
        height: 500px;
        padding: 30px;
        box-sizing: border-box;
      }
      .left-box {
        background-color: #c39bd3;
        border-radius: 10px;
        text-align: center;
      }
      .left-box h2 {
        font-size: 28px;
        color: #4a235a;
      }
      .left-box p {
        font-size: 14px;
        margin-bottom: 30px;
      }
      .left-box button {
        padding: 10px 30px;
        background-color: #6c3483;
        color: white;
        font-weight: bold;
        border: none;
        border-radius: 20px;
        cursor: pointer;
      }
      .right-box {
        background-color: #d7bde2;
        border: 2px solid #6c3483;
        border-radius: 10px;
      }
      .right-box h2 {
        text-align: center;
        margin-bottom: 20px;
        color: #4a235a;
        text-decoration: underline;
      }
      form {
        display: flex;
        flex-direction: column;
      }
      label {
        margin: 5px 0;
      }
      input[type="text"], input[type="email"], input[type="password"] {
        padding: 10px;
        border-radius: 8px;
        border: none;
        margin-bottom: 15px;
      }
      input[type="submit"] {
        padding: 10px;
        border-radius: 20px;
        background-color: #6c3483;
        color: white;
        font-weight: bold;
        border: none;
        cursor: pointer;
      }
      .role-selection {
        display: flex;
        justify-content: center;
        gap: 10px;
        margin-bottom: 15px;
      }
    </style>
</head>
<body>
  <img class="logo" src="images/Logo UiTM - Black.png" alt="UiTM Logo">
  <div class="container">
    <div class="right-box">
      <h2>Sign in</h2>

      <!-- Show error message if login fails -->
      <%
        String error = request.getParameter("error");
        if ("invalid".equals(error)) {
      %>
        <p style="color: red;">Invalid email or password.</p>
      <%
        }
      %>

        <form action="loginController" method="post">
            <input type="email" name="email" placeholder="Email" required>
            <input type="password" name="password" placeholder="Password" required>
            <input type="submit" value="SIGN IN">
        </form>

    </div>

    <div class="left-box">
      <h2>Hello !</h2>
      <p>No account yet?<br>Register now</p>
      <button onclick="window.location.href='signup.jsp'">SIGN UP</button>
    </div>
  </div>
</body>
</html>
