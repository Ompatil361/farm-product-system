<%@ page import="java.sql.*, java.text.SimpleDateFormat, java.util.Date" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Customer Invoice Bill</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background: url('home.jpg') no-repeat center center fixed;
            background-size: cover;
        }

        .invoice-container {
            max-width: 800px;
            margin: 50px auto;
            background: #ffffffdd;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #333;
        }

        .form-container {
            text-align: center;
            margin-bottom: 30px;
        }

        input[type="number"] {
            padding: 10px;
            width: 250px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
        }

        button {
            padding: 10px 20px;
            background-color: #28a745;
            color: white;
            font-size: 16px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-left: 10px;
        }

        button:hover {
            background-color: #218838;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 25px;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: center;
            font-size: 15px;
        }

        th {
            background-color: #f8f9fa;
        }

        .info {
            text-align: left;
            font-size: 16px;
            margin: 15px 0;
            padding-left: 10px;
        }

        .error {
            color: red;
            font-weight: bold;
            text-align: center;
        }

        .back-button {
            display: inline-block;
            position: absolute;
            top: 20px;
            right: 30px;
            background-color: #007bff;
            padding: 10px 20px;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-weight: bold;
        }

        .back-button:hover {
            background-color: #0056b3;
        }

        .print-button {
            display: block;
            margin: 30px auto 0;
            background-color: #17a2b8;
        }

        .print-button:hover {
            background-color: #117a8b;
        }

        @media (max-width: 768px) {
            .invoice-container {
                width: 90%;
                padding: 20px;
            }

            input[type="number"] {
                width: 100%;
                margin-bottom: 10px;
            }

            button {
                width: 100%;
                margin: 5px 0;
            }
        }
    </style>
</head>
<body>
    <a href="home.jsp" class="back-button">Back</a>

    <div class="invoice-container">
        <h2>Customer Invoice Bill</h2>

        <div class="form-container">
            <form method="GET">
                <input type="number" name="customer_id" placeholder="Enter Customer ID" required>
                <button type="submit">Fetch Invoice</button>
            </form>
        </div>

        <%
            String customerId = request.getParameter("customer_id");

            if (customerId != null && !customerId.isEmpty()) {
                Connection conn = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;
                String url = "jdbc:mysql://localhost:3306/mysql";
                String user = "root";
                String pass = "root123";

                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    conn = DriverManager.getConnection(url, user, pass);

                    String query = "SELECT * FROM customer_details WHERE customer_id = ?";
                    pstmt = conn.prepareStatement(query);
                    pstmt.setString(1, customerId);
                    rs = pstmt.executeQuery();

                    if (rs.next()) {
                        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
                        String currentDate = formatter.format(new Date());
        %>

        <div id="invoice-content">
            <div class="info">
                <p><strong>Customer ID:</strong> <%= rs.getString("customer_id") %></p>
                <p><strong>Customer Name:</strong> <%= rs.getString("customer_name") %></p>
                <p><strong>Contact No:</strong> <%= rs.getString("contact_no") %></p>
            </div>

            <table>
                <thead>
                    <tr>
                        <th>Product ID</th>
                        <th>Product Name</th>
                        <th>Quantity</th>
                        <th>Total Amount</th>
                        <th>Payment Status</th>
                        <th>Date</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><%= rs.getInt("product_id") %></td>
                        <td><%= rs.getString("product_name") %></td>
                        <td><%= rs.getInt("quantity") %></td>
                        <td><%= rs.getDouble("total_amount") %></td>
                        <td><%= rs.getString("payment_status") %></td>
                        <td><%= currentDate %></td>
                    </tr>
                </tbody>
            </table>
        </div>

        <button class="print-button" onclick="window.print()">Print Invoice</button>

        <%
                    } else {
                        out.println("<p class='error'>No customer invoice found for ID: " + customerId + "</p>");
                    }
                } catch (Exception e) {
                    out.println("<p class='error'>Error: " + e.getMessage() + "</p>");
                    e.printStackTrace();
                } finally {
                    try {
                        if (rs != null) rs.close();
                        if (pstmt != null) pstmt.close();
                        if (conn != null) conn.close();
                    } catch (Exception e) {
                        // Ignore
                    }
                }
            }
        %>
    </div>
</body>
</html>
