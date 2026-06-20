package com.rsdvibe.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.rsdvibe.dao.ProductDAO;
import com.rsdvibe.dao.RecentlyViewedDAO;
import com.rsdvibe.dao.ReviewDAO;
import com.rsdvibe.model.Product;
import com.rsdvibe.model.Review;
import com.rsdvibe.model.User;

@WebServlet("/productDetail")
public class ProductDetailServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");
        if (idParam == null) {
            response.sendRedirect("products");
            return;
        }

        int productId = Integer.parseInt(idParam);

        ProductDAO productDAO = new ProductDAO();
        Product product = productDAO.getProductById(productId);

        if (product == null) {
            response.sendRedirect("products");
            return;
        }

        ReviewDAO reviewDAO = new ReviewDAO();
        List<Review> reviews = reviewDAO.getReviewsByProduct(productId);

        List<Product> similarProducts = productDAO.getSimilarProducts(product.getCategory(), productId);

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user != null) {
            RecentlyViewedDAO rvDAO = new RecentlyViewedDAO();
            rvDAO.addRecentlyViewed(user.getUserId(), productId);
            
            boolean hasReviewed = reviewDAO.hasUserReviewed(user.getUserId(), productId);
            request.setAttribute("hasReviewed", hasReviewed);
        }

        request.setAttribute("product", product);
        request.setAttribute("reviews", reviews);
        request.setAttribute("similarProducts", similarProducts);

        request.getRequestDispatcher("productDetail.jsp").forward(request, response);
    }
}
