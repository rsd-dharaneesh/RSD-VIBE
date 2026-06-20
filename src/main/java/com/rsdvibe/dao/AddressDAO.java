package com.rsdvibe.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.rsdvibe.model.Address;
import com.rsdvibe.util.DBConnection;

public class AddressDAO {

    public boolean addAddress(Address address) {
        boolean status = false;
        try {
            Connection con = DBConnection.getConnection();
            // If this is the first address, make it default
            if (!hasAddresses(address.getUserId(), con)) {
                address.setDefault(true);
            } else if (address.isDefault()) {
                clearDefaultAddress(address.getUserId(), con);
            }
            
            String query = "INSERT INTO addresses(user_id, full_name, phone, address_line, city, state, pincode, is_default) VALUES(?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, address.getUserId());
            ps.setString(2, address.getFullName());
            ps.setString(3, address.getPhone());
            ps.setString(4, address.getAddressLine());
            ps.setString(5, address.getCity());
            ps.setString(6, address.getState());
            ps.setString(7, address.getPincode());
            ps.setBoolean(8, address.isDefault());
            
            int rows = ps.executeUpdate();
            if (rows > 0) status = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }

    private boolean hasAddresses(int userId, Connection con) throws Exception {
        String q = "SELECT address_id FROM addresses WHERE user_id=? LIMIT 1";
        PreparedStatement ps = con.prepareStatement(q);
        ps.setInt(1, userId);
        return ps.executeQuery().next();
    }

    private void clearDefaultAddress(int userId, Connection con) throws Exception {
        String q = "UPDATE addresses SET is_default=FALSE WHERE user_id=?";
        PreparedStatement ps = con.prepareStatement(q);
        ps.setInt(1, userId);
        ps.executeUpdate();
    }

    public boolean updateAddress(Address address) {
        boolean status = false;
        try {
            Connection con = DBConnection.getConnection();
            if (address.isDefault()) {
                clearDefaultAddress(address.getUserId(), con);
            }
            
            String query = "UPDATE addresses SET full_name=?, phone=?, address_line=?, city=?, state=?, pincode=?, is_default=? WHERE address_id=? AND user_id=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, address.getFullName());
            ps.setString(2, address.getPhone());
            ps.setString(3, address.getAddressLine());
            ps.setString(4, address.getCity());
            ps.setString(5, address.getState());
            ps.setString(6, address.getPincode());
            ps.setBoolean(7, address.isDefault());
            ps.setInt(8, address.getAddressId());
            ps.setInt(9, address.getUserId());
            
            int rows = ps.executeUpdate();
            if (rows > 0) status = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }

    public boolean deleteAddress(int addressId, int userId) {
        boolean status = false;
        try {
            Connection con = DBConnection.getConnection();
            String query = "DELETE FROM addresses WHERE address_id=? AND user_id=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, addressId);
            ps.setInt(2, userId);
            int rows = ps.executeUpdate();
            if (rows > 0) status = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }

    public List<Address> getAddressesByUser(int userId) {
        List<Address> addresses = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            String query = "SELECT * FROM addresses WHERE user_id=? ORDER BY is_default DESC, address_id DESC";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Address a = new Address();
                a.setAddressId(rs.getInt("address_id"));
                a.setUserId(rs.getInt("user_id"));
                a.setFullName(rs.getString("full_name"));
                a.setPhone(rs.getString("phone"));
                a.setAddressLine(rs.getString("address_line"));
                a.setCity(rs.getString("city"));
                a.setState(rs.getString("state"));
                a.setPincode(rs.getString("pincode"));
                a.setDefault(rs.getBoolean("is_default"));
                addresses.add(a);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return addresses;
    }

    public boolean setDefaultAddress(int addressId, int userId) {
        boolean status = false;
        try {
            Connection con = DBConnection.getConnection();
            clearDefaultAddress(userId, con);
            String query = "UPDATE addresses SET is_default=TRUE WHERE address_id=? AND user_id=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, addressId);
            ps.setInt(2, userId);
            int rows = ps.executeUpdate();
            if (rows > 0) status = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }
}
