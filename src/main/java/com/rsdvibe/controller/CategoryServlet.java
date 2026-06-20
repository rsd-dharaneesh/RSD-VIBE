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

@WebServlet("/category")
public class CategoryServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String category =
                request.getParameter("name");

        ProductDAO dao = new ProductDAO();

        List<Product> products =
                dao.getProductsByCategory(category);

        request.setAttribute("products", products);

        request.getRequestDispatcher("products.jsp")
               .forward(request, response);
    }
}