package com.rsdvibe.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.rsdvibe.model.CartItem;

@WebServlet("/updateCart")
public class CartUpdateServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        int productId =
                Integer.parseInt(request.getParameter("productId"));

        String action =
                request.getParameter("action");

        HttpSession session =
                request.getSession();

        List<CartItem> cart =
                (List<CartItem>) session.getAttribute("cart");

        if(cart != null) {

            for(CartItem item : cart) {

                if(item.getProductId() == productId) {

                    if("increase".equals(action)) {

                        item.setQuantity(
                                item.getQuantity() + 1);

                    } else if("decrease".equals(action)) {

                        if(item.getQuantity() > 1) {

                            item.setQuantity(
                                    item.getQuantity() - 1);
                        }
                    }

                    break;
                }
            }
        }

        response.sendRedirect("cart.jsp");
    }
}