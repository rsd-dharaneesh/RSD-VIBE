package com.rsdvibe.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.rsdvibe.dao.WishlistDAO;
import com.rsdvibe.model.User;

@WebServlet("/wishlist")
public class WishlistServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        String action = request.getParameter("action");
        String productIdStr = request.getParameter("productId");
        
        if (action != null && productIdStr != null) {
            int productId = Integer.parseInt(productIdStr);
            WishlistDAO dao = new WishlistDAO();
            
            if ("add".equals(action)) {
                dao.addToWishlist(user.getUserId(), productId);
            } else if ("remove".equals(action)) {
                dao.removeFromWishlist(user.getUserId(), productId);
            }
            
            if ("XMLHttpRequest".equals(request.getHeader("X-Requested-With"))) {
                response.setContentType("application/json");
                PrintWriter out = response.getWriter();
                out.print("{\"status\":\"success\"}");
                out.flush();
                return;
            }
        }
        
        response.sendRedirect("profile");
    }
}
