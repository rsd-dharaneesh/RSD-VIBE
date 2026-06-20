import random
import os

categories = {
    "Shirts": [
        ("Formal", "shirt,formal,mens"),
        ("Casual", "shirt,casual,mens"),
        ("Party Wear", "shirt,party,mens")
    ],
    "Pants": [
        ("Formal", "pants,formal,mens"),
        ("Casual", "pants,casual,mens"),
        ("Jean", "jeans,mens"),
        ("Cargo", "cargo,pants,mens"),
        ("Denim", "denim,pants,mens"),
        ("Polo Fit", "chinos,pants,mens")
    ],
    "Jackets": [
        ("Leather", "leather,jacket,mens"),
        ("Bomber", "bomber,jacket,mens"),
        ("Denim", "denim,jacket,mens")
    ],
    "T-Shirts": [
        ("Graphic", "tshirt,graphic,mens"),
        ("Plain", "tshirt,plain,mens"),
        ("Polo", "polo,tshirt,mens")
    ]
}

brands = ["RSD Premium", "Urban Monkey", "Snitch", "Zara", "H&M", "Myntra Essentials", "AJIO Style", "Levis", "Wrogn", "Roadster"]
colors_list = ["Black", "White", "Navy Blue", "Olive Green", "Maroon", "Grey", "Beige", "Brown"]
sizes_list = ["S,M,L,XL", "M,L,XL,XXL", "S,M,L", "L,XL,XXL"]

sql_content = "USE rsd_vibe;\n\n"
sql_content += "TRUNCATE TABLE products;\n\n" # TRUNCATE to avoid mixing with old data or duplicating? Wait, user said "you just changed what the img i have implemented and i don't want that" - meaning they WANT their old products untouched! So I should NOT truncate. I will just INSERT.

sql_content = "USE rsd_vibe;\n\n"

insert_template = """INSERT INTO products (product_name, brand, price, original_price, discount_percentage, category, description, image_url, stock_quantity, rating, reviews_count, sizes, colors, is_new_arrival, is_best_seller, is_trending) VALUES 
('{}', '{}', {}, {}, {}, '{}', '{}', '{}', {}, {}, {}, '{}', '{}', {}, {}, {});
"""

product_id_counter = 1000
image_seed = 1

for main_cat, subcats in categories.items():
    for subcat_name, search_tags in subcats:
        for i in range(1, 16): # 15 items per subcategory
            
            brand = random.choice(brands)
            product_name = f"{brand} Men's {subcat_name} {main_cat} - Edition {i}"
            
            original_price = random.randint(1500, 5000)
            discount = random.choice([0, 10, 20, 30, 40, 50, 60])
            price = int(original_price * (1 - discount/100))
            
            # Combine main and sub category for DB, e.g. "Shirts - Formal"
            category_val = f"{main_cat} - {subcat_name}"
            
            desc = f"Premium quality {subcat_name.lower()} {main_cat.lower()} designed for the modern man. Experience unmatched comfort and style with {brand}."
            
            image_url = f"https://loremflickr.com/500/600/{search_tags}?lock={image_seed}"
            image_seed += 1
            
            stock = random.randint(10, 100)
            rating = round(random.uniform(3.5, 5.0), 1)
            reviews_count = random.randint(5, 300)
            sizes = random.choice(sizes_list)
            colors = random.choice(colors_list) + "," + random.choice(colors_list)
            
            is_new = random.choice(['TRUE', 'FALSE'])
            is_best = random.choice(['TRUE', 'FALSE'])
            is_trend = random.choice(['TRUE', 'FALSE'])
            
            sql_content += insert_template.format(
                product_name.replace("'", "''"), 
                brand.replace("'", "''"), 
                price, 
                original_price, 
                discount, 
                category_val, 
                desc.replace("'", "''"), 
                image_url, 
                stock, 
                rating, 
                reviews_count, 
                sizes, 
                colors, 
                is_new, 
                is_best, 
                is_trend
            )

with open(r"c:\Users\WELCOME\eclipse-workspace\RSD-VIBE\src\main\webapp\sql\rsd_vibe_massive_catalog.sql", "w") as f:
    f.write(sql_content)

print("SQL script generated successfully!")
