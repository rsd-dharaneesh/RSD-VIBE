# RSD-VIBE - Premium Men's Fashion E-Commerce Website

## Overview

RSD-VIBE is a full-stack e-commerce web application developed for premium men's fashion products. The application allows users to browse products, manage their cart and wishlist, place orders, submit reviews, and manage their profile.

The project is built using Java Servlets, JSP, JDBC, MySQL, HTML, CSS, and JavaScript following the MVC architecture.

---

## Features

### User Management

* User Registration
* User Login & Logout
* Profile Management
* Address Management

### Product Management

* Product Listing
* Product Categories
* Product Search
* Advanced Product Filters
* Product Details Page
* Similar Product Recommendations

### Shopping Features

* Add to Cart
* Update Cart Quantity
* Remove from Cart
* Wishlist Management
* Checkout Process
* Order Placement
* Order History

### Reviews & Ratings

* Product Reviews
* Product Ratings
* Automatic Rating Calculation
* Review Count Tracking

### Premium Features

* New Arrivals Section
* Best Sellers Section
* Trending Products Section
* Discount Management
* Multiple Product Images
* Size Selection
* Color Selection
* Search Suggestions

---

## Technology Stack

### Frontend

* HTML5
* CSS3
* JavaScript
* JSP (Java Server Pages)

### Backend

* Java
* Servlets
* JDBC

### Database

* MySQL

### Server

* Apache Tomcat 9

### Development Tools

* Eclipse IDE
* MySQL Workbench
* GitHub Desktop
* GitHub

---

## Database Tables

* users
* products
* orders
* order_items
* wishlist
* product_reviews
* coupons
* user_addresses

---

## Project Structure

```text
RSD-VIBE
│
├── src
│   ├── com.rsdvibe.controller
│   ├── com.rsdvibe.dao
│   ├── com.rsdvibe.model
│   └── com.rsdvibe.util
│
├── src/main/webapp
│   ├── css
│   ├── js
│   ├── images
│   ├── components
│   └── *.jsp
│
└── sql
```

---

## Installation

### Prerequisites

* Java JDK 8 or above
* Eclipse IDE
* Apache Tomcat 9
* MySQL Server
* MySQL Workbench

### Steps

1. Clone the repository.
2. Import the project into Eclipse.
3. Create a MySQL database named:

```sql
CREATE DATABASE rsd_vibe;
```

4. Import the database script.
5. Configure database credentials in:

```java
DBConnection.java
```

6. Add MySQL Connector JAR to the project.
7. Configure Apache Tomcat.
8. Run the project on Tomcat.

---

## Screenshots

### Home Page

(Add Screenshot)

### Product Listing

(Add Screenshot)

### Product Detail Page

(Add Screenshot)

### Cart Page

(Add Screenshot)

### Wishlist Page

(Add Screenshot)

### Profile Page

(Add Screenshot)

---

## Future Enhancements

* Online Payment Gateway Integration
* Admin Dashboard
* Email Notifications
* Product Inventory Management
* Sales Analytics Dashboard
* Order Tracking System

---

## Author

**Dharaneesh R S**

Java Full Stack Developer

---

## License

This project is developed for educational and portfolio purposes.
