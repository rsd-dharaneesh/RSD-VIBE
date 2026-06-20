package com.rsdvibe.model;

import java.sql.Timestamp;

public class Review {
    private int reviewId;
    private int userId;
    private int productId;
    private double rating;
    private String reviewText;
    private String userName;
    private Timestamp createdAt;

    public Review() {}

    public int getReviewId() { return reviewId; }
    public void setReviewId(int reviewId) { this.reviewId = reviewId; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }

    public double getRating() { return rating; }
    public void setRating(double rating) { this.rating = rating; }

    public String getReviewText() { return reviewText; }
    public void setReviewText(String reviewText) { this.reviewText = reviewText; }

    public String getUserName() { return userName; }
    public void setUserName(String userName) { this.userName = userName; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}
