<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.rsdvibe.model.User" %>
<%@ page import="com.rsdvibe.model.Order" %>
<%@ page import="com.rsdvibe.model.OrderItem" %>
<%@ page import="com.rsdvibe.model.Address" %>
<%@ page import="com.rsdvibe.model.Product" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile - RSD VIBE</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        .tab-content { display: none; }
        .tab-content.active { display: block; }
    </style>
</head>
<body>

    <%@ include file="components/navbar.jsp" %>

    <div class="container">
        <% 
            User profileUser = (User) request.getAttribute("user"); 
            String currentTab = request.getParameter("tab");
            if(currentTab == null) currentTab = "profile";
        %>
        
        <div class="account-layout">
            <aside class="account-sidebar">
                <div class="account-user">
                    <% if(profileUser.getProfilePhoto() != null && !profileUser.getProfilePhoto().isEmpty()) { %>
                        <img src="<%= profileUser.getProfilePhoto() %>" class="avatar">
                    <% } else { %>
                        <div class="avatar"><%= profileUser.getFullName().substring(0,1).toUpperCase() %></div>
                    <% } %>
                    <h3 style="margin-bottom: 0.2rem;"><%= profileUser.getFullName() %></h3>
                    <p class="text-muted" style="font-size: 0.9rem;"><%= profileUser.getEmail() %></p>
                </div>
                <ul class="account-menu">
                    <li><a href="?tab=orders" class="<%= "orders".equals(currentTab) ? "active" : "" %>">Orders</a></li>
                    <li><a href="?tab=wishlist" class="<%= "wishlist".equals(currentTab) ? "active" : "" %>">Wishlist</a></li>
                    <li><a href="?tab=addresses" class="<%= "addresses".equals(currentTab) ? "active" : "" %>">Addresses</a></li>
                    <li><a href="?tab=profile" class="<%= "profile".equals(currentTab) ? "active" : "" %>">Profile Details</a></li>
                    <li><a href="logout" class="text-danger">Logout</a></li>
                </ul>
            </aside>
            
            <main class="account-content">
                
                <!-- PROFILE DETAILS TAB -->
                <div id="profile" class="tab-content <%= "profile".equals(currentTab) ? "active" : "" %>">
                    <h2 style="margin-bottom: 2rem;">Profile Details</h2>
                    <form action="updateProfile" method="post" style="max-width: 500px;">
                        <div class="form-group">
                            <label class="form-label">Full Name</label>
                            <input type="text" name="fullName" class="form-control" value="<%= profileUser.getFullName() %>">
                        </div>
                        <div class="form-group">
                            <label class="form-label">Email Address (Cannot be changed)</label>
                            <input type="email" class="form-control" value="<%= profileUser.getEmail() %>" disabled>
                            <input type="hidden" name="email" value="<%= profileUser.getEmail() %>">
                        </div>
                        <div class="form-group">
                            <label class="form-label">Phone Number</label>
                            <input type="text" name="phone" class="form-control" value="<%= profileUser.getPhone() != null ? profileUser.getPhone() : "" %>">
                        </div>
                        <button type="submit" class="btn btn-primary">Save Changes</button>
                    </form>
                </div>

                <!-- ORDERS TAB -->
                <div id="orders" class="tab-content <%= "orders".equals(currentTab) ? "active" : "" %>">
                    <h2 style="margin-bottom: 2rem;">My Orders</h2>
                    <% 
                        List<Order> orders = (List<Order>) request.getAttribute("orders");
                        if (orders != null && !orders.isEmpty()) {
                            for (Order order : orders) {
                    %>
                        <div class="order-card">
                            <div class="order-header">
                                <div>
                                    <div style="font-weight: 600; font-size: 1.1rem;">Order #<%= order.getOrderId() %></div>
                                    <div style="color: var(--text-muted); font-size: 0.9rem;"><%= order.getOrderDate() %></div>
                                </div>
                                <div class="status-badge status-<%= order.getStatus().toLowerCase() %>"><%= order.getStatus() %></div>
                            </div>
                            <div class="order-items">
                                <% if(order.getItems() != null) {
                                    for(OrderItem item : order.getItems()) { %>
                                    <div class="order-item-row">
                                        <img src="<%= item.getImageUrl() %>" class="order-item-img">
                                        <div style="flex-grow: 1;">
                                            <div style="font-weight: 500; margin-bottom: 0.25rem;"><%= item.getProductName() %></div>
                                            <div style="font-size: 0.85rem; color: var(--text-muted);">
                                                <% if(item.getSize() != null && !item.getSize().isEmpty()) { %> Size: <%= item.getSize() %> | <% } %>
                                                <% if(item.getColor() != null && !item.getColor().isEmpty()) { %> Color: <%= item.getColor() %> | <% } %>
                                                Qty: <%= item.getQuantity() %>
                                            </div>
                                        </div>
                                        <div style="font-weight: 600;">Rs. <%= item.getPrice() %></div>
                                    </div>
                                <%  }
                                   } %>
                            </div>
                            <div style="background: #fdfdfd; padding: 1rem 1.5rem; border-top: 1px solid var(--border-color); display: flex; justify-content: space-between; align-items: center;">
                                <div style="font-size: 0.9rem;">
                                    Total Amount: <span style="font-weight: 700; font-size: 1.1rem;">Rs. <%= order.getTotalAmount() %></span>
                                </div>
                                <% if("Delivered".equalsIgnoreCase(order.getStatus())) { %>
                                    <a href="#" class="btn btn-outline btn-sm">Write Review</a>
                                <% } %>
                            </div>
                        </div>
                    <%      }
                        } else { %>
                        <div class="text-center" style="padding: 3rem 0;">
                            <p class="text-muted">You haven't placed any orders yet.</p>
                            <a href="products" class="btn btn-primary mt-3">Start Shopping</a>
                        </div>
                    <% } %>
                </div>

                <!-- WISHLIST TAB -->
                <div id="wishlist" class="tab-content <%= "wishlist".equals(currentTab) ? "active" : "" %>">
                    <h2 style="margin-bottom: 2rem;">My Wishlist</h2>
                    <% 
                        List<Product> wishlist = (List<Product>) request.getAttribute("wishlist");
                        if (wishlist != null && !wishlist.isEmpty()) {
                    %>
                        <div class="product-grid" style="grid-template-columns: repeat(auto-fill, minmax(200px, 1fr)); gap: 1.5rem;">
                            <% for(Product w : wishlist) { %>
                                <div class="product-card">
                                    <div class="product-image-wrap">
                                        <img src="<%= w.getImageUrl() %>" class="product-image">
                                        <a href="wishlist?action=remove&productId=<%= w.getProductId() %>" class="wishlist-btn active" style="text-decoration: none;">✕</a>
                                        <div class="product-actions">
                                            <a href="productDetail?id=<%= w.getProductId() %>" class="btn btn-primary btn-block btn-sm">View Product</a>
                                        </div>
                                    </div>
                                    <div class="product-info" style="padding: 1rem 0.5rem;">
                                        <div class="product-brand"><%= w.getBrand() %></div>
                                        <h3 class="product-name" style="font-size: 0.9rem;"><%= w.getProductName() %></h3>
                                        <div class="product-price-wrap" style="font-size: 0.95rem;">
                                            <span class="product-price">Rs. <%= w.getDiscountedPrice() %></span>
                                        </div>
                                    </div>
                                </div>
                            <% } %>
                        </div>
                    <% } else { %>
                        <div class="text-center" style="padding: 3rem 0;">
                            <p class="text-muted">Your wishlist is empty.</p>
                            <a href="products" class="btn btn-primary mt-3">Discover Trends</a>
                        </div>
                    <% } %>
                </div>

                <!-- ADDRESSES TAB -->
                <div id="addresses" class="tab-content <%= "addresses".equals(currentTab) ? "active" : "" %>">
                    <h2 style="margin-bottom: 2rem;">Saved Addresses</h2>
                    
                    <% 
                        List<Address> addresses = (List<Address>) request.getAttribute("addresses");
                        if(addresses != null && !addresses.isEmpty()) {
                            for(Address addr : addresses) {
                    %>
                        <div style="border: 1px solid var(--border-color); padding: 1.5rem; border-radius: var(--radius-sm); margin-bottom: 1rem; position: relative;">
                            <% if(addr.isDefault()) { %>
                                <span class="badge-new" style="position: absolute; top: 1.5rem; right: 1.5rem; background: var(--success);">DEFAULT</span>
                            <% } %>
                            <h4 style="margin-bottom: 0.5rem;"><%= addr.getFullName() %></h4>
                            <p style="margin-bottom: 0.25rem;"><%= addr.getAddressLine() %></p>
                            <p style="margin-bottom: 0.25rem;"><%= addr.getCity() %>, <%= addr.getState() %> - <%= addr.getPincode() %></p>
                            <p style="margin-bottom: 1rem;">Phone: <%= addr.getPhone() %></p>
                            
                            <div style="display: flex; gap: 1rem;">
                                <% if(!addr.isDefault()) { %>
                                    <form action="address" method="post" style="display:inline;">
                                        <input type="hidden" name="action" value="setDefault">
                                        <input type="hidden" name="addressId" value="<%= addr.getAddressId() %>">
                                        <button type="submit" class="btn btn-outline btn-sm">Set as Default</button>
                                    </form>
                                <% } %>
                                <form action="address" method="post" style="display:inline;">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="addressId" value="<%= addr.getAddressId() %>">
                                    <button type="submit" class="text-danger" style="background:none; border:none; cursor:pointer; font-weight:600; padding: 0.5rem;">Remove</button>
                                </form>
                            </div>
                        </div>
                    <%      }
                        } %>

                    <div class="mt-4" style="background: #f9f9f9; padding: 1.5rem; border-radius: var(--radius-sm);">
                        <h4 style="margin-bottom: 1rem;">Add New Address</h4>
                        <form action="address" method="post">
                            <input type="hidden" name="action" value="add">
                            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem;">
                                <div class="form-group mb-2">
                                    <input type="text" name="fullName" class="form-control" placeholder="Full Name" required>
                                </div>
                                <div class="form-group mb-2">
                                    <input type="text" name="phone" class="form-control" placeholder="Phone Number" required>
                                </div>
                            </div>
                            <div class="form-group mb-2">
                                <textarea name="addressLine" class="form-control" placeholder="Address (House No, Building, Street, Area)" rows="2" required></textarea>
                            </div>
                            <div style="display: grid; grid-template-columns: 1fr 1fr 1fr; gap: 1rem;">
                                <div class="form-group mb-2">
                                    <input type="text" name="city" class="form-control" placeholder="City" required>
                                </div>
                                <div class="form-group mb-2">
                                    <input type="text" name="state" class="form-control" placeholder="State" required>
                                </div>
                                <div class="form-group mb-2">
                                    <input type="text" name="pincode" class="form-control" placeholder="Pincode" required>
                                </div>
                            </div>
                            <div class="checkbox-group mb-3 mt-2">
                                <input type="checkbox" name="isDefault" id="isDefault">
                                <label for="isDefault">Make this my default address</label>
                            </div>
                            <button type="submit" class="btn btn-primary btn-sm">Save Address</button>
                        </form>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <%@ include file="components/footer.jsp" %>
</body>
</html>