package com.rsdvibe.controller;

import java.io.IOException;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.rsdvibe.model.CartItem;

@WebServlet("/removeCart")
public class RemoveCartServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {
        
        int productId = Integer.parseInt(request.getParameter("productId"));
        
        HttpSession session = request.getSession();
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        
        if (cart != null) {
            Iterator<CartItem> iterator = cart.iterator();
            while (iterator.hasNext()) {
                CartItem item = iterator.next();
                if (item.getProductId() == productId) {
                    iterator.remove();
                    break;
                }
            }
            session.setAttribute("cart", cart);
        }
        
        response.sendRedirect("cart.jsp");
    }
}