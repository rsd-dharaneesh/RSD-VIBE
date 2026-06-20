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

@WebServlet("/search")
public class SearchServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String keyword = request.getParameter("keyword");

        ProductDAO dao = new ProductDAO();

        // Use advancedSearch instead of normal search
        List<Product> products = dao.advancedSearch(keyword);
        List<String> brands = dao.getBrands();
        List<String> categories = dao.getCategories();

        request.setAttribute("products", products);
        request.setAttribute("brands", brands);
        request.setAttribute("categories", categories);
        request.setAttribute("keyword", keyword);

        request.getRequestDispatcher("products.jsp")
               .forward(request, response);
    }
}