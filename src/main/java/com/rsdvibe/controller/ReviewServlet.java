package com.rsdvibe.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.rsdvibe.dao.ReviewDAO;
import com.rsdvibe.model.Review;
import com.rsdvibe.model.User;

@WebServlet("/review")
public class ReviewServlet extends HttpServlet {

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
        
        int productId = Integer.parseInt(request.getParameter("productId"));
        double rating = Double.parseDouble(request.getParameter("rating"));
        String reviewText = request.getParameter("reviewText");
        
        Review review = new Review();
        review.setUserId(user.getUserId());
        review.setProductId(productId);
        review.setRating(rating);
        review.setReviewText(reviewText);
        
        ReviewDAO dao = new ReviewDAO();
        dao.addReview(review);
        
        response.sendRedirect("productDetail?id=" + productId);
    }
}
