package com.rsdvibe.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.rsdvibe.dao.AddressDAO;
import com.rsdvibe.dao.OrderDAO;
import com.rsdvibe.dao.UserDAO;
import com.rsdvibe.dao.WishlistDAO;
import com.rsdvibe.model.Address;
import com.rsdvibe.model.Order;
import com.rsdvibe.model.Product;
import com.rsdvibe.model.User;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User loggedUser = (User) session.getAttribute("user");

        if(loggedUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        UserDAO userDAO = new UserDAO();
        User user = userDAO.getUserByEmail(loggedUser.getEmail());

        AddressDAO addressDAO = new AddressDAO();
        List<Address> addresses = addressDAO.getAddressesByUser(user.getUserId());

        OrderDAO orderDAO = new OrderDAO();
        List<Order> orders = orderDAO.getOrdersByUserId(user.getUserId());

        WishlistDAO wishlistDAO = new WishlistDAO();
        List<Product> wishlist = wishlistDAO.getWishlistByUser(user.getUserId());

        request.setAttribute("user", user);
        request.setAttribute("addresses", addresses);
        request.setAttribute("orders", orders);
        request.setAttribute("wishlist", wishlist);

        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }
}