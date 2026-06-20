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

@WebServlet("/filter")
public class FilterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {
        
        String brand = request.getParameter("brand");
        String category = request.getParameter("category");
        String minPriceStr = request.getParameter("minPrice");
        String maxPriceStr = request.getParameter("maxPrice");
        String size = request.getParameter("size");
        String color = request.getParameter("color");
        String sort = request.getParameter("sort");
        
        Double minPrice = null;
        Double maxPrice = null;
        try { if(minPriceStr != null && !minPriceStr.isEmpty()) minPrice = Double.parseDouble(minPriceStr); } catch(Exception e){}
        try { if(maxPriceStr != null && !maxPriceStr.isEmpty()) maxPrice = Double.parseDouble(maxPriceStr); } catch(Exception e){}
        
        ProductDAO dao = new ProductDAO();
        List<Product> products = dao.getProductsByFilters(brand, category, minPrice, maxPrice, size, color, sort);
        List<String> brands = dao.getBrands();
        List<String> categories = dao.getCategories();

        request.setAttribute("products", products);
        request.setAttribute("brands", brands);
        request.setAttribute("categories", categories);
        
        // Pass back params to keep them checked in UI
        request.setAttribute("selectedBrand", brand);
        request.setAttribute("selectedCategory", category);
        request.setAttribute("selectedMinPrice", minPriceStr);
        request.setAttribute("selectedMaxPrice", maxPriceStr);
        request.setAttribute("selectedSize", size);
        request.setAttribute("selectedColor", color);
        request.setAttribute("selectedSort", sort);

        request.getRequestDispatcher("products.jsp").forward(request, response);
    }
}
