-- RSD-VIBE Premium Men's Fashion E-Commerce Schema Upgrade
-- Run this script in your rsd_vibe database

-- Products table upgrades
ALTER TABLE products ADD COLUMN discount_percentage DOUBLE DEFAULT 0;
ALTER TABLE products ADD COLUMN rating DOUBLE DEFAULT 0;
ALTER TABLE products ADD COLUMN reviews_count INT DEFAULT 0;
ALTER TABLE products ADD COLUMN original_price DOUBLE DEFAULT 0;
ALTER TABLE products ADD COLUMN sizes VARCHAR(100) DEFAULT 'S,M,L,XL,XXL';
ALTER TABLE products ADD COLUMN colors VARCHAR(200) DEFAULT '';
ALTER TABLE products ADD COLUMN image_url_2 VARCHAR(500) DEFAULT '';
ALTER TABLE products ADD COLUMN image_url_3 VARCHAR(500) DEFAULT '';
ALTER TABLE products ADD COLUMN image_url_4 VARCHAR(500) DEFAULT '';
ALTER TABLE products ADD COLUMN is_new_arrival BOOLEAN DEFAULT FALSE;
ALTER TABLE products ADD COLUMN is_best_seller BOOLEAN DEFAULT FALSE;
ALTER TABLE products ADD COLUMN is_trending BOOLEAN DEFAULT FALSE;
ALTER TABLE products ADD COLUMN created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

-- Make sure brand exists if it wasn't there before
-- (It might already exist in your schema, ignore if it throws duplicate column error)
-- ALTER TABLE products ADD COLUMN brand VARCHAR(100) DEFAULT ''; 

-- Users table upgrades
ALTER TABLE users ADD COLUMN profile_photo VARCHAR(500) DEFAULT '';
ALTER TABLE users ADD COLUMN created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

-- Orders table upgrades
ALTER TABLE orders ADD COLUMN order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE orders ADD COLUMN status VARCHAR(50) DEFAULT 'Processing';
ALTER TABLE orders ADD COLUMN payment_method VARCHAR(50) DEFAULT 'COD';
ALTER TABLE orders ADD COLUMN discount_amount DOUBLE DEFAULT 0;
ALTER TABLE orders ADD COLUMN delivery_charge DOUBLE DEFAULT 0;
ALTER TABLE orders ADD COLUMN coupon_code VARCHAR(50) DEFAULT '';

-- order_items size and color
ALTER TABLE order_items ADD COLUMN size VARCHAR(20) DEFAULT '';
ALTER TABLE order_items ADD COLUMN color VARCHAR(50) DEFAULT '';

-- NEW TABLES

-- 1. Wishlist Table
CREATE TABLE IF NOT EXISTS wishlist (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    product_id INT NOT NULL,
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE,
    UNIQUE KEY unique_wishlist (user_id, product_id)
);

-- 2. Reviews Table
CREATE TABLE IF NOT EXISTS reviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    product_id INT NOT NULL,
    rating DOUBLE NOT NULL,
    review_text TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE
);

-- 3. Addresses Table
CREATE TABLE IF NOT EXISTS addresses (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    address_line TEXT NOT NULL,
    city VARCHAR(50),
    state VARCHAR(50),
    pincode VARCHAR(20),
    is_default BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- 4. Coupons Table
CREATE TABLE IF NOT EXISTS coupons (
    coupon_id INT AUTO_INCREMENT PRIMARY KEY,
    code VARCHAR(50) UNIQUE NOT NULL,
    discount_type VARCHAR(20) NOT NULL, -- 'PERCENTAGE' or 'FLAT'
    discount_value DOUBLE NOT NULL,
    min_order DOUBLE DEFAULT 0,
    max_discount DOUBLE DEFAULT 0,
    valid_until TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE
);

-- 5. Recently Viewed Table
CREATE TABLE IF NOT EXISTS recently_viewed (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    product_id INT NOT NULL,
    viewed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE,
    UNIQUE KEY unique_view (user_id, product_id)
);

-- 6. Notifications Table
CREATE TABLE IF NOT EXISTS notifications (
    notification_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    title VARCHAR(100) NOT NULL,
    message TEXT NOT NULL,
    is_read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- 7. Product Images Table
CREATE TABLE IF NOT EXISTS product_images (
    image_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    image_url VARCHAR(500) NOT NULL,
    is_primary BOOLEAN DEFAULT FALSE,
    sort_order INT DEFAULT 0,
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE
);
