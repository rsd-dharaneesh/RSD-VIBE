package com.rsdvibe.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    private static final String URL = "jdbc:mysql://localhost:3306/rsd_vibe";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "Mysql@123"; // Replace with your MySQL password

    public static Connection getConnection() {

        Connection con = null;

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");

            con = DriverManager.getConnection(
                    URL,
                    USERNAME,
                    PASSWORD);

            System.out.println("Database Connected Successfully");

        } catch (Exception e) {
            e.printStackTrace();
        }

        return con;
    }
}