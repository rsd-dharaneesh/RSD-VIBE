package com.rsdvibe.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.rsdvibe.dao.OrderDAO;
import com.rsdvibe.model.Order;
import com.rsdvibe.model.User;

@WebServlet("/myorders")
public class MyOrdersServlet extends HttpServlet {

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

        OrderDAO dao = new OrderDAO();
        List<Order> orders = dao.getOrdersByUserId(user.getUserId());

        // Get items for each order
        for (int i = 0; i < orders.size(); i++) {
            Order fullOrder = dao.getOrderWithItems(orders.get(i).getOrderId());
            orders.set(i, fullOrder);
        }

        request.setAttribute("orders", orders);
        request.getRequestDispatcher("myorders.jsp").forward(request, response);
    }
}