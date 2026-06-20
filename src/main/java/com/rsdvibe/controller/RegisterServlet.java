package com.rsdvibe.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.rsdvibe.dao.UserDAO;
import com.rsdvibe.model.User;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String address = request.getParameter("address");

        User user = new User();

        user.setFullName(fullName);
        user.setEmail(email);
        user.setPhone(phone);
        user.setPassword(password);
        user.setAddress(address);

        UserDAO dao = new UserDAO();

        boolean status = dao.registerUser(user);

        if(status) {
            response.getWriter().println("Registration Successful");
        } else {
            response.getWriter().println("Registration Failed");
        }
    }
}