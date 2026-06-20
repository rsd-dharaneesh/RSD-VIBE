package com.rsdvibe.model;

import java.sql.Timestamp;

public class Coupon {
    private int couponId;
    private String code;
    private String discountType;
    private double discountValue;
    private double minOrder;
    private double maxDiscount;
    private Timestamp validUntil;
    private boolean isActive;

    public Coupon() {}

    public int getCouponId() { return couponId; }
    public void setCouponId(int couponId) { this.couponId = couponId; }

    public String getCode() { return code; }
    public void setCode(String code) { this.code = code; }

    public String getDiscountType() { return discountType; }
    public void setDiscountType(String discountType) { this.discountType = discountType; }

    public double getDiscountValue() { return discountValue; }
    public void setDiscountValue(double discountValue) { this.discountValue = discountValue; }

    public double getMinOrder() { return minOrder; }
    public void setMinOrder(double minOrder) { this.minOrder = minOrder; }

    public double getMaxDiscount() { return maxDiscount; }
    public void setMaxDiscount(double maxDiscount) { this.maxDiscount = maxDiscount; }

    public Timestamp getValidUntil() { return validUntil; }
    public void setValidUntil(Timestamp validUntil) { this.validUntil = validUntil; }

    public boolean isActive() { return isActive; }
    public void setActive(boolean isActive) { this.isActive = isActive; }
}
