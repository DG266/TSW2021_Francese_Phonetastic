USE phonetastic_db;

INSERT INTO user_info(email, pwd, category)
VALUES ("daniele.galloppo@gmail.com", "pippo123", "REG"),
	   ("ferdinando.esposito@gmail.com", "ciao321", "REG"),
       ("antonio.monetti@gmail.com", "henlo666", "REG");
       
INSERT INTO user_personal_info(user_id, first_name, last_name, birth_date, sex, tel_number)
VALUES (1, "Daniele", "Galloppo", "2000-01-01", "M", "+39 333 444 5555");

INSERT INTO user_address(user_id, address_id, state, city, province, cap, address)
VALUES (1, 1, "Italia", "Napoli", "NA", "80135", "Via Giovanni Brombeis 56");

INSERT INTO payment_method(user_id, p_method_id, card_number, exp_date)
VALUES (1, 1, "1234 5678 9123 4567", "2027-01-01");

INSERT INTO coupon(coupon_id, start_date, end_date, discount_percentage)
VALUES ("BENVENUTO2021", "2021-01-01", "2021-12-31", 25);

INSERT INTO category(cat_name, superior_cat)
VALUES ("Smartphone", NULL),
	   ("Smartphone nuovi", 1),
	   ("Smartphone usati", 1);

INSERT INTO product(product_name, product_description, quantity, price, iva, discount)
VALUES ("Xiaomi Redmi Note 5 Pro", "Smartphone", 50, 199.99, 22.0, 0);

INSERT INTO product_categories(product_id, cat_id)
VALUES ((SELECT product_id FROM product WHERE product_name = "Xiaomi Redmi Note 5 Pro"), (SELECT cat_id FROM category WHERE cat_name = "Smartphone")),
	   ((SELECT product_id FROM product WHERE product_name = "Xiaomi Redmi Note 5 Pro"), (SELECT cat_id FROM category WHERE cat_name = "Smartphone nuovi"));

INSERT INTO order_info(coupon_id, state, creation_date, last_update_date, customer_id)
VALUES(NULL, "P", CURRENT_DATE(), CURRENT_DATE(), 1);

INSERT INTO payment_details(order_id, state, payment_date, user_id, p_method_id)
VALUES (1, "G", CURRENT_DATE(), 1, 1);

INSERT INTO order_composition(order_id, product_id, quantity, price, iva, discount)
VALUES (1, (SELECT product_id FROM product WHERE product_name = "Xiaomi Redmi Note 5 Pro"), 
        1, (SELECT price FROM product P WHERE product_id = P.product_id), 22.0, 0);

INSERT INTO review(user_id, product_id, rev_text, rev_date, score)
VALUES (1, (SELECT product_id FROM product WHERE product_name = "Xiaomi Redmi Note 5 Pro"), 
		"Molto soddisfatto.", CURRENT_DATE(), 5.0);
