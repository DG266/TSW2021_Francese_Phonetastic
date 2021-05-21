DROP SCHEMA IF EXISTS phonetastic_db;
CREATE SCHEMA phonetastic_db;
USE phonetastic_db;

# WARNING: passwords are stored as plaintext!
CREATE TABLE user_info (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    pwd VARCHAR(32) NOT NULL,
	first_name	VARCHAR(255),
    last_name	VARCHAR(255),
    birth_date	DATE,
    sex			CHAR,
    tel_number	VARCHAR(255)
);

ALTER TABLE user_info AUTO_INCREMENT = 100100;

INSERT INTO user_info(email, pwd, first_name, last_name, birth_date, sex, tel_number)
VALUES ("daniele.galloppo@gmail.com", "pippo123", "Daniele", "Galloppo", "2000-01-01", "M", "+39 333 444 5555"),
	   ("ferdinando.esposito@gmail.com", "topolino456", null, null, null, null, null),
       ("antonio.monetti@gmail.com", "pluto789", null, null, null, null, null);

CREATE TABLE roles (
	role_id		INT AUTO_INCREMENT PRIMARY KEY,
    role_name	VARCHAR(255)
);

INSERT INTO roles(role_name)
VALUES ("Admin"),
	   ("Registered");

CREATE TABLE user_roles (
	role_id		INT,
    user_id		INT,
    PRIMARY KEY(role_id, user_id),
	FOREIGN KEY(role_id)
		REFERENCES roles(role_id)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	FOREIGN KEY(user_id)
		REFERENCES user_info(user_id)
		ON UPDATE CASCADE
		ON DELETE CASCADE
);

INSERT INTO user_roles(role_id, user_id)
VALUES (2, 100100),
	   (2, 100101),
       (2, 100102);

CREATE TABLE user_address(
	user_id		INT,
    address_id	INT,
    state		VARCHAR(255) NOT NULL,
    city		VARCHAR(255) NOT NULL,
    province	CHAR(2) NOT NULL,
    cap			VARCHAR(255) NOT NULL,
    address		VARCHAR(255) NOT NULL,
	PRIMARY KEY(user_id, address_id),
    FOREIGN KEY(user_id)
			REFERENCES user_info(user_id)
			ON UPDATE CASCADE
            ON DELETE CASCADE
);

INSERT INTO user_address(user_id, address_id, state, city, province, cap, address)
VALUES (100100, 1, "Italia", "Napoli", "NA", "80135", "Via Giovanni Brombeis 56");

# I wouldn't store credit card information in this database... 
CREATE TABLE payment_method(
	user_id			INT,
    p_method_id		INT,
	card_number 	VARCHAR(255) NOT NULL,
    expiry_date 	DATE NOT NULL,
    cvv				INT NOT NULL,
	PRIMARY KEY(user_id, p_method_id),
    FOREIGN KEY(user_id)
			REFERENCES user_info(user_id)
			ON UPDATE CASCADE
            ON DELETE CASCADE
);

INSERT INTO payment_method(user_id, p_method_id, card_number, expiry_date, cvv)
VALUES (100100, 1, "1234 5678 9123 4567", "2027-01-01", 123);

CREATE TABLE coupon(
	coupon_id			VARCHAR(255) PRIMARY KEY,
    start_date			TIMESTAMP NOT NULL,
    end_date			TIMESTAMP NOT NULL,
	is_active			BOOLEAN DEFAULT(TRUE) NOT NULL,
    discount_percentage	DECIMAL(4,2) NOT NULL,
	CHECK(start_date < end_date)
);

INSERT INTO coupon(coupon_id, start_date, end_date, discount_percentage)
VALUES ("BENVENUTO2021", "2021-01-01", "2021-12-31", 25);

CREATE TABLE category(
	cat_id			INT AUTO_INCREMENT PRIMARY KEY,
    cat_name		VARCHAR(255) NOT NULL,
    superior_cat 	INT,
    FOREIGN KEY(superior_cat)
			REFERENCES category(cat_id)
            ON UPDATE CASCADE
            ON DELETE CASCADE
);

INSERT INTO category(cat_name, superior_cat)
VALUES ("Smartphone", NULL),
	   ("Smartphone nuovi", 1),
	   ("Smartphone usati", 1);

# Product pics will be saved in the file system of the server 
CREATE TABLE product(
	product_id				INT AUTO_INCREMENT PRIMARY KEY,
    product_name			VARCHAR(255) NOT NULL,
    product_description		VARCHAR(1000) NOT NULL,
    quantity				INT NOT NULL,
    price 					DECIMAL(10,2) NOT NULL,
    iva						DECIMAL(4,2) NOT NULL,
    discount				DECIMAL(4,2),	
#   image					BLOB,
    image_path				VARCHAR(1023)
# Possible solution to maintain product information (even if they're discontinued etc.)
#	is_deleted				BOOLEAN DEFAULT(FALSE),    
);

INSERT INTO product(product_name, product_description, quantity, price, iva, discount, image_path)
VALUES ("Xiaomi Redmi Note 5 Pro", "Smartphone", 50, 199.99, 22.0, 0, "./Images/ProductImages/Xiaomi-Redmi-Note-5-Pro.jpg"),
	   ("IPhone X", "Smartphone", 100, 799.99, 22.0, 0, NULL),	
	   ("Xiaomi Redmi Note 8", "Smartphone", 200, 299.99, 22.0, 0, NULL),
	   ("Huawei P10", "Smartphone", 1000, 159.99, 22.0, 0, NULL);

CREATE TABLE product_categories(
	product_id	INT,
    cat_id		INT,
	PRIMARY KEY(product_id, cat_id),
    FOREIGN KEY(product_id)
			REFERENCES product(product_id)
			ON UPDATE CASCADE
			ON DELETE CASCADE,
	FOREIGN KEY(cat_id)
			REFERENCES category(cat_id)
			ON UPDATE CASCADE
            ON DELETE CASCADE
);

# TODO: Set "category" for the new products
INSERT INTO product_categories(product_id, cat_id)
VALUES ((SELECT product_id FROM product WHERE product_name = "Xiaomi Redmi Note 5 Pro"), (SELECT cat_id FROM category WHERE cat_name = "Smartphone")),
	   ((SELECT product_id FROM product WHERE product_name = "Xiaomi Redmi Note 5 Pro"), (SELECT cat_id FROM category WHERE cat_name = "Smartphone nuovi"));

CREATE TABLE order_info(
	order_id 			BIGINT AUTO_INCREMENT PRIMARY KEY,
	total 				DECIMAL(10,2) NOT NULL,
    coupon_id			VARCHAR(255),
#	state				CHAR NOT NULL,		# Might be "S" for "shipped", "N" for "not shipped", etc.
    creation_date		TIMESTAMP NOT NULL,
    last_update_date	TIMESTAMP NOT NULL,
    customer_id			INT,
    FOREIGN KEY(coupon_id)
			REFERENCES coupon(coupon_id)
            ON UPDATE CASCADE
            ON DELETE NO ACTION,
    FOREIGN KEY(customer_id)
			REFERENCES user_info(user_id)
            ON UPDATE CASCADE
            ON DELETE SET NULL
);

ALTER TABLE order_info AUTO_INCREMENT= 200200;

INSERT INTO order_info(total, coupon_id, creation_date, last_update_date, customer_id)
VALUES(199.99, NULL, CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP(), 100100);


CREATE TABLE payment_details(
	order_id		BIGINT PRIMARY KEY,
    state			CHAR NOT NULL,			# Very similar to order_info(state): "P" for "paid", "N" for "not paid", etc.
    payment_date	TIMESTAMP,
    user_id			INT,
    p_method_id		INT,
    FOREIGN KEY(order_id)
			REFERENCES order_info(order_id)
            ON UPDATE CASCADE
            ON DELETE CASCADE,
    FOREIGN KEY(user_id, p_method_id)
			REFERENCES payment_method(user_id, p_method_id)
            ON UPDATE CASCADE
            ON DELETE SET NULL
);	

INSERT INTO payment_details(order_id, state, payment_date, user_id, p_method_id)
VALUES (200200, "G", CURRENT_TIMESTAMP(), 100100, 1);

CREATE TABLE order_composition(
	order_id		BIGINT,
    product_id		INT,
    quantity		INT NOT NULL,
    price			DECIMAL(10,2) NOT NULL,
    iva				DECIMAL(4,2) NOT NULL,
    discount		DECIMAL(4,2),
    PRIMARY KEY(order_id, product_id),
    FOREIGN KEY(order_id)
			REFERENCES order_info(order_id)
            ON UPDATE CASCADE
            ON DELETE CASCADE,
	FOREIGN KEY(product_id)
			REFERENCES product(product_id)
            ON UPDATE CASCADE
            ON DELETE NO ACTION					# TODO: find a solution to the products deletion problem
);

INSERT INTO order_composition(order_id, product_id, quantity, price, iva, discount)
VALUES (200200, (SELECT product_id FROM product WHERE product_name = "Xiaomi Redmi Note 5 Pro"), 
        1, (SELECT price FROM product P WHERE product_id = P.product_id AND P.product_name = "Xiaomi Redmi Note 5 Pro"), 22.0, 0); 

CREATE TABLE review(
	review_id		INT AUTO_INCREMENT PRIMARY KEY,
	user_id			INT,
    product_id		INT,
    rev_text		VARCHAR(1000),
    rev_date		TIMESTAMP NOT NULL,
    score			DECIMAL(2,1) NOT NULL CHECK(score >= 0 AND score <= 5.0),
    FOREIGN KEY(user_id)
			REFERENCES user_info(user_id)
            ON UPDATE CASCADE
            ON DELETE SET NULL,
	FOREIGN KEY(product_id)
			REFERENCES product(product_id)
            ON UPDATE CASCADE
            ON DELETE CASCADE
);

INSERT INTO review(user_id, product_id, rev_text, rev_date, score)
VALUES (100100, (SELECT product_id FROM product WHERE product_name = "Xiaomi Redmi Note 5 Pro"), 
		"Molto soddisfatto.", CURRENT_TIMESTAMP(), 5.0);
