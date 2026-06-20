package com.rsdvibe.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.rsdvibe.model.Review;
import com.rsdvibe.util.DBConnection;

public class ReviewDAO {

    public boolean addReview(Review review) {
        boolean status = false;
        try {
            Connection con = DBConnection.getConnection();

            String query = "INSERT INTO product_reviews(user_id, product_id, rating, review_text) VALUES(?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(query);

            ps.setInt(1, review.getUserId());
            ps.setInt(2, review.getProductId());
            ps.setDouble(3, review.getRating());
            ps.setString(4, review.getReviewText());

            int rows = ps.executeUpdate();

            if (rows > 0) {
                updateProductRating(review.getProductId(), con);
                status = true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }

    private void updateProductRating(int productId, Connection con) throws Exception {

        String query = "SELECT AVG(rating) AS avg_rating, COUNT(*) AS rev_count "
                + "FROM product_reviews WHERE product_id=?";

        PreparedStatement ps = con.prepareStatement(query);
        ps.setInt(1, productId);

        ResultSet rs = ps.executeQuery();

        if (rs.next()) {

            double avg = rs.getDouble("avg_rating");
            int count = rs.getInt("rev_count");

            String updateQuery =
                    "UPDATE products SET rating=?, reviews_count=? WHERE product_id=?";

            PreparedStatement updatePs =
                    con.prepareStatement(updateQuery);

            updatePs.setDouble(1, avg);
            updatePs.setInt(2, count);
            updatePs.setInt(3, productId);

            updatePs.executeUpdate();
        }
    }

    public List<Review> getReviewsByProduct(int productId) {

        List<Review> reviews = new ArrayList<>();

        try {

            Connection con = DBConnection.getConnection();

            String query =
                    "SELECT r.*, u.full_name " +
                    "FROM product_reviews r " +
                    "JOIN users u ON r.user_id = u.user_id " +
                    "WHERE r.product_id=? " +
                    "ORDER BY r.created_at DESC";

            PreparedStatement ps = con.prepareStatement(query);

            ps.setInt(1, productId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Review r = new Review();

                r.setReviewId(rs.getInt("review_id"));
                r.setUserId(rs.getInt("user_id"));
                r.setProductId(rs.getInt("product_id"));
                r.setRating(rs.getDouble("rating"));
                r.setReviewText(rs.getString("review_text"));
                r.setUserName(rs.getString("full_name"));
                r.setCreatedAt(rs.getTimestamp("created_at"));

                reviews.add(r);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return reviews;
    }

    public boolean hasUserReviewed(int userId, int productId) {

        boolean status = false;

        try {

            Connection con = DBConnection.getConnection();

            String query =
                    "SELECT review_id FROM product_reviews " +
                    "WHERE user_id=? AND product_id=?";

            PreparedStatement ps = con.prepareStatement(query);

            ps.setInt(1, userId);
            ps.setInt(2, productId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                status = true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }
}