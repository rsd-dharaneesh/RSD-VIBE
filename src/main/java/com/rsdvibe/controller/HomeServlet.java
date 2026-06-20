package com.rsdvibe.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.rsdvibe.dao.ProductDAO;
import com.rsdvibe.model.Product;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {
        
        ProductDAO dao = new ProductDAO();
        
        List<Product> newArrivals = dao.getNewArrivals();
        List<Product> trendingProducts = dao.getTrendingProducts();
        List<Product> bestSellers = dao.getBestSellers();
        
        request.setAttribute("newArrivals", newArrivals);
        request.setAttribute("trendingProducts", trendingProducts);
        request.setAttribute("bestSellers", bestSellers);
        
        request.getRequestDispatcher("home.jsp").forward(request, response);
    }
}
