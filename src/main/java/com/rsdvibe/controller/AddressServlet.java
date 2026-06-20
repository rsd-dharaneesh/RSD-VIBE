package com.rsdvibe.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.rsdvibe.dao.AddressDAO;
import com.rsdvibe.model.Address;
import com.rsdvibe.model.User;

@WebServlet("/address")
public class AddressServlet extends HttpServlet {

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
        
        String action = request.getParameter("action");
        AddressDAO dao = new AddressDAO();
        
        if ("add".equals(action)) {
            Address address = new Address();
            address.setUserId(user.getUserId());
            address.setFullName(request.getParameter("fullName"));
            address.setPhone(request.getParameter("phone"));
            address.setAddressLine(request.getParameter("addressLine"));
            address.setCity(request.getParameter("city"));
            address.setState(request.getParameter("state"));
            address.setPincode(request.getParameter("pincode"));
            address.setDefault(request.getParameter("isDefault") != null);
            
            dao.addAddress(address);
        } else if ("delete".equals(action)) {
            int addressId = Integer.parseInt(request.getParameter("addressId"));
            dao.deleteAddress(addressId, user.getUserId());
        } else if ("setDefault".equals(action)) {
            int addressId = Integer.parseInt(request.getParameter("addressId"));
            dao.setDefaultAddress(addressId, user.getUserId());
        }
        
        String source = request.getParameter("source");
        if ("checkout".equals(source)) {
            response.sendRedirect("checkout.jsp");
        } else {
            response.sendRedirect("profile");
        }
    }
}
