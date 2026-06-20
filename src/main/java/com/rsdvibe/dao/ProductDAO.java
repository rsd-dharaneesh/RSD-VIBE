package com.rsdvibe.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.rsdvibe.model.Product;
import com.rsdvibe.util.DBConnection;

public class ProductDAO {

    public List<Product> getAllProducts() {
        return getProductsByQuery("SELECT * FROM products ORDER BY product_id DESC");
    }

    public Product getProductById(int productId) {
        Product product = null;
        try {
            Connection con = DBConnection.getConnection();
            String query = "SELECT * FROM products WHERE product_id=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                product = mapProduct(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return product;
    }

    public List<Product> searchProducts(String keyword) {
        return advancedSearch(keyword);
    }

    public List<Product> getProductsByCategory(String category) {
        String query = "SELECT * FROM products WHERE category=? ORDER BY product_id DESC";
        List<Product> products = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, category);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                products.add(mapProduct(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return products;
    }

    // New Premium Methods
    
    public List<Product> getNewArrivals() {
        return getProductsByQuery("SELECT * FROM products WHERE is_new_arrival = TRUE ORDER BY created_at DESC LIMIT 10");
    }

    public List<Product> getBestSellers() {
        return getProductsByQuery("SELECT * FROM products WHERE is_best_seller = TRUE ORDER BY rating DESC, reviews_count DESC LIMIT 10");
    }

    public List<Product> getTrendingProducts() {
        return getProductsByQuery("SELECT * FROM products WHERE is_trending = TRUE ORDER BY created_at DESC LIMIT 10");
    }

    public List<Product> getSimilarProducts(String category, int excludeProductId) {
        List<Product> products = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            String query = "SELECT * FROM products WHERE category=? AND product_id!=? ORDER BY RAND() LIMIT 4";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, category);
            ps.setInt(2, excludeProductId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                products.add(mapProduct(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return products;
    }

    public List<String> getSearchSuggestions(String keyword) {
        List<String> suggestions = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            String query = "SELECT product_name FROM products WHERE product_name LIKE ? LIMIT 5";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, "%" + keyword + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                suggestions.add(rs.getString("product_name"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return suggestions;
    }

    public List<Product> advancedSearch(String keyword) {
        List<Product> products = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            String query = "SELECT * FROM products WHERE product_name LIKE ? OR brand LIKE ? OR category LIKE ? OR colors LIKE ?";
            PreparedStatement ps = con.prepareStatement(query);
            String param = "%" + keyword + "%";
            ps.setString(1, param);
            ps.setString(2, param);
            ps.setString(3, param);
            ps.setString(4, param);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                products.add(mapProduct(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return products;
    }

    public List<String> getBrands() {
        return getDistinctStrings("SELECT DISTINCT brand FROM products WHERE brand IS NOT NULL AND brand != '' ORDER BY brand");
    }

    public List<String> getCategories() {
        return getDistinctStrings("SELECT DISTINCT category FROM products WHERE category IS NOT NULL AND category != '' ORDER BY category");
    }

    private List<String> getDistinctStrings(String query) {
        List<String> list = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(rs.getString(1));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Product> getProductsByFilters(String brand, String category, Double minPrice, Double maxPrice, String size, String color, String sort) {
        List<Product> products = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            StringBuilder query = new StringBuilder("SELECT * FROM products WHERE 1=1");
            
            if (brand != null && !brand.isEmpty()) {
                query.append(" AND brand='").append(brand.replace("'", "''")).append("'");
            }
            if (category != null && !category.isEmpty()) {
                query.append(" AND category='").append(category.replace("'", "''")).append("'");
            }
            if (minPrice != null) {
                query.append(" AND price>=").append(minPrice);
            }
            if (maxPrice != null) {
                query.append(" AND price<=").append(maxPrice);
            }
            if (size != null && !size.isEmpty()) {
                query.append(" AND sizes LIKE '%").append(size).append("%'");
            }
            if (color != null && !color.isEmpty()) {
                query.append(" AND colors LIKE '%").append(color).append("%'");
            }
            
            if (sort != null) {
                switch(sort) {
                    case "price_low": query.append(" ORDER BY price ASC"); break;
                    case "price_high": query.append(" ORDER BY price DESC"); break;
                    case "rating": query.append(" ORDER BY rating DESC"); break;
                    case "newest": query.append(" ORDER BY created_at DESC"); break;
                    default: query.append(" ORDER BY product_id DESC");
                }
            } else {
                query.append(" ORDER BY product_id DESC");
            }

            PreparedStatement ps = con.prepareStatement(query.toString());
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                products.add(mapProduct(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return products;
    }

    private List<Product> getProductsByQuery(String query) {
        List<Product> products = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                products.add(mapProduct(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return products;
    }

    private Product mapProduct(ResultSet rs) throws Exception {
        Product p = new Product();
        p.setProductId(rs.getInt("product_id"));
        p.setProductName(rs.getString("product_name"));
        p.setBrand(rs.getString("brand"));
        p.setPrice(rs.getDouble("price"));
        p.setCategory(rs.getString("category"));
        p.setImageUrl(rs.getString("image_url"));
        p.setDescription(rs.getString("description"));
        p.setStock(rs.getInt("stock"));
        
        p.setDiscountPercentage(rs.getDouble("discount_percentage"));
        p.setRating(rs.getDouble("rating"));
        p.setReviewsCount(rs.getInt("reviews_count"));
        p.setOriginalPrice(rs.getDouble("original_price"));
        p.setSizes(rs.getString("sizes"));
        p.setColors(rs.getString("colors"));
        p.setImageUrl2(rs.getString("image_url_2"));
        p.setImageUrl3(rs.getString("image_url_3"));
        p.setImageUrl4(rs.getString("image_url_4"));
        p.setNewArrival(rs.getBoolean("is_new_arrival"));
        p.setBestSeller(rs.getBoolean("is_best_seller"));
        p.setTrending(rs.getBoolean("is_trending"));
        p.setCreatedAt(rs.getTimestamp("created_at"));
        
        return p;
    }
}