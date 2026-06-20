package com.rsdvibe.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.rsdvibe.model.Product;
import com.rsdvibe.util.DBConnection;

public class WishlistDAO {

    public boolean addToWishlist(int userId, int productId) {
        boolean status = false;
        try {
            Connection con = DBConnection.getConnection();
            String query = "INSERT IGNORE INTO wishlist(user_id, product_id) VALUES(?, ?)";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, userId);
            ps.setInt(2, productId);
            int rows = ps.executeUpdate();
            if (rows > 0) status = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }

    public boolean removeFromWishlist(int userId, int productId) {
        boolean status = false;
        try {
            Connection con = DBConnection.getConnection();
            String query = "DELETE FROM wishlist WHERE user_id=? AND product_id=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, userId);
            ps.setInt(2, productId);
            int rows = ps.executeUpdate();
            if (rows > 0) status = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }

    public List<Product> getWishlistByUser(int userId) {
        List<Product> products = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            String query = "SELECT p.* FROM products p INNER JOIN wishlist w ON p.product_id = w.product_id WHERE w.user_id = ? ORDER BY w.added_at DESC";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product product = new Product();
                product.setProductId(rs.getInt("product_id"));
                product.setProductName(rs.getString("product_name"));
                product.setBrand(rs.getString("brand"));
                product.setPrice(rs.getDouble("price"));
                product.setCategory(rs.getString("category"));
                product.setImageUrl(rs.getString("image_url"));
                product.setDiscountPercentage(rs.getDouble("discount_percentage"));
                product.setRating(rs.getDouble("rating"));
                products.add(product);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return products;
    }

    public boolean isInWishlist(int userId, int productId) {
        boolean status = false;
        try {
            Connection con = DBConnection.getConnection();
            String query = "SELECT id FROM wishlist WHERE user_id=? AND product_id=?";
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
