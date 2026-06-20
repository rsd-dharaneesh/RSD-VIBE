<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.rsdvibe.model.Product" %>
<%@ page import="com.rsdvibe.model.Review" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Details - RSD VIBE</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

    <%@ include file="components/navbar.jsp" %>

    <% Product p = (Product) request.getAttribute("product"); 
       if(p != null) { 
    %>
    <div class="container">
        <!-- Breadcrumbs -->
        <div style="margin: 2rem 0; font-size: 0.9rem;">
            <a href="home" class="text-muted">Home</a> / 
            <a href="filter?category=<%= p.getCategory() %>" class="text-muted"><%= p.getCategory() %></a> / 
            <span style="font-weight: 500;"><%= p.getProductName() %></span>
        </div>

        <div class="product-detail-layout">
            <!-- Gallery -->
            <div class="product-gallery">
                <div class="thumbnail-strip">
                    <img src="<%= p.getImageUrl() %>" class="thumbnail active">
                    <% if(p.getImageUrl2() != null && !p.getImageUrl2().isEmpty()) { %>
                        <img src="<%= p.getImageUrl2() %>" class="thumbnail">
                    <% } %>
                    <% if(p.getImageUrl3() != null && !p.getImageUrl3().isEmpty()) { %>
                        <img src="<%= p.getImageUrl3() %>" class="thumbnail">
                    <% } %>
                    <% if(p.getImageUrl4() != null && !p.getImageUrl4().isEmpty()) { %>
                        <img src="<%= p.getImageUrl4() %>" class="thumbnail">
                    <% } %>
                </div>
                <div class="main-image-wrap">
                    <img src="<%= p.getImageUrl() %>" class="main-image">
                </div>
            </div>

            <!-- Info -->
            <div class="product-info-wrap">
                <div class="pd-brand"><%= p.getBrand() %></div>
                <h1 class="pd-title"><%= p.getProductName() %></h1>
                
                <div style="display: flex; gap: 1rem; margin-bottom: 1.5rem; align-items: center;">
                    <div class="product-rating" style="font-size: 1rem;">
                        <span class="star-filled">★</span> <%= p.getRating() %> (<%= p.getReviewsCount() %> reviews)
                    </div>
                    <% if(p.getStock() > 0) { %>
                        <span class="text-success" style="font-size: 0.9rem; font-weight: 600;">In Stock (<%= p.getStock() %>)</span>
                    <% } else { %>
                        <span class="text-danger" style="font-size: 0.9rem; font-weight: 600;">Out of Stock</span>
                    <% } %>
                </div>

                <div class="pd-price-wrap">
                    <span class="pd-price">Rs. <%= p.getDiscountedPrice() %></span>
                    <% if(p.getDiscountPercentage() > 0) { %>
                        <span class="pd-original-price">Rs. <%= p.getOriginalPrice() %></span>
                        <span class="pd-discount"><%= p.getDiscountPercentage() %>% OFF</span>
                    <% } %>
                </div>

                <form action="cart" method="post" id="addToCartForm">
                    <input type="hidden" name="productId" value="<%= p.getProductId() %>">
                    <input type="hidden" name="size" id="selectedSize" value="">
                    <input type="hidden" name="color" id="selectedColor" value="">
                    
                    <% if(p.getSizes() != null && !p.getSizes().isEmpty()) { %>
                    <div class="selector-title">Select Size 
                        <a href="#" class="text-muted" style="font-weight: 400; font-size: 0.85rem; text-decoration: underline;">Size Guide</a>
                    </div>
                    <div class="size-selector">
                        <% for(String size : p.getSizes().split(",")) { %>
                            <div class="size-btn" data-size="<%= size %>"><%= size %></div>
                        <% } %>
                    </div>
                    <% } %>

                    <% if(p.getColors() != null && !p.getColors().isEmpty()) { %>
                    <div class="selector-title mt-3">Select Color</div>
                    <div class="color-selector">
                        <% for(String color : p.getColors().split(",")) { 
                           // Very basic color mapping for UI
                           String hex = color.toLowerCase();
                           if(hex.equals("white")) hex = "#ffffff";
                           else if(hex.equals("black")) hex = "#111111";
                           else if(hex.equals("red")) hex = "#e74c3c";
                           else if(hex.equals("blue") || hex.equals("dark blue")) hex = "#2980b9";
                           else if(hex.equals("green") || hex.equals("olive")) hex = "#27ae60";
                           else if(hex.equals("grey")) hex = "#95a5a6";
                           else hex = color; // fallback
                        %>
                            <div class="color-btn" style="background-color: <%= hex %>;" data-color="<%= color %>" title="<%= color %>"></div>
                        <% } %>
                    </div>
                    <% } %>

                    <div class="add-to-cart-wrap mt-4">
                        <div class="quantity-selector">
                            <button type="button" class="qty-btn qty-minus">-</button>
                            <input type="text" name="quantity" class="qty-input" value="1" readonly>
                            <button type="button" class="qty-btn qty-plus">+</button>
                        </div>
                        <button type="submit" class="btn btn-primary btn-add-cart" <%= p.getStock() <= 0 ? "disabled" : "" %>>
                            <%= p.getStock() > 0 ? "Add to Cart" : "Sold Out" %>
                        </button>
                        <button type="button" class="btn-wishlist wishlist-toggle" data-id="<%= p.getProductId() %>">❤️</button>
                    </div>
                </form>

                <div class="mt-4" style="border-top: 1px solid var(--border-color); padding-top: 1.5rem;">
                    <h3 style="font-size: 1.2rem; margin-bottom: 1rem;">Product Details</h3>
                    <p class="text-muted" style="line-height: 1.8;"><%= p.getDescription() %></p>
                    <ul class="text-muted mt-3" style="list-style: disc; padding-left: 1.5rem; line-height: 1.8;">
                        <li>100% Original Products</li>
                        <li>Pay on delivery might be available</li>
                        <li>Easy 14 days returns and exchanges</li>
                    </ul>
                </div>
            </div>
        </div>

        <!-- Reviews Section -->
        <section class="mt-4 mb-4" style="border-top: 1px solid var(--border-color); padding-top: 3rem;">
            <h2 class="section-title">Customer Reviews</h2>
            
            <div style="display: flex; gap: 4rem;">
                <!-- Review Summary -->
                <div style="flex: 1; text-align: center;">
                    <div style="font-size: 4rem; font-weight: 700; color: var(--primary-color);"><%= p.getRating() %></div>
                    <div class="product-rating" style="font-size: 1.5rem; margin-bottom: 0.5rem;">
                        <span class="star-filled">★★★★☆</span>
                    </div>
                    <p class="text-muted">Based on <%= p.getReviewsCount() %> reviews</p>
                    
                    <% Boolean hasReviewed = (Boolean) request.getAttribute("hasReviewed");
                       if (navUser != null && (hasReviewed == null || !hasReviewed)) { %>
                        <div class="mt-4 text-left" style="background: #f9f9f9; padding: 1.5rem; border-radius: var(--radius-sm);">
                            <h4 style="margin-bottom: 1rem;">Write a Review</h4>
                            <form action="review" method="post">
                                <input type="hidden" name="productId" value="<%= p.getProductId() %>">
                                <div class="form-group mb-2">
                                    <label class="form-label">Rating</label>
                                    <select name="rating" class="form-control" style="padding: 0.5rem;" required>
                                        <option value="5">5 - Excellent</option>
                                        <option value="4">4 - Good</option>
                                        <option value="3">3 - Average</option>
                                        <option value="2">2 - Poor</option>
                                        <option value="1">1 - Terrible</option>
                                    </select>
                                </div>
                                <div class="form-group mb-2">
                                    <label class="form-label">Review</label>
                                    <textarea name="reviewText" class="form-control" rows="3" required></textarea>
                                </div>
                                <button type="submit" class="btn btn-primary btn-sm">Submit Review</button>
                            </form>
                        </div>
                    <% } else if (navUser == null) { %>
                        <p class="mt-3"><a href="login.jsp" class="text-primary" style="text-decoration: underline;">Login</a> to write a review</p>
                    <% } %>
                </div>

                <!-- Review List -->
                <div style="flex: 2;">
                    <% List<Review> reviews = (List<Review>) request.getAttribute("reviews"); 
                       if(reviews != null && !reviews.isEmpty()) {
                           for(Review r : reviews) {
                    %>
                        <div style="border-bottom: 1px solid var(--border-color); padding-bottom: 1.5rem; margin-bottom: 1.5rem;">
                            <div style="display: flex; justify-content: space-between; margin-bottom: 0.5rem;">
                                <strong><%= r.getUserName() %></strong>
                                <span class="text-muted" style="font-size: 0.85rem;"><%= r.getCreatedAt() != null ? r.getCreatedAt().toString().substring(0,10) : "" %></span>
                            </div>
                            <div class="product-rating" style="justify-content: flex-start; margin-bottom: 0.5rem;">
                                <span class="star-filled"><%= "★".repeat((int)r.getRating()) %><%= "☆".repeat(5-(int)r.getRating()) %></span>
                            </div>
                            <p class="text-muted"><%= r.getReviewText() %></p>
                        </div>
                    <%     }
                       } else { %>
                        <p class="text-muted">No reviews yet. Be the first to review this product!</p>
                    <% } %>
                </div>
            </div>
        </section>

        <!-- Similar Products -->
        <% List<Product> similar = (List<Product>) request.getAttribute("similarProducts"); 
           if(similar != null && !similar.isEmpty()) { %>
        <section class="mt-4 mb-4" style="border-top: 1px solid var(--border-color); padding-top: 3rem;">
            <h2 class="section-title">You Might Also Like</h2>
            <div class="product-grid">
                <% for(Product sp : similar) { %>
                    <div class="product-card">
                        <div class="product-image-wrap">
                            <img src="<%= sp.getImageUrl() %>" alt="<%= sp.getProductName() %>" class="product-image">
                            <button class="wishlist-btn wishlist-toggle" data-id="<%= sp.getProductId() %>">❤️</button>
                            <div class="product-actions">
                                <a href="productDetail?id=<%= sp.getProductId() %>" class="btn btn-primary btn-block">View Details</a>
                            </div>
                        </div>
                        <div class="product-info">
                            <div class="product-brand"><%= sp.getBrand() %></div>
                            <h3 class="product-name"><a href="productDetail?id=<%= sp.getProductId() %>"><%= sp.getProductName() %></a></h3>
                            <div class="product-price-wrap">
                                <span class="product-price">Rs. <%= sp.getDiscountedPrice() %></span>
                            </div>
                        </div>
                    </div>
                <% } %>
            </div>
        </section>
        <% } %>
    </div>
    <% } else { %>
        <div class="container text-center" style="padding: 5rem 0;">
            <h2>Product not found</h2>
            <a href="products" class="btn btn-primary mt-3">Back to Shop</a>
        </div>
    <% } %>

    <%@ include file="components/footer.jsp" %>
    
    <script>
        // Set selected size and color in hidden inputs before form submit
        document.getElementById('addToCartForm').addEventListener('submit', function(e) {
            const size = document.getElementById('selectedSize').value;
            const color = document.getElementById('selectedColor').value;
            
            const hasSizes = document.querySelectorAll('.size-btn').length > 0;
            const hasColors = document.querySelectorAll('.color-btn').length > 0;
            
            if(hasSizes && !size) {
                e.preventDefault();
                alert('Please select a size');
                return;
            }
            if(hasColors && !color) {
                e.preventDefault();
                alert('Please select a color');
                return;
            }
        });
    </script>
</body>
</html>
