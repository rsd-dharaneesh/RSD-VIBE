<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Placed - RSD VIBE</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

    <%@ include file="components/navbar.jsp" %>

    <div class="container text-center" style="padding: 5rem 0; min-height: 60vh;">
        <div style="font-size: 5rem; color: var(--success); margin-bottom: 1rem;">✓</div>
        <h1 style="font-size: 2.5rem; margin-bottom: 1rem;">Order Placed Successfully!</h1>
        <p class="text-muted" style="font-size: 1.1rem; margin-bottom: 2rem;">
            Thank you for your purchase. Your order ID is <strong>#<%= request.getAttribute("orderId") != null ? request.getAttribute("orderId") : "UNKNOWN" %></strong>.
            <br>We'll send you an email confirmation shortly.
        </p>
        
        <div style="display: flex; gap: 1rem; justify-content: center;">
            <a href="profile?tab=orders" class="btn btn-primary">Track Order</a>
            <a href="products" class="btn btn-outline">Continue Shopping</a>
        </div>
    </div>

    <%@ include file="components/footer.jsp" %>
</body>
</html>