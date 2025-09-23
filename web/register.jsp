<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<%
    // Database credentials
    String url = "jdbc:mysql://localhost:3306/mysql";  // Change database name if needed
    String user = "root";  // Your MySQL username
    String pass = "root123"; // Your MySQL password

    // Form submission handling
    String message = "";
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String uname = request.getParameter("uname");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        Connection conn = null;
        PreparedStatement pst = null;

        try {
            // Load MySQL JDBC Driver
            Class.forName("com.mysql.jdbc.Driver");

            // Connect to database
            conn = DriverManager.getConnection(url, user, pass);

            // Insert Query
            String query = "INSERT INTO create_acc (uname, email, password) VALUES (?, ?, ?)";
            pst = conn.prepareStatement(query);
            pst.setString(1, uname);
            pst.setString(2, email);
            pst.setString(3, password);

            int row = pst.executeUpdate();
            if (row > 0) {
                message = "Account Created Successfully!";
            } else {
                message = "Registration Failed. Try Again!";
            }
        } catch (Exception e) {
            message = "Error: " + e.getMessage();
        } finally {
            try {
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
    <title>Register</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: url('register.jpg') no-repeat center center fixed;
            background-size: cover;
            display: flex;
            flex-direction: column;
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
        .container {
            background: rgba(255, 255, 255, 0.8);
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        h2 {
            margin-bottom: 20px;
        }
        input[type="text"],
        input[type="email"],
        input[type="password"] {
            width: 100%;
            padding: 10px;
            margin: 5px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        input[type="submit"] {
            background: #28a745;
            color: white;
            border: none;
            padding: 10px;
            cursor: pointer;
            width: 100%;
            border-radius: 5px;
        }
        input[type="submit"]:hover {
            background: #218838;
        }
        .message {
            color: red;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .show-password {
            margin: 10px 0;
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
    <div class="container">
        <h2>Create Account</h2>

        <% if (!message.isEmpty()) { %>
            <p class="message"><%= message %></p>
        <% } %>

        <form action="register.jsp" method="post">
            <label>Username:</label>
            <input type="text" name="uname" required><br>
            
            <label>Email:</label>
            <input type="email" name="email" required><br>
            
            <label>Password:</label>
            <input type="password" name="password" id="password" required><br>
            <input type="checkbox" class="show-password" onclick="togglePassword()"> Show Password
            
            <input type="submit" value="Register">
        </form>
        <p>Already have an account? <a href="login.jsp">Click here to login</a></p>
    </div>
</body>
</html>