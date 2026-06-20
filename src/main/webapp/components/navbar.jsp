<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.rsdvibe.model.User" %>
<%@ page import="com.rsdvibe.model.CartItem" %>
<%@ page import="java.util.List" %>
<%
    User navUser = (User) session.getAttribute("user");
    List<CartItem> navCart = (List<CartItem>) session.getAttribute("cart");
    int cartCount = 0;
    if (navCart != null) {
        for (CartItem item : navCart) {
            cartCount += item.getQuantity();
        }
    }
%>
<nav class="navbar">
    <div class="container">
        <a href="home" class="nav-brand">RSD VIBE</a>
        
        <ul class="nav-menu">
            <li><a href="home" class="nav-link">Home</a></li>
            <li><a href="products" class="nav-link">Shop</a></li>
            <li><a href="filter?category=T-Shirts" class="nav-link">T-Shirts</a></li>
            <li><a href="filter?category=Jeans" class="nav-link">Jeans</a></li>
        </ul>
        
        <div class="nav-actions">
            <div class="search-container">
                <form id="searchForm" action="search" method="get">
                    <span class="search-icon">🔍</span>
                    <input type="text" id="searchInput" name="keyword" class="search-input" placeholder="Search products, brands..." autocomplete="off">
                </form>
                <div id="searchSuggestions" class="search-suggestions"></div>
            </div>
            
            <% if (navUser != null) { %>
                <a href="profile" class="nav-icon" title="Profile">👤</a>
                <a href="profile?tab=wishlist" class="nav-icon" title="Wishlist">❤️</a>
                <a href="cart.jsp" class="nav-icon" title="Cart">
                    🛒
                    <% if (cartCount > 0) { %>
                        <span class="badge"><%= cartCount %></span>
                    <% } %>
                </a>
            <% } else { %>
                <a href="login.jsp" class="btn btn-primary btn-sm">Login</a>
            <% } %>
        </div>
    </div>
</nav>
