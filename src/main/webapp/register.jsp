<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - RSD VIBE</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

    <%@ include file="components/navbar.jsp" %>

    <div class="auth-layout">
        <div class="auth-image" style="background-image: url('https://images.unsplash.com/photo-1593030761757-71fae45fa0e7?w=800&q=80');"></div>
        <div class="auth-form-wrap">
            <h2 style="font-size: 2.5rem; margin-bottom: 0.5rem;">Create Account</h2>
            <p class="text-muted" style="margin-bottom: 2rem;">Join RSD VIBE and discover premium fashion.</p>
            
            <% String error = (String) request.getAttribute("error"); 
               if(error != null) { %>
                <div class="toast error show" style="position: relative; transform: none; margin-bottom: 1rem;"><%= error %></div>
            <% } %>

            <form action="register" method="post">
                <div class="form-group">
                    <label class="form-label">Full Name</label>
                    <input type="text" name="fullName" class="form-control" required placeholder="John Doe">
                </div>

                <div class="form-group">
                    <label class="form-label">Email Address</label>
                    <input type="email" name="email" class="form-control" required placeholder="john@example.com">
                </div>
                
                <div class="form-group">
                    <label class="form-label">Phone Number</label>
                    <input type="text" name="phone" class="form-control" required placeholder="9876543210">
                </div>
                
                <div class="form-group">
                    <label class="form-label">Password</label>
                    <input type="password" name="password" class="form-control" required placeholder="••••••••">
                </div>

                <div class="form-group">
                    <label class="form-label">Address (Optional)</label>
                    <textarea name="address" class="form-control" placeholder="Your delivery address"></textarea>
                </div>
                
                <div class="checkbox-group mb-3">
                    <input type="checkbox" id="terms" required>
                    <label for="terms">I agree to the Terms & Conditions and Privacy Policy</label>
                </div>
                
                <button type="submit" class="btn btn-primary btn-block">Create Account</button>
            </form>
            
            <div class="text-center mt-3">
                <p class="text-muted">Already have an account? <a href="login.jsp" class="font-weight-bold" style="color: var(--primary-color);">Sign In</a></p>
            </div>
        </div>
    </div>

</body>
</html>