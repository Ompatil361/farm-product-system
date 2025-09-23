<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>

<%
    // Database Connection
    String url = "jdbc:mysql://localhost:3306/mysql";
    String user = "root";
    String pass = "root123";
    
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    String message = "";

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, pass);
        
        String action = request.getParameter("action");

        if ("update".equals(action)) {
            // Update User Details
            String username = request.getParameter("username");
            String email = request.getParameter("email_id");
            String contact = request.getParameter("contact_no");
            int age = Integer.parseInt(request.getParameter("age"));
            String gender = request.getParameter("gender");
            String date_of_birth = request.getParameter("date_of_birth");
            String password = request.getParameter("password");
            
            String sql = "UPDATE my_profile SET email_id=?, contact_no=?, age=?, gender=?, date_of_birth=?, password=? WHERE username=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, email);
            pstmt.setString(2, contact);
            pstmt.setInt(3, age);
            pstmt.setString(4, gender);
            pstmt.setString(5, date_of_birth);
            pstmt.setString(6, password);
            pstmt.setString(7, username);
            int rows = pstmt.executeUpdate();
            
            if (rows > 0) {
                message = "Profile updated successfully!";
            } else {
                message = "User not found!";
            }
        } else if ("insert".equals(action)) {
            // Insert New User
            String username = request.getParameter("username");
            String email = request.getParameter("email_id");
            String contact = request.getParameter("contact_no");
            int age = Integer.parseInt(request.getParameter("age"));
            String gender = request.getParameter("gender");
            String date_of_birth = request.getParameter("date_of_birth");
            String password = request.getParameter("password");

            String sql = "INSERT INTO create_acc (username, email_id, contact_no, age, gender, date_of_birth, password) VALUES (?, ?, ?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            pstmt.setString(2, email);
            pstmt.setString(3, contact);
            pstmt.setInt(4, age);
            pstmt.setString(5, gender);
            pstmt.setString(6, date_of_birth);
            pstmt.setString(7, password);
            int rows = pstmt.executeUpdate();

            if (rows > 0) {
                message = "Profile added successfully!";
            } else {
                message = "Error adding profile!";
            }
        } else if ("delete".equals(action)) {
            // Delete User
            String username = request.getParameter("username");
            String sql = "DELETE FROM my_profile WHERE username=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            int rows = pstmt.executeUpdate();

            if (rows > 0) {
                message = "Profile deleted successfully!";
            } else {
                message = "Error deleting profile!";
            }
        }
    } catch (Exception e) {
        message = "Error: " + e.getMessage();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: url('home.jpg') no-repeat center center fixed;
            background-size: cover;
            margin: 20px;
            padding: 10px;
            color: white;
            text-align: center;
        }
        .container {
            background: rgba(0, 0, 0, 0.7);
            padding: 20px;
            border-radius: 10px;
            width: 50%;
            margin: auto;
        }
        input, button, select {
            padding: 10px;
            margin: 5px;
            border-radius: 5px;
            width: 90%;
        }
        button {
            background-color: #28a745;
            color: white;
            border: none;
            cursor: pointer;
        }
        button:hover {
            background-color: #218838;
        }
        .message {
            color: yellow;
            font-weight: bold;
        }
        .back-button {
            position: absolute;
            top: 20px;
            right: 20px;
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }
        .back-button:hover {
            background-color: #0056b3;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background: rgba(255, 255, 255, 0.9);
            color: black;
        }
        table, th, td {
            border: 1px solid black;
        }
        th, td {
            padding: 12px;
            text-align: center;
        }
        .delete-btn {
            background-color: #dc3545;
            color: white;
            padding: 5px 10px;
            border: none;
            cursor: pointer;
            border-radius: 5px;
        }
        .delete-btn:hover {
            background-color: #c82333;
        }
    </style>
</head>
<body>
    <div class="container">
        <a href="home.jsp" class="back-button">Back</a>
        
        <h2>My Profile</h2>
        <p class="message"><%= message %></p>

        <form method="post" action="myprofile.jsp">
            <input type="hidden" name="action" value="insert">
            <input type="text" name="username" placeholder="Username" required>
            <input type="email" name="email_id" placeholder="Email ID" required>
            <input type="text" name="contact_no" placeholder="Contact No" required>
            <input type="number" name="age" placeholder="Age" required>
            <select name="gender" required>
                <option value="Male">Male</option>
                <option value="Female">Female</option>
                <option value="Other">Other</option>
            </select>
            <input type="date" name="date_of_birth" required>
            <input type="password" name="password" placeholder="Password" required>
            <button type="submit">Add Profile</button>
        </form>

        <h3>Existing Profiles</h3>
        <table>
            <tr>
                <th>Username</th>
                <th>Email ID</th>
                <th>Contact No</th>
                <th>Age</th>
                <th>Gender</th>
                <th>Date of Birth</th>
                <th>Password</th>
                <th>Action</th>
            </tr>
            <%
                try {
                    String sql = "SELECT * FROM my_profile";
                    pstmt = conn.prepareStatement(sql);
                    rs = pstmt.executeQuery();
                    while (rs.next()) {
            %>
            <tr>
                <td><%= rs.getString("username") %></td>
                <td><%= rs.getString("email_id") %></td>
                <td><%= rs.getString("contact_no") %></td>
                <td><%= rs.getInt("age") %></td>
                <td><%= rs.getString("gender") %></td>
                <td><%= rs.getString("date_of_birth") %></td>
                <td><%= rs.getString("password") %></td>
                <td>
                    <form method="post" action="myprofile.jsp">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="username" value="<%= rs.getString("username") %>">
                        <button type="submit" class="delete-btn">Delete</button>
                    </form>
                </td>
            </tr>
            <%
                    }
                } catch (Exception e) {
                    out.println("Error fetching profile details: " + e.getMessage());
                }
            %>
        </table>
    </div>
</body>  
</html>