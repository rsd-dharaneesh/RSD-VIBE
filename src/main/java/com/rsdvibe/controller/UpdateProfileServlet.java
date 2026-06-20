package com.rsdvibe.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.rsdvibe.dao.UserDAO;
import com.rsdvibe.model.User;

@WebServlet("/updateProfile")
public class UpdateProfileServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User sessionUser = (User) session.getAttribute("user");
        
        if (sessionUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        
        User user = new User();
        user.setEmail(sessionUser.getEmail());
        user.setFullName(fullName);
        user.setPhone(phone);
        user.setAddress(sessionUser.getAddress()); // preserve existing address or handle differently
        
        UserDAO dao = new UserDAO();
        if (dao.updateUser(user)) {
            // Update session
            sessionUser.setFullName(fullName);
            sessionUser.setPhone(phone);
            session.setAttribute("user", sessionUser);
        }
        
        response.sendRedirect("profile");
    }
}
