package com.rsdvibe.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.rsdvibe.dao.ProductDAO;
import com.rsdvibe.model.CartItem;
import com.rsdvibe.model.Product;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    private void processRequest(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String productIdStr = request.getParameter("productId");
        if(productIdStr == null) {
            response.sendRedirect("cart.jsp");
            return;
        }

        int productId = Integer.parseInt(productIdStr);
        String size = request.getParameter("size");
        String color = request.getParameter("color");
        int quantity = 1;
        if(request.getParameter("quantity") != null) {
            quantity = Integer.parseInt(request.getParameter("quantity"));
        }

        ProductDAO dao = new ProductDAO();
        Product product = dao.getProductById(productId);

        HttpSession session = request.getSession();
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

        if (cart == null) {
            cart = new ArrayList<>();
        }

        boolean found = false;
        for (CartItem item : cart) {
            if (item.getProductId() == productId && 
               ((item.getSize() == null && size == null) || (item.getSize() != null && item.getSize().equals(size))) &&
               ((item.getColor() == null && color == null) || (item.getColor() != null && item.getColor().equals(color)))) {
                
                item.setQuantity(item.getQuantity() + quantity);
                found = true;
                break;
            }
        }

        if (!found) {
            CartItem item = new CartItem();
            item.setProductId(product.getProductId());
            item.setProductName(product.getProductName());
            item.setPrice(product.getDiscountedPrice()); // Use discounted price
            item.setOriginalPrice(product.getOriginalPrice() > 0 ? product.getOriginalPrice() : product.getPrice());
            item.setDiscountPercentage(product.getDiscountPercentage());
            item.setImageUrl(product.getImageUrl());
            item.setQuantity(quantity);
            item.setSize(size);
            item.setColor(color);
            item.setBrand(product.getBrand());
            item.setCategory(product.getCategory());
            cart.add(item);
        }

        session.setAttribute("cart", cart);

        // AJAX request check
        if("XMLHttpRequest".equals(request.getHeader("X-Requested-With"))) {
            response.getWriter().write("success");
            return;
        }

        response.sendRedirect("cart.jsp");
    }
}