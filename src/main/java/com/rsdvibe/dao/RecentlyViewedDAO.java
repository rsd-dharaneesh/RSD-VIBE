package com.rsdvibe.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.rsdvibe.model.Product;
import com.rsdvibe.util.DBConnection;

public class RecentlyViewedDAO {

    public void addRecentlyViewed(int userId, int productId) {
        try {
            Connection con = DBConnection.getConnection();
            String query = "INSERT INTO recently_viewed(user_id, product_id) VALUES(?, ?) ON DUPLICATE KEY UPDATE viewed_at = CURRENT_TIMESTAMP";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, userId);
            ps.setInt(2, productId);
            ps.executeUpdate();
            
            // Keep only latest 10
            String deleteQuery = "DELETE FROM recently_viewed WHERE user_id=? AND id NOT IN (SELECT id FROM (SELECT id FROM recently_viewed WHERE user_id=? ORDER BY viewed_at DESC LIMIT 10) as t)";
            PreparedStatement deletePs = con.prepareStatement(deleteQuery);
            deletePs.setInt(1, userId);
            deletePs.setInt(2, userId);
            deletePs.executeUpdate();
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Product> getRecentlyViewed(int userId, int limit) {
        List<Product> products = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            String query = "SELECT p.* FROM products p INNER JOIN recently_viewed rv ON p.product_id = rv.product_id WHERE rv.user_id = ? ORDER BY rv.viewed_at DESC LIMIT ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, userId);
            ps.setInt(2, limit);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product p = new Product();
                p.setProductId(rs.getInt("product_id"));
                p.setProductName(rs.getString("product_name"));
                p.setBrand(rs.getString("brand"));
                p.setPrice(rs.getDouble("price"));
                p.setCategory(rs.getString("category"));
                p.setImageUrl(rs.getString("image_url"));
                p.setDiscountPercentage(rs.getDouble("discount_percentage"));
                p.setRating(rs.getDouble("rating"));
                products.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return products;
    }
}
