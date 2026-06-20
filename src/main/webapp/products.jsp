<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.rsdvibe.model.Product" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Products - RSD VIBE</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

    <%@ include file="components/navbar.jsp" %>

    <div class="container">
        <!-- Page Header -->
        <div class="mt-4 mb-4 text-center">
            <h1 style="font-size: 2.5rem; margin-bottom: 0.5rem;">The Collection</h1>
            <p class="text-muted">Discover our curated selection of premium menswear.</p>
        </div>

        <div class="shop-layout">
            <!-- Sidebar Filters -->
            <aside class="filter-sidebar">
                <form action="filter" method="get" id="filterForm">
                    <div class="filter-widget">
                        <h3 class="filter-title">Categories</h3>
                        <div class="filter-content">
                            <% 
                                List<String> categories = (List<String>) request.getAttribute("categories");
                                String selCategory = (String) request.getAttribute("selectedCategory");
                                if(categories != null) {
                                    for(String cat : categories) { 
                                        boolean checked = cat.equals(selCategory);
                            %>
                                <div class="checkbox-group">
                                    <input type="radio" name="category" value="<%= cat %>" id="cat_<%= cat %>" <%= checked ? "checked" : "" %> onchange="this.form.submit()">
                                    <label for="cat_<%= cat %>"><%= cat %></label>
                                </div>
                            <%      }
                                } %>
                        </div>
                    </div>

                    <div class="filter-widget">
                        <h3 class="filter-title">Brands</h3>
                        <div class="filter-content">
                            <% 
                                List<String> brands = (List<String>) request.getAttribute("brands");
                                String selBrand = (String) request.getAttribute("selectedBrand");
                                if(brands != null) {
                                    for(String brand : brands) { 
                                        boolean checked = brand.equals(selBrand);
                            %>
                                <div class="checkbox-group">
                                    <input type="radio" name="brand" value="<%= brand %>" id="brand_<%= brand %>" <%= checked ? "checked" : "" %> onchange="this.form.submit()">
                                    <label for="brand_<%= brand %>"><%= brand %></label>
                                </div>
                            <%      }
                                } %>
                        </div>
                    </div>
                    
                    <div class="filter-widget">
                        <h3 class="filter-title">Price Range</h3>
                        <div style="display: flex; gap: 0.5rem; align-items: center;">
                            <input type="number" name="minPrice" placeholder="Min" class="form-control" style="padding: 0.5rem;" value="<%= request.getAttribute("selectedMinPrice") != null ? request.getAttribute("selectedMinPrice") : "" %>">
                            <span>-</span>
                            <input type="number" name="maxPrice" placeholder="Max" class="form-control" style="padding: 0.5rem;" value="<%= request.getAttribute("selectedMaxPrice") != null ? request.getAttribute("selectedMaxPrice") : "" %>">
                        </div>
                        <button type="submit" class="btn btn-outline btn-block btn-sm mt-2">Apply Price</button>
                    </div>

                    <div style="margin-top: 1rem;">
                        <a href="products" class="text-danger" style="font-size: 0.9rem; text-decoration: underline;">Clear All Filters</a>
                    </div>
                </form>
            </aside>

            <!-- Product Grid -->
            <main class="product-list-area">
                <% List<Product> products = (List<Product>) request.getAttribute("products"); %>
                
                <div class="toolbar">
                    <div class="results-count">
                        Showing <strong><%= products != null ? products.size() : 0 %></strong> results
                        <% if(request.getAttribute("keyword") != null) { %>
                            for "<%= request.getAttribute("keyword") %>"
                        <% } %>
                    </div>
                    <div class="sort-options">
                        <select name="sort" class="sort-select" form="filterForm" onchange="document.getElementById('filterForm').submit()">
                            <option value="">Sort by: Featured</option>
                            <option value="newest" <%= "newest".equals(request.getAttribute("selectedSort")) ? "selected" : "" %>>Newest Arrivals</option>
                            <option value="price_low" <%= "price_low".equals(request.getAttribute("selectedSort")) ? "selected" : "" %>>Price: Low to High</option>
                            <option value="price_high" <%= "price_high".equals(request.getAttribute("selectedSort")) ? "selected" : "" %>>Price: High to Low</option>
                            <option value="rating" <%= "rating".equals(request.getAttribute("selectedSort")) ? "selected" : "" %>>Highest Rated</option>
                        </select>
                    </div>
                </div>

                <div class="product-grid">
                    <% if(products != null && !products.isEmpty()) {
                        for(Product p : products) { %>
                        <div class="product-card">
                            <div class="product-image-wrap">
                                <img src="<%= p.getImageUrl() %>" alt="<%= p.getProductName() %>" class="product-image">
                                <% if(p.getImageUrl2() != null && !p.getImageUrl2().isEmpty()) { %>
                                    <img src="<%= p.getImageUrl2() %>" class="product-image-hover">
                                <% } %>
                                
                                <div class="product-badges">
                                    <% if(p.isNewArrival()) { %><span class="badge-new">New</span><% } %>
                                    <% if(p.getDiscountPercentage() > 0) { %><span class="badge-discount">-<%= p.getDiscountPercentage() %>%</span><% } %>
                                </div>
                                
                                <button class="wishlist-btn wishlist-toggle" data-id="<%= p.getProductId() %>">❤️</button>
                                
                                <div class="product-actions">
                                    <a href="productDetail?id=<%= p.getProductId() %>" class="btn btn-primary btn-block">View Details</a>
                                </div>
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
                    <%  }
                       } else { %>
                        <div style="grid-column: 1 / -1; text-align: center; padding: 4rem 2rem;">
                            <div style="font-size: 3rem; margin-bottom: 1rem;">🔍</div>
                            <h3>No products found</h3>
                            <p class="text-muted">Try adjusting your filters or search criteria.</p>
                            <a href="products" class="btn btn-primary mt-3">Clear Filters</a>
                        </div>
                    <% } %>
                </div>
            </main>
        </div>
    </div>

    <%@ include file="components/footer.jsp" %>
</body>
</html>