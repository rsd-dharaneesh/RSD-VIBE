package com.rsdvibe.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.rsdvibe.dao.OrderDAO;
import com.rsdvibe.model.CartItem;
import com.rsdvibe.model.Order;
import com.rsdvibe.model.User;

@WebServlet("/placeOrder")
public class PlaceOrderServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String address = request.getParameter("address");
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String paymentMethod = request.getParameter("payment_method");
        String couponCode = request.getParameter("coupon_code");
        
        double deliveryCharge = 0;
        try { deliveryCharge = Double.parseDouble(request.getParameter("delivery_charge")); } catch(Exception e){}
        
        double discountAmount = 0;
        try { discountAmount = Double.parseDouble(request.getParameter("discount_amount")); } catch(Exception e){}

        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        double totalAmount = 0;

        if (cart != null) {
            for (CartItem item : cart) {
                totalAmount += item.getTotalPrice();
            }
        }
        
        // Final calculation
        double finalAmount = totalAmount - discountAmount + deliveryCharge;

        Order order = new Order();
        order.setCustomerName(name != null ? name : user.getFullName());
        order.setPhone(phone != null ? phone : user.getPhone());
        order.setAddress(address);
        order.setTotalAmount(finalAmount);
        order.setStatus("Processing");
        order.setPaymentMethod(paymentMethod);
        order.setCouponCode(couponCode);
        order.setDiscountAmount(discountAmount);
        order.setDeliveryCharge(deliveryCharge);

        OrderDAO dao = new OrderDAO();
        int orderId = dao.saveOrder(order);
        
        if (cart != null) {
            for (CartItem item : cart) {
                dao.saveOrderItem(orderId, item);
            }
        }

        session.removeAttribute("cart");
        session.removeAttribute("coupon"); // Clear any applied coupon

        request.setAttribute("orderId", orderId);
        request.getRequestDispatcher("success.jsp").forward(request, response);
    }
}