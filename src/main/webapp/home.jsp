		<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
		<%@ page import="java.util.List" %>
		<%@ page import="com.rsdvibe.model.Product" %>
		<!DOCTYPE html>
		<html>
		<head>
		    <meta charset="UTF-8">
		    <meta name="viewport" content="width=device-width, initial-scale=1.0">
		    <title>RSD VIBE | Premium Men's Fashion</title>
		    <link rel="stylesheet" href="css/style.css">
		</head>
		<body>
		
		    <%@ include file="components/navbar.jsp" %>
		
		    <!-- Hero Section -->
		    <section class="hero">
		        <img src="https://images.unsplash.com/photo-1441984904996-e0b6ba687e04?w=1920&q=80" alt="Hero Background" class="hero-bg">
		        <div class="container hero-content">
		            <h1 class="hero-title">Redefine Your Style</h1>
		            <p class="hero-subtitle">Discover the latest trends in men's fashion. Premium quality, unmatched comfort.</p>
		            <a href="products" class="btn btn-primary">Shop Collection</a>
		        </div>
		    </section>
		
		    <div class="container">
		        <!-- Category Strip -->
		        <div class="category-strip mt-4">
		            <a href="filter?category=T-Shirts" class="category-item">
		                <div class="category-img-wrap">
		                    <img src="https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=400&q=80" alt="T-Shirts" class="category-img">
		                </div>
		                <span class="category-name">T-Shirts</span>
		            </a>
		            <a href="filter?category=Shirts" class="category-item">
		                <div class="category-img-wrap">
		                    <img src="https://images.unsplash.com/photo-1596755094514-f87e32f85e23?w=400&q=80" alt="Shirts" class="category-img">
		                </div>
		                <span class="category-name">Shirts</span>
		            </a>
		            <a href="filter?category=Jeans" class="category-item">
		                <div class="category-img-wrap">
		                    <img src="https://images.unsplash.com/photo-1542272604-787c3835535d?w=400&q=80" alt="Jeans" class="category-img">
		                </div>
		                <span class="category-name">Jeans</span>
		            </a>
		            <a href="filter?category=Jackets" class="category-item">
		                <div class="category-img-wrap">
		                    <img src="https://images.unsplash.com/photo-1551028719-00167b16eac5?w=400&q=80" alt="Jackets" class="category-img">
		                </div>
		                <span class="category-name">Jackets</span>
		            </a>
		            <a href="filter?category=Shoes" class="category-item">
		                <div class="category-img-wrap">
		                    <img src="https://images.unsplash.com/photo-1549298916-b41d501d3772?w=400&q=80" alt="Shoes" class="category-img">
		                </div>
		                <span class="category-name">Shoes</span>
		            </a>
		            <a href="filter?category=Accessories" class="category-item">
		                <div class="category-img-wrap">
		                    <img src="https://images.unsplash.com/photo-1524805444758-089113d48a6d?w=400&q=80" alt="Accessories" class="category-img">
		                </div>
		                <span class="category-name">Accessories</span>
		            </a>
		        </div>
		
		        <!-- Trending Products -->
		        <% 
		            List<Product> trending = (List<Product>) request.getAttribute("trendingProducts");
		            if(trending != null && !trending.isEmpty()) {
		        %>
		        <section class="mt-4 mb-4">
		            <h2 class="section-title">Trending Now</h2>
		            <div class="product-grid">
		                <% for(Product p : trending) { %>
		                    <div class="product-card">
		                        <div class="product-image-wrap">
		                            <img src="<%= p.getImageUrl() %>" alt="<%= p.getProductName() %>" class="product-image">
		                            <% if(p.getImageUrl2() != null && !p.getImageUrl2().isEmpty()) { %>
		                                <img src="<%= p.getImageUrl2() %>" class="product-image-hover">
		                            <% } %>
		                            
		                            <div class="product-badges">
		                                <% if(p.isTrending()) { %><span class="badge-new">Trending</span><% } %>
		                                <% if(p.getDiscountPercentage() > 0) { %><span class="badge-discount">-<%= p.getDiscountPercentage() %>%</span><% } %>
		                            </div>
		                            
		                            <button class="wishlist-btn wishlist-toggle" data-id="<%= p.getProductId() %>">❤️</button>
		                            
		                            <div class="product-actions">
		    								<a href="productDetail?id=<%= p.getProductId() %>" 
		       									class="btn btn-primary btn-block">
		       									View Details
		   									 </a>
									</div>
		                        <div class="product-info">
		                            <div class="product-brand"><%= p.getBrand() %></div>
		                            <h3 class="product-name"><a href="productDetail?id=<%= p.getProductId() %>"><%= p.getProductName() %></a></h3>
		                            <div class="product-rating">
		                                <span class="star-filled">★</span> <%= p.getRating() %> (<%= p.getReviewsCount() %>)
		                            </div>
		                            <div class="product-price-wrap">
		                                <span class="product-price">Rs. <%= p.getDiscountedPrice() %></span>
		                                <% if(p.getDiscountPercentage() > 0) { %>
		                                    <span class="product-original-price">Rs. <%= p.getOriginalPrice() %></span>
		                                <% } %>
		                            </div>
		                        </div>
		                    </div>
		                <% } %>
		            </div>
		        </section>
		        <% } %>
		
		        <!-- Promotional Banner -->
		        <section class="mt-4 mb-4" style="border-radius: var(--radius-md); overflow: hidden; position: relative;">
		            <img src="https://images.unsplash.com/photo-1523381210434-271e8be1f52b?w=1400&q=80" style="width: 100%; height: 400px; object-fit: cover;">
		            <div style="position: absolute; top: 50%; left: 10%; transform: translateY(-50%); color: white;">
		                <h2 style="font-size: 3rem; margin-bottom: 1rem;">Summer Sale</h2>
		                <p style="font-size: 1.2rem; margin-bottom: 2rem;">Up to 50% off on selected items</p>
		                <a href="products" class="btn btn-outline" style="border-color: white; color: white;">Shop Sale</a>
		            </div>
		        </section>
		
		        <!-- Best Sellers -->
		        <% 
		            List<Product> bestSellers = (List<Product>) request.getAttribute("bestSellers");
		            if(bestSellers != null && !bestSellers.isEmpty()) {
		        %>
		        <section class="mt-4 mb-4">
		            <h2 class="section-title">Best Sellers</h2>
		            <div class="product-grid">
		                <% for(Product p : Math.min(4, bestSellers.size()) > 0 ? bestSellers.subList(0, Math.min(4, bestSellers.size())) : bestSellers) { %>
		                    <div class="product-card">
		                        <div class="product-image-wrap">
		                            <img src="<%= p.getImageUrl() %>" alt="<%= p.getProductName() %>" class="product-image">
		                            
		                            <div class="product-badges">
		                                <span class="badge-new" style="background-color: var(--secondary-color);">Best Seller</span>
		                            </div>
		                            
		                            <div class="product-actions">
		                                <a href="productDetail?id=<%= p.getProductId() %>" class="btn btn-primary btn-block">View Details</a>
		                            </div>
		                        </div>
		                        <div class="product-info">
		                            <div class="product-brand"><%= p.getBrand() %></div>
		                            <h3 class="product-name"><a href="productDetail?id=<%= p.getProductId() %>"><%= p.getProductName() %></a></h3>
		                            <div class="product-price-wrap">
		                                <span class="product-price">Rs. <%= p.getDiscountedPrice() %></span>
		                            </div>
		                        </div>
		                    </div>
		                <% } %>
		            </div>
		            <div class="text-center mt-3">
		                <a href="products" class="btn btn-outline">View All Products</a>
		            </div>
		        </section>
		        <% } %>
		    </div>
		
		    <%@ include file="components/footer.jsp" %>
		</body>
		</html>