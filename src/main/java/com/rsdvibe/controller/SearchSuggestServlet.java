package com.rsdvibe.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.rsdvibe.dao.ProductDAO;

@WebServlet("/searchSuggest")
public class SearchSuggestServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {
        
        String keyword = request.getParameter("keyword");
        
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        
        if (keyword != null && keyword.trim().length() > 0) {
            ProductDAO dao = new ProductDAO();
            List<String> suggestions = dao.getSearchSuggestions(keyword);
            
            StringBuilder json = new StringBuilder("[");
            for (int i = 0; i < suggestions.size(); i++) {
                json.append("\"").append(suggestions.get(i).replace("\"", "\\\"")).append("\"");
                if (i < suggestions.size() - 1) {
                    json.append(",");
                }
            }
            json.append("]");
            
            out.print(json.toString());
        } else {
            out.print("[]");
        }
        out.flush();
    }
}
