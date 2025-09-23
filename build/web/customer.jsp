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

        if ("add".equals(action)) {
            int customerId = Integer.parseInt(request.getParameter("customer_id"));
            String customerName = request.getParameter("customer_name");
            String contactNo = request.getParameter("contact_no");
            int productId = Integer.parseInt(request.getParameter("product_id"));
            String productName = request.getParameter("product_name");
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            double totalAmount = Double.parseDouble(request.getParameter("total_amount"));
            String paymentStatus = request.getParameter("payment_status");

            try {
                // Step 1: Check product availability in stock
                String checkStockSQL = "SELECT quantity FROM stock_details WHERE product_id=?";
                pstmt = conn.prepareStatement(checkStockSQL);
                pstmt.setInt(1, productId);
                rs = pstmt.executeQuery();

                if (rs.next()) {
                    int availableQuantity = rs.getInt("quantity");

                    if (availableQuantity >= quantity) {
                        // Step 2: Insert customer details if stock is sufficient
                        String insertCustomerSQL = "INSERT INTO customer_details (customer_id, customer_name, contact_no, product_id, product_name, quantity, total_amount, payment_status) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
                        pstmt = conn.prepareStatement(insertCustomerSQL);
                        pstmt.setInt(1, customerId);
                        pstmt.setString(2, customerName);
                        pstmt.setString(3, contactNo);
                        pstmt.setInt(4, productId);
                        pstmt.setString(5, productName);
                        pstmt.setInt(6, quantity);
                        pstmt.setDouble(7, totalAmount);
                        pstmt.setString(8, paymentStatus);
                        pstmt.executeUpdate();

                        // Step 3: Update stock quantity
                        String updateStockSQL = "UPDATE stock_details SET quantity = quantity - ? WHERE product_id = ?";
                        pstmt = conn.prepareStatement(updateStockSQL);
                        pstmt.setInt(1, quantity);
                        pstmt.setInt(2, productId);
                        pstmt.executeUpdate();

                        message = "Customer added successfully, and stock updated!";
                    } else {
                        message = "Error: Not enough stock available!";
                    }
                } else {
                    message = "Error: Product not found in stock!";
                }
            } catch (SQLException e) {
                message = "Error: " + e.getMessage();
            }
        }

        if ("delete".equals(action)) {
            String idParam = request.getParameter("customer_id"); // Ensure parameter matches the form
            if (idParam != null && !idParam.isEmpty()) {
                int id = Integer.parseInt(idParam);

                String sql = "DELETE FROM customer_details WHERE customer_id=?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, id);
                int rowsAffected = pstmt.executeUpdate();

                if (rowsAffected > 0) {
                    message = "Customer details deleted successfully!";
                } else {
                    message = "Error: Customer not found!";
                }
            }
        }

        if ("update".equals(action)) {
            int customerId = Integer.parseInt(request.getParameter("customer_id"));
            String customerName = request.getParameter("customer_name");
            String contactNo = request.getParameter("contact_no");
            int productId = Integer.parseInt(request.getParameter("product_id"));
            String productName = request.getParameter("product_name");
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            double totalAmount = Double.parseDouble(request.getParameter("total_amount"));
            String paymentStatus = request.getParameter("payment_status");

            String sql = "UPDATE customer_details SET customer_name=?, contact_no=?, product_id=?, product_name=?, quantity=?, total_amount=?, payment_status=? WHERE customer_id=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, customerName);
            pstmt.setString(2, contactNo);
            pstmt.setInt(3, productId);
            pstmt.setString(4, productName);
            pstmt.setInt(5, quantity);
            pstmt.setDouble(6, totalAmount);
            pstmt.setString(7, paymentStatus);
            pstmt.setInt(8, customerId);
            pstmt.executeUpdate();
            message = "Customer details updated successfully!";
        }

    } catch (Exception e) {
        message = "Error: " + e.getMessage();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Customer Management</title>
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
        input, button, select {
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
        <h2>Customer Management</h2>
        <p class="message"><%= message %></p>

        <form method="post">
            <input type="hidden" name="action" value="add" />
            <input type="number" name="customer_id" placeholder="Customer ID" required />
            <input type="text" name="customer_name" placeholder="Customer Name" required />
            <input type="text" name="contact_no" placeholder="Contact No" required />
            <input type="number" name="product_id" placeholder="Product ID" required />
            <input type="text" name="product_name" placeholder="Product Name" required />
            <input type="number" name="quantity" placeholder="Quantity" required />
            <input type="number" step="0.01" name="total_amount" placeholder="Total Amount" required />
            <select name="payment_status" required>
                <option value="Pending">Pending</option>
                <option value="Completed">Completed</option>
                <option value="Failed">Failed</option>
            </select>
            <button type="submit">Add Customer</button>
        </form>

        <table>
            <tr>
                <th>Customer ID</th>
                <th>Customer Name</th>
                <th>Contact No</th>
                <th>Product ID</th>
                <th>Product Name</th>
                <th>Quantity</th>
                <th>Total Amount</th>
                <th>Payment Status</th>
                <th>Action</th>
            </tr>

            <%
                try {
                    String sql = "SELECT * FROM customer_details";
                    pstmt = conn.prepareStatement(sql);
                    rs = pstmt.executeQuery();
                    while (rs.next()) {
            %>
            <tr>
                <td><%= rs.getInt("customer_id") %></td>
                <td><%= rs.getString("customer_name") %></td>
                <td><%= rs.getString("contact_no") %></td>
                <td><%= rs.getInt("product_id") %></td>
                <td><%= rs.getString("product_name") %></td>
                <td><%= rs.getInt("quantity") %></td>
                <td><%= rs.getDouble("total_amount") %></td>
                <td><%= rs.getString("payment_status") %></td>
                <td>
                    <!-- Delete Customer Form -->
                    <form method="post" style="display:inline;">
                        <input type="hidden" name="action" value="delete" />
                        <input type="hidden" name="customer_id" value="<%= rs.getInt("customer_id") %>" />
                        <button type="submit">Delete</button>
                    </form>

                    <!-- Update Customer Form -->
                    <form method="post" style="display:inline;">
                        <input type="hidden" name="action" value="update" />
                        <input type="hidden" name="customer_id" value="<%= rs.getInt("customer_id") %>" />

                        <input type="text" name="customer_name" value="<%= rs.getString("customer_name") %>" required placeholder="Customer Name" />
                        <input type="text" name="contact_no" value="<%= rs.getString("contact_no") %>" required placeholder="Contact No" />

                        <input type="hidden" name="product_id" value="<%= rs.getInt("product_id") %>" />
                        <input type="text" name="product_name" value="<%= rs.getString("product_name") %>" required placeholder="Product Name" />

                        <input type="number" name="quantity" value="<%= rs.getInt("quantity") %>" required placeholder="Quantity" />
                        <input type="number" step="0.01" name="total_amount" value="<%= rs.getDouble("total_amount") %>" required placeholder="Total Amount" />

                        <select name="payment_status" required>
                            <option value="Pending" <%= rs.getString("payment_status").equals("Pending") ? "selected" : "" %>>Pending</option>
                            <option value="Completed" <%= rs.getString("payment_status").equals("Completed") ? "selected" : "" %>>Completed</option>
                            <option value="Failed" <%= rs.getString("payment_status").equals("Failed") ? "selected" : "" %>>Failed</option>
                        </select>

                        <button type="submit">Update</button>
                    </form>
                </td>
            </tr>
            <%
                    }
                } catch (Exception e) {
                    out.println("Error fetching customers: " + e.getMessage());
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