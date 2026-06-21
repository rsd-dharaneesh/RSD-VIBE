-- RSD-VIBE Premium Men's Fashion E-Commerce Seed Data
-- Run this script after rsd_vibe_schema_upgrade.sql

-- Insert Sample Coupons
INSERT INTO coupons (code, discount_type, discount_value, min_order, max_discount, valid_until, is_active) VALUES 
('WELCOME10', 'PERCENTAGE', 10, 0, 500, '2026-12-31 23:59:59', TRUE),
('FASHION20', 'PERCENTAGE', 20, 999, 1000, '2026-12-31 23:59:59', TRUE),
('SUMMER30', 'PERCENTAGE', 30, 1499, 1500, '2026-12-31 23:59:59', TRUE),
('VIBE50', 'FLAT', 50, 0, 50, '2026-12-31 23:59:59', TRUE),
('MEGA500', 'FLAT', 500, 2999, 500, '2026-12-31 23:59:59', TRUE);

-- Insert Sample Products (A subset of products to populate the catalog)
-- Using placeholder images from placehold.co

INSERT INTO products (product_name, brand, category, price, original_price, discount_percentage, rating, reviews_count, stock, description, image_url, image_url_2, image_url_3, is_trending, is_new_arrival, is_best_seller, sizes, colors) VALUES
-- Oversized T-Shirts
('Snitch Oversized Graphic T-Shirt', 'Snitch', 'Oversized T-Shirts', 799, 1499, 46.7, 4.5, 120, 50, 'Premium cotton blend oversized t-shirt with front and back graphic print.', 'https://placehold.co/400x500/111111/FFFFFF?text=Snitch+Oversized', 'https://placehold.co/400x500/333333/FFFFFF?text=Back+View', 'https://placehold.co/400x500/555555/FFFFFF?text=Detail+View', TRUE, TRUE, FALSE, 'M,L,XL,XXL', 'Black,White'),
('Bewakoof Marvel Oversized Tee', 'Bewakoof', 'Oversized T-Shirts', 699, 1299, 46.1, 4.3, 85, 30, 'Official Marvel merchandise oversized t-shirt.', 'https://placehold.co/400x500/e23636/FFFFFF?text=Marvel+Oversized', '', '', FALSE, TRUE, TRUE, 'S,M,L,XL', 'Red,Black'),

-- Casual Shirts
('H&M Relaxed Fit Linen Shirt', 'H&M', 'Casual Shirts', 1499, 2499, 40, 4.7, 210, 40, 'Breathable 100% linen shirt for a relaxed summer look.', 'https://placehold.co/400x500/f4f1ea/333333?text=H%26M+Linen+Shirt', '', '', TRUE, FALSE, TRUE, 'S,M,L,XL,XXL', 'Beige,White,Navy'),
('Zara Checkered Overshirt', 'Zara', 'Casual Shirts', 2990, 4990, 40, 4.6, 150, 25, 'Heavyweight flannel overshirt with check pattern.', 'https://placehold.co/400x500/22422c/FFFFFF?text=Zara+Overshirt', '', '', TRUE, TRUE, FALSE, 'M,L,XL', 'Green,Red'),

-- Jeans & Pants
('Levi''s 511 Slim Fit Jeans', 'Levi''s', 'Slim Fit Jeans', 2599, 4299, 39.5, 4.8, 450, 60, 'Classic slim fit jeans that sit below the waist.', 'https://placehold.co/400x500/1a365d/FFFFFF?text=Levis+511', '', '', FALSE, FALSE, TRUE, '30,32,34,36', 'Dark Blue,Light Blue'),
('Snitch Baggy Parachute Pants', 'Snitch', 'Baggy Jeans', 1699, 2999, 43.3, 4.4, 90, 35, 'Trendy parachute pants with adjustable toggle cuffs.', 'https://placehold.co/400x500/4a5568/FFFFFF?text=Parachute+Pants', '', '', TRUE, TRUE, FALSE, '28,30,32,34', 'Olive,Grey,Black'),

-- Jackets & Hoodies
('Nike Essential Fleece Hoodie', 'Nike', 'Hoodies', 3495, 4995, 30, 4.9, 320, 20, 'Premium brushed-back fleece hoodie for ultimate comfort.', 'https://placehold.co/400x500/cbd5e0/111111?text=Nike+Hoodie', '', '', FALSE, TRUE, TRUE, 'M,L,XL,XXL', 'Grey,Black'),
('Zara Faux Leather Bomber', 'Zara', 'Bomber Jackets', 4990, 7990, 37.5, 4.5, 110, 15, 'Sleek faux leather bomber jacket with ribbed trims.', 'https://placehold.co/400x500/111111/FFFFFF?text=Zara+Bomber', '', '', TRUE, FALSE, FALSE, 'M,L,XL', 'Black'),

-- Accessories
('Fastrack Aviator Sunglasses', 'Fastrack', 'Sunglasses', 899, 1599, 43.7, 4.2, 280, 45, 'UV protected aviator sunglasses with metal frame.', 'https://placehold.co/400x500/e2e8f0/111111?text=Fastrack+Aviator', '', '', FALSE, FALSE, TRUE, 'One Size', 'Black,Gold'),
('Urban Monkey Signature Cap', 'Urban Monkey', 'Caps', 999, 1499, 33.3, 4.6, 175, 50, 'Streetwear essential signature logo baseball cap.', 'https://placehold.co/400x500/2d3748/FFFFFF?text=UM+Cap', '', '', TRUE, TRUE, FALSE, 'One Size', 'Black,Olive');
