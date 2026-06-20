package com.rsdvibe.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.rsdvibe.dao.CouponDAO;
import com.rsdvibe.model.Coupon;

@WebServlet("/applyCoupon")
public class CouponServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {
        
        String code = request.getParameter("code");
        double orderTotal = Double.parseDouble(request.getParameter("orderTotal"));
        
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        
        CouponDAO dao = new CouponDAO();
        Coupon coupon = dao.getCouponByCode(code);
        
        if (coupon != null) {
            if (orderTotal >= coupon.getMinOrder()) {
                double discount = 0;
                if ("PERCENTAGE".equals(coupon.getDiscountType())) {
                    discount = orderTotal * (coupon.getDiscountValue() / 100.0);
                    if (coupon.getMaxDiscount() > 0 && discount > coupon.getMaxDiscount()) {
                        discount = coupon.getMaxDiscount();
                    }
                } else {
                    discount = coupon.getDiscountValue();
                }
                
                HttpSession session = request.getSession();
                session.setAttribute("coupon", coupon);
                
                out.print("{\"status\":\"success\", \"discount\":" + discount + ", \"code\":\"" + coupon.getCode() + "\"}");
            } else {
                out.print("{\"status\":\"error\", \"message\":\"Minimum order amount should be " + coupon.getMinOrder() + "\"}");
            }
        } else {
            out.print("{\"status\":\"error\", \"message\":\"Invalid or expired coupon code\"}");
        }
        out.flush();
    }
}
