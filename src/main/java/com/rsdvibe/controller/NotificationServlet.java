package com.rsdvibe.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.rsdvibe.dao.NotificationDAO;
import com.rsdvibe.model.Notification;
import com.rsdvibe.model.User;

@WebServlet("/notifications")
public class NotificationServlet extends HttpServlet {

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
        
        String action = request.getParameter("action");
        NotificationDAO dao = new NotificationDAO();
        
        if ("markRead".equals(action)) {
            int notificationId = Integer.parseInt(request.getParameter("id"));
            dao.markAsRead(notificationId);
        }
        
        List<Notification> notifications = dao.getNotifications(user.getUserId());
        request.setAttribute("notifications", notifications);
        
        request.getRequestDispatcher("profile.jsp?tab=notifications").forward(request, response);
    }
}
