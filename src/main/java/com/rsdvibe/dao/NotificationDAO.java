package com.rsdvibe.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.rsdvibe.model.Notification;
import com.rsdvibe.util.DBConnection;

public class NotificationDAO {

    public void addNotification(int userId, String title, String message) {
        try {
            Connection con = DBConnection.getConnection();
            String query = "INSERT INTO notifications(user_id, title, message) VALUES(?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, userId);
            ps.setString(2, title);
            ps.setString(3, message);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Notification> getNotifications(int userId) {
        List<Notification> notifications = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            String query = "SELECT * FROM notifications WHERE user_id=? ORDER BY created_at DESC";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Notification n = new Notification();
                n.setNotificationId(rs.getInt("notification_id"));
                n.setUserId(rs.getInt("user_id"));
                n.setTitle(rs.getString("title"));
                n.setMessage(rs.getString("message"));
                n.setRead(rs.getBoolean("is_read"));
                n.setCreatedAt(rs.getTimestamp("created_at"));
                notifications.add(n);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return notifications;
    }

    public void markAsRead(int notificationId) {
        try {
            Connection con = DBConnection.getConnection();
            String query = "UPDATE notifications SET is_read=TRUE WHERE notification_id=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, notificationId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public int getUnreadCount(int userId) {
        int count = 0;
        try {
            Connection con = DBConnection.getConnection();
            String query = "SELECT COUNT(*) FROM notifications WHERE user_id=? AND is_read=FALSE";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }
}
