<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.rsdvibe.model.CartItem" %>
<%@ page import="com.rsdvibe.model.User" %>
<%@ page import="com.rsdvibe.model.Coupon" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout - RSD VIBE</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

    <%@ include file="components/navbar.jsp" %>

    <div class="container" style="min-height: 60vh;">
        <h1 class="mt-4" style="font-size: 2rem;">Checkout</h1>
        
        <% 
            User checkoutUser = (User) session.getAttribute("user");
            if (checkoutUser == null) {
                response.sendRedirect("login.jsp");
                return;
            }
            
            List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
            if (cart == null || cart.isEmpty()) {
                response.sendRedirect("products");
                return;
            }
            
            double totalMrp = 0;
            double discountOnMrp = 0;
            double deliveryCharge = 50; 
            
            for (CartItem item : cart) {
                double itemTotal = item.getPrice() * item.getQuantity();
                double itemOriginalTotal = item.getOriginalPrice() * item.getQuantity();
                totalMrp += itemOriginalTotal;
                discountOnMrp += (itemOriginalTotal - itemTotal);
            }
            
            if (totalMrp - discountOnMrp > 999) {
                deliveryCharge = 0; 
            }
            
            double subTotal = totalMrp - discountOnMrp;
            
            Coupon appliedCoupon = (Coupon) session.getAttribute("coupon");
            double couponDiscount = 0;
            String couponCode = "";
            if (appliedCoupon != null) {
                couponCode = appliedCoupon.getCode();
                if ("PERCENTAGE".equals(appliedCoupon.getDiscountType())) {
                    couponDiscount = subTotal * (appliedCoupon.getDiscountValue() / 100.0);
                    if (appliedCoupon.getMaxDiscount() > 0 && couponDiscount > appliedCoupon.getMaxDiscount()) {
                        couponDiscount = appliedCoupon.getMaxDiscount();
                    }
                } else {
                    couponDiscount = appliedCoupon.getDiscountValue();
                }
            }
            
            double finalTotal = subTotal - couponDiscount + deliveryCharge;
        %>

        <form action="placeOrder" method="post">
            <div class="cart-layout">
                <!-- Delivery Details -->
                <div class="cart-items">
                    <div style="background: var(--bg-white); padding: 2rem; border-radius: var(--radius-sm); box-shadow: var(--shadow-sm); margin-bottom: 2rem;">
                        <h2 style="font-size: 1.5rem; margin-bottom: 1.5rem; border-bottom: 1px solid var(--border-color); padding-bottom: 0.5rem;">Delivery Address</h2>
                        
                        <div class="form-group">
                            <label class="form-label">Full Name</label>
                            <input type="text" name="name" class="form-control" value="<%= checkoutUser.getFullName() %>" required>
                        </div>
                        <div class="form-group">
                            <label class="form-label">Phone Number</label>
                            <input type="text" name="phone" class="form-control" value="<%= checkoutUser.getPhone() != null ? checkoutUser.getPhone() : "" %>" required>
                        </div>
                        <div class="form-group">
                            <label class="form-label">Detailed Address</label>
                            <textarea name="address" class="form-control" required><%= checkoutUser.getAddress() != null ? checkoutUser.getAddress() : "" %></textarea>
                        </div>
                    </div>
                    
                    <div style="background: var(--bg-white); padding: 2rem; border-radius: var(--radius-sm); box-shadow: var(--shadow-sm);">
                        <h2 style="font-size: 1.5rem; margin-bottom: 1.5rem; border-bottom: 1px solid var(--border-color); padding-bottom: 0.5rem;">Payment Method</h2>
                        
                        <div class="checkbox-group" style="margin-bottom: 1rem;">
                            <input type="radio" name="payment_method" value="COD" id="pay_cod" checked>
                            <label for="pay_cod" style="font-size: 1.1rem; font-weight: 500;">Cash on Delivery (COD)</label>
                        </div>
                        <div class="checkbox-group" style="margin-bottom: 1rem; opacity: 0.5;">
                            <input type="radio" name="payment_method" value="UPI" id="pay_upi" disabled>
                            <label for="pay_upi" style="font-size: 1.1rem; font-weight: 500;">UPI / Netbanking (Coming Soon)</label>
                        </div>
                        <div class="checkbox-group" style="opacity: 0.5;">
                            <input type="radio" name="payment_method" value="CARD" id="pay_card" disabled>
                            <label for="pay_card" style="font-size: 1.1rem; font-weight: 500;">Credit / Debit Card (Coming Soon)</label>
                        </div>
                    </div>
                </div>
                
                <!-- Order Summary -->
                <div class="cart-summary">
                    <h3 style="margin-bottom: 1.5rem; font-size: 1.2rem;">Order Summary</h3>
                    
                    <div class="order-items-preview" style="margin-bottom: 1.5rem;">
                        <% for (CartItem item : cart) { %>
                            <div style="display: flex; gap: 1rem; margin-bottom: 1rem;">
                                <img src="<%= item.getImageUrl() %>" style="width: 50px; height: 60px; object-fit: cover;">
                                <div>
                                    <div style="font-size: 0.9rem; font-weight: 500;"><%= item.getProductName() %></div>
                                    <div style="font-size: 0.8rem; color: var(--text-muted);">Qty: <%= item.getQuantity() %></div>
                                    <div style="font-size: 0.9rem;">Rs. <%= item.getPrice() %></div>
                                </div>
                            </div>
                        <% } %>
                    </div>
                    
                    <hr style="border: 0; border-top: 1px solid var(--border-color); margin-bottom: 1rem;">
                    
                    <div class="summary-row">
                        <span>Total MRP</span>
                        <span>Rs. <%= totalMrp %></span>
                    </div>
                    <div class="summary-row">
                        <span>Discount</span>
                        <span class="text-success">- Rs. <%= discountOnMrp %></span>
                    </div>
                    <% if(couponDiscount > 0) { %>
                    <div class="summary-row">
                        <span>Coupon (<%= couponCode %>)</span>
                        <span class="text-success">- Rs. <%= couponDiscount %></span>
                    </div>
                    <% } %>
                    <div class="summary-row">
                        <span>Delivery Charge</span>
                        <% if(deliveryCharge == 0) { %>
                            <span class="text-success">FREE</span>
                        <% } else { %>
                            <span>Rs. <%= deliveryCharge %></span>
                        <% } %>
                    </div>
                    
                    <div class="summary-total">
                        <span>Amount to Pay</span>
                        <span>Rs. <%= finalTotal %></span>
                    </div>
                    
                    <!-- Hidden inputs for placeOrder tracking -->
                    <input type="hidden" name="delivery_charge" value="<%= deliveryCharge %>">
                    <input type="hidden" name="discount_amount" value="<%= discountOnMrp + couponDiscount %>">
                    <input type="hidden" name="coupon_code" value="<%= couponCode %>">
                    
                    <button type="submit" class="btn btn-primary btn-block mt-4" style="height: 50px; font-size: 1.1rem;">Place Order</button>
                </div>
            </div>
        </form>
    </div>

    <%@ include file="components/footer.jsp" %>
</body>
</html>