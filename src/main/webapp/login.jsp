<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - RSD VIBE</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

    <%@ include file="components/navbar.jsp" %>

    <div class="auth-layout">
        <div class="auth-image"></div>
        <div class="auth-form-wrap">
            <h2 style="font-size: 2.5rem; margin-bottom: 0.5rem;">Welcome Back</h2>
            <p class="text-muted" style="margin-bottom: 2rem;">Please enter your details to sign in.</p>
            
            <% String error = (String) request.getAttribute("error"); 
               if(error != null) { %>
                <div class="toast error show" style="position: relative; transform: none; margin-bottom: 1rem;"><%= error %></div>
            <% } %>

            <form action="login" method="post">
                <div class="form-group">
                    <label class="form-label">Email Address</label>
                    <input type="email" name="email" class="form-control" required placeholder="Enter your email">
                </div>
                
                <div class="form-group">
                    <label class="form-label" style="display: flex; justify-content: space-between;">
                        Password
                        <a href="#" style="font-size: 0.85rem; font-weight: 400; color: var(--text-muted);">Forgot Password?</a>
                    </label>
                    <input type="password" name="password" class="form-control" required placeholder="••••••••">
                </div>
                
                <button type="submit" class="btn btn-primary btn-block mt-2">Sign In</button>
            </form>
            
            <div class="text-center mt-3">
                <p class="text-muted">Don't have an account? <a href="register.jsp" class="font-weight-bold" style="color: var(--primary-color);">Sign Up</a></p>
            </div>
        </div>
    </div>

</body>
</html>