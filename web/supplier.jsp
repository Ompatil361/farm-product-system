<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>

<%
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
    int supplierId = Integer.parseInt(request.getParameter("supplier_id"));
    String supplierName = request.getParameter("supplier_name");
    String supplierNo = request.getParameter("supplier_no");
    int customerId = Integer.parseInt(request.getParameter("customer_id"));
    String customerName = request.getParameter("customer_name");
    String contactNo = request.getParameter("contact_no");
    int productId = Integer.parseInt(request.getParameter("product_id"));
    String productName = request.getParameter("product_name");
    int quantity = Integer.parseInt(request.getParameter("quantity"));
    double totalAmount = Double.parseDouble(request.getParameter("total_amount"));
    String paymentStatus = request.getParameter("payment_status");

    try {
        // Step 1: Check if the customer exists
        String checkCustomerSQL = "SELECT customer_id FROM customer_details WHERE customer_id=?";
        pstmt = conn.prepareStatement(checkCustomerSQL);
        pstmt.setInt(1, customerId);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            // Step 2: Insert supplier details if customer exists
            String insertSupplierSQL = "INSERT INTO supplier_details (supplier_id, supplier_name, supplier_no, customer_id, customer_name, contact_no, product_id, product_name, quantity, total_amount, payment_status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(insertSupplierSQL);
            pstmt.setInt(1, supplierId);
            pstmt.setString(2, supplierName);
            pstmt.setString(3, supplierNo);
            pstmt.setInt(4, customerId);
            pstmt.setString(5, customerName);
            pstmt.setString(6, contactNo);
            pstmt.setInt(7, productId);
            pstmt.setString(8, productName);
            pstmt.setInt(9, quantity);
            pstmt.setDouble(10, totalAmount);
            pstmt.setString(11, paymentStatus);
            pstmt.executeUpdate();

            message = "Supplier added successfully!";
        } else {
            message = "Error: Customer not found!";
        }
    } catch (SQLException e) {
        message = "Error: " + e.getMessage();
    }
}

if ("delete".equals(action)) {
    String idParam = request.getParameter("supplier_id");
    
    if (idParam != null && !idParam.isEmpty()) {
        try {
            int id = Integer.parseInt(idParam);
            
            String sql = "DELETE FROM supplier_details WHERE supplier_id=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            int rowsAffected = pstmt.executeUpdate();
            
            if (rowsAffected > 0) {
                message = "Supplier details deleted successfully!";
                
            } else {
                message = "Error: Supplier not found!";
            }
        } catch (NumberFormatException e) {
            message = "Error: Invalid Supplier ID format!";
        }
    }
}




   
        if ("update".equals(action)) {
    int supplierId = Integer.parseInt(request.getParameter("supplier_id"));
    String supplierName = request.getParameter("supplier_name");
    String supplierNo = request.getParameter("supplier_no");
    int customerId = Integer.parseInt(request.getParameter("customer_id"));
    String customerName = request.getParameter("customer_name");
    String contactNo = request.getParameter("contact_no");
    int productId = Integer.parseInt(request.getParameter("product_id"));
    String productName = request.getParameter("product_name");
    int quantity = Integer.parseInt(request.getParameter("quantity"));
    double totalAmount = Double.parseDouble(request.getParameter("total_amount"));
    String paymentStatus = request.getParameter("payment_status");

    String sql = "UPDATE supplier_details SET supplier_name=?, supplier_no=?, customer_id=?, customer_name=?, contact_no=?, product_id=?, product_name=?, quantity=?, total_amount=?, payment_status=? WHERE supplier_id=?";
    pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, supplierName);
    pstmt.setString(2, supplierNo);
    pstmt.setInt(3, customerId);
    pstmt.setString(4, customerName);
    pstmt.setString(5, contactNo);
    pstmt.setInt(6, productId);
    pstmt.setString(7, productName);
    pstmt.setInt(8, quantity);
    pstmt.setDouble(9, totalAmount);
    pstmt.setString(10, paymentStatus);
    pstmt.setInt(11, supplierId);
    pstmt.executeUpdate();
    
    message = "Supplier details updated successfully!";
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
    <title>Supplier Management</title>
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
</head
<body>
    <div class="container">
        <a href="home.jsp" class="back-button">Back</a>
        <h2>Supplier Management</h2>
        <p class="message"><%= message %></p>

        <form method="post" action="supplier.jsp">
            <input type="hidden" name="action" value="add">
            <input type="number" name="supplier_id" placeholder="Supplier ID" required>
            <input type="text" name="supplier_name" placeholder="Supplier Name" required>
            <input type="text" name="supplier_no" placeholder="Supplier No" required>
            <input type="number" name="customer_id" placeholder="Customer ID" required>
            <input type="text" name="customer_name" placeholder="Customer Name" required>
            <input type="text" name="contact_no" placeholder="Contact No" required>
            <input type="number" name="product_id" placeholder="Product ID" required>
            <input type="text" name="product_name" placeholder="Product Name" required>
            <input type="number" name="quantity" placeholder="Quantity" required>
            <input type="number" step="0.01" name="total_amount" placeholder="Total Amount" required>
            <select name="payment_status" required>
                <option value="Pending">Pending</option>
                <option value="Completed">Completed</option>
                <option value="Failed">Failed</option>
            </select>
            <button type="submit">Add Supplier</button>
        </form>

        <table>
            <tr>
                <th>Supplier ID</th>
                <th>Supplier Name</th>
                <th>Supplier No</th>
                <th>Customer ID</th>
                <th>Customer Name</th>
                <th>Contact No</th>
                <th>Product ID</th>
                <th>Product Name</th>
                <th>Quantity</th>
                <th>Total Amount</th>
                <th>Payment Status</th>
                <th>Actions</th>
            </tr>
            <%
                try {
                    String sql = "SELECT * FROM supplier_details";
                    pstmt = conn.prepareStatement(sql);
                    rs = pstmt.executeQuery();
                    while (rs.next()) {
            %>
            <tr>
                <td><%= rs.getInt("supplier_id") %></td>
                <td><%= rs.getString("supplier_name") %></td>
                <td><%= rs.getString("supplier_no") %></td>
                <td><%= rs.getInt("customer_id") %></td>
                <td><%= rs.getString("customer_name") %></td>
                <td><%= rs.getString("contact_no") %></td>
                <td><%= rs.getInt("product_id") %></td>
                <td><%= rs.getString("product_name") %></td>
                <td><%= rs.getInt("quantity") %></td>
                <td><%= rs.getDouble("total_amount") %></td>
                <td><%= rs.getString("payment_status") %></td>
                <td>
                    <form method="post" style="display:inline;">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="supplier_id" value="<%= rs.getInt("supplier_id") %>">
                        <button type="submit">Delete</button>                   
                    </form>
                    <form method="post" style="display:inline;">
    <input type="hidden" name="action" value="update">
    <input type="hidden" name="supplier_id" value="<%= rs.getInt("supplier_id") %>">

    <input type="text" name="supplier_name" value="<%= rs.getString("supplier_name") %>" required>
    <input type="text" name="supplier_no" value="<%= rs.getString("supplier_no") %>" required>
    <input type="number" name="customer_id" value="<%= rs.getInt("customer_id") %>" required>
    <input type="text" name="customer_name" value="<%= rs.getString("customer_name") %>" required>
    <input type="text" name="contact_no" value="<%= rs.getString("contact_no") %>" required>
    <input type="number" name="product_id" value="<%= rs.getInt("product_id") %>" required>
    <input type="text" name="product_name" value="<%= rs.getString("product_name") %>" required>
    <input type="number" name="quantity" value="<%= rs.getInt("quantity") %>" required>
    <input type="number" step="0.01" name="total_amount" value="<%= rs.getDouble("total_amount") %>" required>
    <input type="text" name="payment_status" value="<%= rs.getString("payment_status") %>" required>

    <button type="submit">Update</button>
</form>

                </td>
            </tr>
            <% }
                } catch (Exception e) {
                    out.println("<tr><td colspan='12' style='color:red;'>Error: " + e.getMessage() + "</td></tr>");
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