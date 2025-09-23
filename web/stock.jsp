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

    // Variables to store form input
    String productId = "";
    String name = "";
    String quantity = "";
    String cost = "";

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, pass);
        
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            productId = request.getParameter("product_id");
            name = request.getParameter("product_name");
            quantity = request.getParameter("quantity");
            cost = request.getParameter("cost");

            String sql = "INSERT INTO stock_details (product_id, product_name, quantity, cost) VALUES (?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, Integer.parseInt(productId));
            pstmt.setString(2, name);
            pstmt.setInt(3, Integer.parseInt(quantity));
            pstmt.setDouble(4, Double.parseDouble(cost));
            pstmt.executeUpdate();
            message = "Product added successfully!";
        }

        if ("delete".equals(action)) {
            String idParam = request.getParameter("id");
            if (idParam != null && !idParam.isEmpty()) {
                int id = Integer.parseInt(idParam);
                String sql = "DELETE FROM stock_details WHERE product_id=?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, id);
                pstmt.executeUpdate();
                message = "Product details deleted successfully!";
            }
        }
        if ("update".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            name = request.getParameter("product_name");
            quantity = request.getParameter("quantity");
            cost = request.getParameter("cost");

            String sql = "UPDATE stock_details SET product_name=?, quantity=?, cost=? WHERE product_id=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, name);
            pstmt.setInt(2, Integer.parseInt(quantity));
            pstmt.setDouble(3, Double.parseDouble(cost));
            pstmt.setInt(4, id);
            pstmt.executeUpdate();
            message = "Product details updated successfully!";
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
    <title>Stock Management</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: url('register.jpg') no-repeat center center fixed;
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
            width: 80%;
            margin: auto;
            position: relative;
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
        form {
            margin-bottom: 20px;
        }
        input, button {
            padding: 10px;
            margin: 5px;
            border-radius: 5px;
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
    </style>
</head>
<body>
    <div class="container">
        <a href="home.jsp" class="back-button">Back</a>
        
        <h2>Stock Management</h2>
        <p class="message"><%= message %></p>

        <form method="post">
            <input type="hidden" name="action" value="add">
            <input type="number" name="product_id" placeholder="Product ID" value="<%= productId %>" required>
            <input type="text" name="product_name" placeholder="Product Name" value="<%= name %>" required>
            <input type="number" name="quantity" placeholder="Quantity" value="<%= quantity %>" required>
            <input type="number" step="0.01" name="cost" placeholder="Cost" value="<%= cost %>" required>
            <button type="submit">Add Product</button>
        </form>

        <table>
            <tr>
                <th>ID</th>
                <th>Product Name</th>
                <th>Quantity</th>
                <th>Cost</th>
                <th>Actions</th>
            </tr>

            <%
                try {
                    String sql = "SELECT * FROM stock_details";
                    pstmt = conn.prepareStatement(sql);
                    rs = pstmt.executeQuery();
                    while (rs.next()) {
            %>
            <tr>
                <td><%= rs.getInt("product_id") %></td>
                <td><%= rs.getString("product_name") %></td>
                <td><%= rs.getInt("quantity") %></td>
                <td><%= rs.getDouble("cost") %></td>
                <td>
                    <form method="post" style="display:inline;">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="id" value="<%= rs.getInt("product_id") %>">
                        <button type="submit">Delete</button>
                    </form>
                    
                    <form method="post" style="display:inline;">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="id" value="<%= rs.getInt("product_id") %>">
                        <input type="text" name="product_name" value="<%= rs.getString("product_name") %>" required>
                        <input type="number" name="quantity" value="<%= rs.getInt("quantity") %>" required>
                        <input type="number" step="0.01" name="cost" value="<%= rs.getDouble("cost") %>" required>
                        <button type="submit">Update</button>
                    </form>
                </td>
            </tr>
            <%
                    }
                } catch (Exception e) {
                    out.println("Error fetching products: " + e.getMessage());
                }
            %>
        </table>
    </div>
</body>
</html>

<%
    if (rs != null) rs.close();
    if (pstmt != null) pstmt.close();
    if (conn != null) conn.close();
%>