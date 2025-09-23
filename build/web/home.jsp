<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<%
    // Redirect to login if the user is not logged in
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home - Farm Product Marketing</title>
    
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    
    <!-- Custom CSS -->
    <style>
        body {
            font-family: Arial, sans-serif;
            background: url('home.jpg') no-repeat center center fixed;
            background-size: cover;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .container {
            margin-top: 50px;
        }
        .panel {
            text-align: center;
            padding: 20px;
            border-radius: 10px;
            transition: 0.3s;
            cursor: pointer;
        }
        .panel:hover {
            transform: scale(1.05);
        }
        .customer { background: #ff7043; color: white; }
        .stock { background: #42a5f5; color: white; }
        .supplier { background: #66bb6a; color: white; }
        .invoice { background: #ab47bc; color: white; }
        .profile { background: #ffa726; color: white; }
        .logout { background: #ef5350; color: white; }
    </style>
</head>
<body>

    <div class="container">
        <h2 class="text-center">Welcome, <%= session.getAttribute("username") %>!</h2>
        <div class="row mt-4">
            
            <div class="col-md-4 mb-3">
                <div class="panel customer" onclick="location.href='customer.jsp'">
                    <h4>Customer </h4>
                </div>
            </div>

            <div class="col-md-4 mb-3">
                <div class="panel stock" onclick="location.href='stock.jsp'">
                    <h4>Stock</h4>
                </div>
            </div>

            <div class="col-md-4 mb-3">
                <div class="panel supplier" onclick="location.href='supplier.jsp'">
                    <h4>Supplier</h4>
                </div>
            </div>

            <div class="col-md-4 mb-3">
                <div class="panel invoice" onclick="location.href='invoice.jsp'">
                    <h4>Invoice</h4>
                </div>
            </div>

            <div class="col-md-4 mb-3">
                <div class="panel profile" onclick="location.href='myprofile.jsp'">
                    <h4>My Profile</h4>
                </div>
            </div>

            <div class="col-md-4 mb-3">
                <div class="panel logout" onclick="location.href='logout.jsp'">
                    <h4>Logout</h4>
                </div>
            </div>

        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>