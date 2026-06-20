package com.rsdvibe.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.rsdvibe.model.Coupon;
import com.rsdvibe.util.DBConnection;

public class CouponDAO {

    public Coupon getCouponByCode(String code) {
        Coupon coupon = null;
        try {
            Connection con = DBConnection.getConnection();
            String query = "SELECT * FROM coupons WHERE code=? AND is_active=TRUE AND (valid_until IS NULL OR valid_until > NOW())";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, code);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                coupon = new Coupon();
                coupon.setCouponId(rs.getInt("coupon_id"));
                coupon.setCode(rs.getString("code"));
                coupon.setDiscountType(rs.getString("discount_type"));
                coupon.setDiscountValue(rs.getDouble("discount_value"));
                coupon.setMinOrder(rs.getDouble("min_order"));
                coupon.setMaxDiscount(rs.getDouble("max_discount"));
                coupon.setValidUntil(rs.getTimestamp("valid_until"));
                coupon.setActive(rs.getBoolean("is_active"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return coupon;
    }

    public List<Coupon> getAllActiveCoupons() {
        List<Coupon> coupons = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            String query = "SELECT * FROM coupons WHERE is_active=TRUE AND (valid_until IS NULL OR valid_until > NOW()) ORDER BY discount_value DESC";
            PreparedStatement ps = con.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Coupon coupon = new Coupon();
                coupon.setCouponId(rs.getInt("coupon_id"));
                coupon.setCode(rs.getString("code"));
                coupon.setDiscountType(rs.getString("discount_type"));
                coupon.setDiscountValue(rs.getDouble("discount_value"));
                coupon.setMinOrder(rs.getDouble("min_order"));
                coupon.setMaxDiscount(rs.getDouble("max_discount"));
                coupon.setValidUntil(rs.getTimestamp("valid_until"));
                coupon.setActive(rs.getBoolean("is_active"));
                coupons.add(coupon);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return coupons;
    }
}
