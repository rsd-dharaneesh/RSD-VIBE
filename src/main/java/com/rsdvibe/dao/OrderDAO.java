package com.rsdvibe.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.rsdvibe.model.Order;
import com.rsdvibe.util.DBConnection;
import com.rsdvibe.model.CartItem;
import com.rsdvibe.model.OrderItem;

public class OrderDAO {

    public int saveOrder(Order order) {
        int orderId = 0;
        try {
            Connection con = DBConnection.getConnection();
            String query = "INSERT INTO orders(customer_name,phone,address,total_amount,status,payment_method,discount_amount,delivery_charge,coupon_code) VALUES(?,?,?,?,?,?,?,?,?)";
            PreparedStatement ps = con.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, order.getCustomerName());
            ps.setString(2, order.getPhone());
            ps.setString(3, order.getAddress());
            ps.setDouble(4, order.getTotalAmount());
            ps.setString(5, order.getStatus() == null ? "Processing" : order.getStatus());
            ps.setString(6, order.getPaymentMethod() == null ? "COD" : order.getPaymentMethod());
            ps.setDouble(7, order.getDiscountAmount());
            ps.setDouble(8, order.getDeliveryCharge());
            ps.setString(9, order.getCouponCode() == null ? "" : order.getCouponCode());

            ps.executeUpdate();
            var rs = ps.getGeneratedKeys();
            if (rs.next()) {
                orderId = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return orderId;
    }

    public void saveOrderItem(int orderId, CartItem item) {
        try {
            Connection con = DBConnection.getConnection();
            String query = "INSERT INTO order_items(order_id,product_id,quantity,price,size,color) VALUES(?,?,?,?,?,?)";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, orderId);
            ps.setInt(2, item.getProductId());
            ps.setInt(3, item.getQuantity());
            ps.setDouble(4, item.getPrice());
            ps.setString(5, item.getSize() == null ? "" : item.getSize());
            ps.setString(6, item.getColor() == null ? "" : item.getColor());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public List<Order> getAllOrders() {
        List<Order> orders = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            String query = "SELECT * FROM orders ORDER BY order_id DESC";
            PreparedStatement ps = con.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                orders.add(mapOrder(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return orders;
    }

    public List<Order> getOrdersByUserId(int userId) {
        List<Order> orders = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            // Using phone number to simulate user id since order table in original code didn't have user_id, 
            // wait, let's assume we link by phone/name or modify query if we added user_id.
            // Oh, wait, the original Order table has customer_name, phone, address, total_amount.
            // My migration didn't add user_id to orders table explicitly in this schema (wait, it did? No, my schema upgrade didn't add user_id to orders).
            // Let me modify the schema upgrade script conceptually to add user_id or we just join users by phone. Let's add it dynamically or just use phone.
            String query = "SELECT o.* FROM orders o JOIN users u ON o.phone = u.phone WHERE u.user_id = ? ORDER BY o.order_date DESC, o.order_id DESC";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                orders.add(mapOrder(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return orders;
    }

    public Order getOrderWithItems(int orderId) {
        Order order = null;
        try {
            Connection con = DBConnection.getConnection();
            String query = "SELECT * FROM orders WHERE order_id = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                order = mapOrder(rs);
                
                // Get Items
                List<OrderItem> items = new ArrayList<>();
                String itemsQuery = "SELECT oi.*, p.product_name, p.image_url FROM order_items oi JOIN products p ON oi.product_id = p.product_id WHERE oi.order_id = ?";
                PreparedStatement itemsPs = con.prepareStatement(itemsQuery);
                itemsPs.setInt(1, orderId);
                ResultSet itemsRs = itemsPs.executeQuery();
                while(itemsRs.next()) {
                    OrderItem item = new OrderItem();
                    item.setOrderItemId(itemsRs.getInt("order_item_id"));
                    item.setOrderId(itemsRs.getInt("order_id"));
                    item.setProductId(itemsRs.getInt("product_id"));
                    item.setProductName(itemsRs.getString("product_name"));
                    item.setImageUrl(itemsRs.getString("image_url"));
                    item.setQuantity(itemsRs.getInt("quantity"));
                    item.setPrice(itemsRs.getDouble("price"));
                    item.setSize(itemsRs.getString("size"));
                    item.setColor(itemsRs.getString("color"));
                    items.add(item);
                }
                order.setItems(items);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return order;
    }

    private Order mapOrder(ResultSet rs) throws Exception {
        Order order = new Order();
        order.setOrderId(rs.getInt("order_id"));
        order.setCustomerName(rs.getString("customer_name"));
        order.setPhone(rs.getString("phone"));
        order.setAddress(rs.getString("address"));
        order.setTotalAmount(rs.getDouble("total_amount"));
        order.setOrderDate(rs.getTimestamp("order_date"));
        order.setStatus(rs.getString("status"));
        order.setPaymentMethod(rs.getString("payment_method"));
        order.setDiscountAmount(rs.getDouble("discount_amount"));
        order.setDeliveryCharge(rs.getDouble("delivery_charge"));
        order.setCouponCode(rs.getString("coupon_code"));
        return order;
    }
}