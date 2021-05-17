USE phonetastic_db;

INSERT INTO user_info(email, pwd, first_name, last_name, birth_date, sex, tel_number)
VALUES ("daniele.galloppo@gmail.com", "pippo123", "Daniele", "Galloppo", "2000-01-01", "M", "+39 333 444 5555"),
	   ("ferdinando.esposito@gmail.com", "topolino456", null, null, null, null, null),
       ("antonio.monetti@gmail.com", "pluto789", null, null, null, null, null);

INSERT INTO user_address(user_id, address_id, state, city, province, cap, address)
VALUES (100100, 1, "Italia", "Napoli", "NA", "80135", "Via Giovanni Brombeis 56");

INSERT INTO payment_method(user_id, p_method_id, card_number, exp_date)
VALUES (100100, 1, "1234 5678 9123 4567", "2027-01-01");

INSERT INTO coupon(coupon_id, start_date, end_date, discount_percentage)
VALUES ("BENVENUTO2021", "2021-01-01", "2021-12-31", 25);

INSERT INTO category(cat_name, superior_cat)
VALUES ("Smartphone", NULL),
	   ("Smartphone nuovi", 1),
	   ("Smartphone usati", 1);

INSERT INTO product(product_name, product_description, quantity, price, iva, discount)
VALUES ("Xiaomi Redmi Note 5 Pro", "Smartphone", 50, 199.99, 22.0, 0),
	   ("IPhone X", "Smartphone", 100, 799.99, 22.0, 0),	
	   ("Xiaomi Redmi Note 8", "Smartphone", 200, 299.99, 22.0, 0),
	   ("Huawei P10", "Smartphone", 1000, 159.99, 22.0, 0);

INSERT INTO product_categories(product_id, cat_id)
VALUES ((SELECT product_id FROM product WHERE product_name = "Xiaomi Redmi Note 5 Pro"), (SELECT cat_id FROM category WHERE cat_name = "Smartphone")),
	   ((SELECT product_id FROM product WHERE product_name = "Xiaomi Redmi Note 5 Pro"), (SELECT cat_id FROM category WHERE cat_name = "Smartphone nuovi"));

# TODO: Set "category" for the new products

INSERT INTO order_info(total, coupon_id, creation_date, last_update_date, customer_id)
VALUES(199.99, NULL, CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP(), 100100);

INSERT INTO payment_details(order_id, state, payment_date, user_id, p_method_id)
VALUES (200200, "G", CURRENT_TIMESTAMP(), 100100, 1);

INSERT INTO order_composition(order_id, product_id, quantity, price, iva, discount)
VALUES (200200, (SELECT product_id FROM product WHERE product_name = "Xiaomi Redmi Note 5 Pro"), 
        1, (SELECT price FROM product P WHERE product_id = P.product_id AND P.product_name = "Xiaomi Redmi Note 5 Pro"), 22.0, 0);

INSERT INTO review(user_id, product_id, rev_text, rev_date, score)
VALUES (100100, (SELECT product_id FROM product WHERE product_name = "Xiaomi Redmi Note 5 Pro"), 
		"Molto soddisfatto.", CURRENT_TIMESTAMP(), 5.0);
