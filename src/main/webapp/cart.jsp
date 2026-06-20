<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.rsdvibe.model.CartItem" %>
<%@ page import="com.rsdvibe.model.Coupon" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Cart - RSD VIBE</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

    <%@ include file="components/navbar.jsp" %>

    <div class="container" style="min-height: 60vh;">
        <h1 class="mt-4" style="font-size: 2rem;">Shopping Cart</h1>
        
        <% 
            List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
            double totalMrp = 0;
            double discountOnMrp = 0;
            double deliveryCharge = 50; // default
            
            if (cart != null && !cart.isEmpty()) {
                for (CartItem item : cart) {
                    double itemTotal = item.getPrice() * item.getQuantity();
                    double itemOriginalTotal = item.getOriginalPrice() * item.getQuantity();
                    totalMrp += itemOriginalTotal;
                    discountOnMrp += (itemOriginalTotal - itemTotal);
                }
                
                if (totalMrp - discountOnMrp > 999) {
                    deliveryCharge = 0; // Free delivery over 999
                }
                
                double subTotal = totalMrp - discountOnMrp;
                double finalTotal = subTotal + deliveryCharge;
        %>
        
        <div class="cart-layout">
            <div class="cart-items">
                <% for (CartItem item : cart) { %>
                <div class="cart-item-card">
                    <img src="<%= item.getImageUrl() %>" alt="<%= item.getProductName() %>" class="cart-item-img">
                    
                    <div class="cart-item-info">
                        <div class="cart-item-brand"><%= item.getBrand() != null ? item.getBrand() : "RSD VIBE" %></div>
                        <h3 class="cart-item-name"><%= item.getProductName() %></h3>
                        
                        <div class="cart-item-meta">
                            <% if(item.getSize() != null && !item.getSize().isEmpty()) { %> Size: <strong><%= item.getSize() %></strong> | <% } %>
                            <% if(item.getColor() != null && !item.getColor().isEmpty()) { %> Color: <strong><%= item.getColor() %></strong> <% } %>
                        </div>
                        
                        <div class="cart-item-price">
                            Rs. <%= item.getPrice() %>
                            <% if(item.getOriginalPrice() > item.getPrice()) { %>
                                <span class="product-original-price" style="font-size: 0.9rem; margin-left: 0.5rem;">Rs. <%= item.getOriginalPrice() %></span>
                            <% } %>
                        </div>
                        
                        <div style="display: flex; gap: 1rem; align-items: center;">
                            <div class="quantity-selector" style="transform: scale(0.85); transform-origin: left;">
                                <a href="updateCart?action=decrease&productId=<%= item.getProductId() %>" class="qty-btn" style="display: flex; align-items: center; justify-content: center; text-decoration: none; color: black;">-</a>
                                <input type="text" class="qty-input" value="<%= item.getQuantity() %>" readonly>
                                <a href="updateCart?action=increase&productId=<%= item.getProductId() %>" class="qty-btn" style="display: flex; align-items: center; justify-content: center; text-decoration: none; color: black;">+</a>
                            </div>
                        </div>
                    </div>
                    
                    <a href="removeCart?productId=<%= item.getProductId() %>" class="cart-item-remove" title="Remove Item">✕</a>
                </div>
                <% } %>
            </div>
            
            <div class="cart-summary">
                <h3 style="margin-bottom: 1.5rem; font-size: 1.2rem;">Price Details (<%= cart.size() %> Items)</h3>
                
                <div class="summary-row">
                    <span>Total MRP</span>
                    <span>Rs. <%= totalMrp %></span>
                </div>
                <div class="summary-row">
                    <span>Discount on MRP</span>
                    <span class="text-success">- Rs. <%= discountOnMrp %></span>
                </div>
                <div class="summary-row" id="couponDiscountRow" style="display: none;">
                    <span>Coupon Discount</span>
                    <span class="text-success" id="couponDiscountValue">- Rs. 0</span>
                </div>
                <div class="summary-row">
                    <span>Delivery Charge</span>
                    <% if(deliveryCharge == 0) { %>
                        <span class="text-success">FREE</span>
                    <% } else { %>
                        <span>Rs. <%= deliveryCharge %></span>
                    <% } %>
                </div>
                
                <div class="summary-total">
                    <span>Total Amount</span>
                    <span id="finalAmountValue" data-value="<%= finalTotal %>">Rs. <%= finalTotal %></span>
                </div>
                
                <div class="text-success" style="font-size: 0.9rem; font-weight: 600; margin-bottom: 1.5rem; margin-top: 0.5rem;" id="totalSavingsMsg">
                    You will save Rs. <%= discountOnMrp %> on this order
                </div>
                
                <hr style="border: 0; border-top: 1px solid var(--border-color); margin-bottom: 1.5rem;">
                
                <h4 style="font-size: 1rem; margin-bottom: 0.5rem;">Apply Coupon</h4>
                <div class="coupon-form" id="cartSubtotal" data-value="<%= subTotal %>">
                    <input type="text" id="couponCode" class="form-control" placeholder="Enter coupon code" style="padding: 0.5rem;">
                    <button type="button" id="applyCouponBtn" class="btn btn-outline">Apply</button>
                </div>
                
                <a href="checkout.jsp" class="btn btn-primary btn-block mt-3">Proceed to Checkout</a>
            </div>
        </div>
        
        <% } else { %>
            <div class="text-center" style="padding: 5rem 0;">
                <div style="font-size: 4rem; margin-bottom: 1rem;">🛒</div>
                <h2>Your cart is empty</h2>
                <p class="text-muted mb-4">There is nothing in your bag. Let's add some items.</p>
                <a href="products" class="btn btn-primary">Continue Shopping</a>
            </div>
        <% } %>
    </div>

    <%@ include file="components/footer.jsp" %>
</body>
</html>