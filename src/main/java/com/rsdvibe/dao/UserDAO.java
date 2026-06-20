package com.rsdvibe.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.rsdvibe.model.User;
import com.rsdvibe.util.DBConnection;

public class UserDAO {

    // Registration
    public boolean registerUser(User user) {
        boolean status = false;
        try {
            Connection con = DBConnection.getConnection();
            String query = "INSERT INTO users(full_name,email,phone,password,address) VALUES(?,?,?,?,?)";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, user.getFullName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPhone());
            ps.setString(4, user.getPassword());
            ps.setString(5, user.getAddress());

            int rows = ps.executeUpdate();
            if (rows > 0) {
                status = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }

    // Login
    public User loginUser(String email, String password) {
        User user = null;
        try {
            Connection con = DBConnection.getConnection();
            String query = "SELECT * FROM users WHERE email=? AND password=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setFullName(rs.getString("full_name"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setAddress(rs.getString("address"));
                user.setProfilePhoto(rs.getString("profile_photo"));
                user.setCreatedAt(rs.getTimestamp("created_at"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    public User getUserByEmail(String email) {
        User user = null;
        try {
            Connection con = DBConnection.getConnection();
            String query = "SELECT * FROM users WHERE email=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, email);

            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
                user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setFullName(rs.getString("full_name"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setAddress(rs.getString("address"));
                user.setProfilePhoto(rs.getString("profile_photo"));
                user.setCreatedAt(rs.getTimestamp("created_at"));
            }
        } catch(Exception e) {
            e.printStackTrace();
        }
        return user;
    }
    
    // Update User Profile
    public boolean updateUser(User user) {
        boolean status = false;
        try {
            Connection con = DBConnection.getConnection();
            String query = "UPDATE users SET full_name=?, phone=?, address=? WHERE email=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, user.getFullName());
            ps.setString(2, user.getPhone());
            ps.setString(3, user.getAddress());
            ps.setString(4, user.getEmail());

            int rows = ps.executeUpdate();
            if(rows > 0) {
                status = true;
            }
        } catch(Exception e) {
            e.printStackTrace();
        }
        return status;
    }

    public boolean updateProfilePhoto(int userId, String photoUrl) {
        boolean status = false;
        try {
            Connection con = DBConnection.getConnection();
            String query = "UPDATE users SET profile_photo=? WHERE user_id=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, photoUrl);
            ps.setInt(2, userId);

            int rows = ps.executeUpdate();
            if(rows > 0) {
                status = true;
            }
        } catch(Exception e) {
            e.printStackTrace();
        }
        return status;
    }

    public boolean changePassword(int userId, String oldPassword, String newPassword) {
        boolean status = false;
        try {
            Connection con = DBConnection.getConnection();
            String query = "UPDATE users SET password=? WHERE user_id=? AND password=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, newPassword);
            ps.setInt(2, userId);
            ps.setString(3, oldPassword);

            int rows = ps.executeUpdate();
            if(rows > 0) {
                status = true;
            }
        } catch(Exception e) {
            e.printStackTrace();
        }
        return status;
    }
}