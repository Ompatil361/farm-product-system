<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<%
    // Database connection details
    String url = "jdbc:mysql://localhost:3306/mysql";  // Update your database name if needed
    String user = "root";  // MySQL username
    String pass = "root123"; // MySQL password

    String message = "";

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String uname = request.getParameter("uname");
        String password = request.getParameter("password");

        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;

        try {
            // Load MySQL JDBC Driver
            Class.forName("com.mysql.jdbc.Driver");

            // Connect to MySQL database
            conn = DriverManager.getConnection(url, user, pass);

            // Check if username and password exist in database
            String query = "SELECT * FROM create_acc WHERE uname = ? AND password = ?";
            pst = conn.prepareStatement(query);
            pst.setString(1, uname);
            pst.setString(2, password);

            rs = pst.executeQuery();

            if (rs.next()) {
                // Successful login: Store user session
                session.setAttribute("username", uname);
                response.sendRedirect("home.jsp"); // Redirect to home page after login
            } else {
                message = "Invalid username or password!";
            }
        } catch (Exception e) {
            message = "Error: " + e.getMessage();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pst != null) pst.close();
                if (conn != null) conn.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <style>
        body {
            background-image: url('register.jpg'); /* Update with your image path */
            background-size: cover;
            background-position: center;
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .title {
            font-size: 40px;
            font-weight: bold;
            color: rgb(81, 31, 31);
            margin-bottom: 20px;
            text-shadow: 6px 6px 15px rgba(35, 186, 65, 0.7);
            position: absolute;
            top: 20px;
            left: 50%;
            transform: translateX(-50%);
        }
        .login-container {
            background: rgba(255, 255, 255, 0.8);
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px 0px rgba(0, 0, 0, 0.1);
            text-align: center;
            width: 300px;
        }
        h2 {
            margin-bottom: 20px;
        }
        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        input[type="submit"] {
            background: #28a745;
            color: white;
            padding: 10px;
            border: none;
            width: 100%;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }
        input[type="submit"]:hover {
            background: #218838;
        }
        .error-message {
            color: red;
            margin-bottom: 15px;
        }
        a {
            color: #007bff;
            text-decoration: none;
        }
        a:hover {
            text-decoration: underline;
        }
    </style>
    <script>
        function togglePassword() {
            var passwordField = document.getElementById("password");
            if (passwordField.type === "password") {
                passwordField.type = "text";
            } else {
                passwordField.type = "password";
            }
        }
    </script>
</head>
<body>
    <div class="title">FARM PRODUCT SYSTEM</div>
    <div class="login-container">
        <h2>Login</h2>
        <% if (!message.isEmpty()) { %>
            <p class="error-message"><%= message %></p>
        <% } %>
        <form action="login.jsp" method="post">
            <label>Username:</label>
            <input type="text" name="uname" required><br>
            
            <label>Password:</label>
            <input type="password" name="password" id="password" required><br>
            <input type="checkbox" onclick="togglePassword()"> Show Password
            
            <input type="submit" value="Login">
        </form>
        <p>Don't have an account? <a href="register.jsp">Register here</a></p>
    </div>
</body>
</html>