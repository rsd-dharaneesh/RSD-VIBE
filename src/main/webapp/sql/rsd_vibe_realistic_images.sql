-- RSD-VIBE: Realistic Product Images Update Script
-- This script updates all products in the database to feature high-quality, realistic fashion photography from Unsplash.

USE rsd_vibe;

-- Update T-Shirts
UPDATE products 
SET image_url = 'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=600&q=80'
WHERE category LIKE '%T-Shirt%';

-- Update Shirts
UPDATE products 
SET image_url = 'https://images.unsplash.com/photo-1596755094514-f87e32f85e23?w=600&q=80'
WHERE category LIKE '%Shirt%' AND category NOT LIKE '%T-Shirt%';

-- Update Jeans / Pants
UPDATE products 
SET image_url = 'https://images.unsplash.com/photo-1542272604-787c3835535d?w=600&q=80'
WHERE category LIKE '%Jean%' OR category LIKE '%Pant%' OR category LIKE '%Trouser%';

-- Update Jackets / Outerwear
UPDATE products 
SET image_url = 'https://images.unsplash.com/photo-1551028719-00167b16eac5?w=600&q=80'
WHERE category LIKE '%Jacket%' OR category LIKE '%Coat%' OR category LIKE '%Hoodie%';

-- Update Shoes / Footwear
UPDATE products 
SET image_url = 'https://images.unsplash.com/photo-1549298916-b41d501d3772?w=600&q=80'
WHERE category LIKE '%Shoe%' OR category LIKE '%Sneaker%' OR category LIKE '%Boot%';

-- Update Accessories (Watches, Sunglasses, etc.)
UPDATE products 
SET image_url = 'https://images.unsplash.com/photo-1524805444758-089113d48a6d?w=600&q=80'
WHERE category LIKE '%Accessory%' OR category LIKE '%Watch%' OR category LIKE '%Glass%';

-- Fallback for any other categories
UPDATE products 
SET image_url = 'https://images.unsplash.com/photo-1505022610485-0249ba5b3675?w=600&q=80'
WHERE image_url IS NULL OR image_url = '' OR image_url LIKE '%placehold.co%';
