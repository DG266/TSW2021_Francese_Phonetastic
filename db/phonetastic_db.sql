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
VALUES ("admin@phonetastic.it", "admin", "Franco", "Armani", null, null, null),
	   ("daniele.galloppo@gmail.com", "pippo123", "Daniele", "Galloppo", "2000-01-01", "M", "+39 333 444 5555"),
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
VALUES (1, 100100),
	   (2, 100101),
       (2, 100102),
       (2, 100103);

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
VALUES (100101, 1, "Italia", "Napoli", "NA", "80135", "Via Giovanni Brombeis 56");

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
VALUES (100101, 1, "1234 5678 9123 4567", "2027-01-01", 123);

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
	   ("Smartphone usati", 1),
       ("Smartwatch", NULL);

# Product pics will be saved in the file system of the server 
CREATE TABLE product (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    product_manufacturer VARCHAR(255) NOT NULL,
    product_description VARCHAR(1000) NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(13, 2) NOT NULL,
    iva DECIMAL(5 , 2 ) NOT NULL,
    discount DECIMAL(5 , 2 ),
	insertion_date		TIMESTAMP NOT NULL,
    last_update_date	TIMESTAMP NOT NULL,
    image_path VARCHAR(1023),
    is_deleted BOOLEAN NOT NULL
);

INSERT INTO product(product_name, product_manufacturer, product_description, quantity, price, iva, discount, insertion_date, last_update_date, image_path, is_deleted)
VALUES ("Xiaomi Redmi Note 5 Pro", "Xiaomi", "Qui andrà la descrizione.", 50, 199.99, 22.0, 0, TIMESTAMP("2021-04-01",  "00:00:00"), TIMESTAMP("2021-04-01",  "00:00:00"),  ".\\resources\\images\\ProductImages\\Xiaomi-Redmi-Note-5-Pro.png", false),
	   ("Apple IPhone X", "Apple", "Qui andrà la descrizione.", 100, 799.99, 22.0, 0, TIMESTAMP("2021-04-02",  "00:00:00"), TIMESTAMP("2021-04-02",  "00:00:00"), ".\\resources\\images\\ProductImages\\Apple-IPhone-X.png", false),	
	   ("Xiaomi Redmi Note 8", "Xiaomi", "Qui andrà la descrizione.", 200, 299.99, 22.0, 0, TIMESTAMP("2021-04-03",  "00:00:00"), TIMESTAMP("2021-04-03",  "00:00:00"),  ".\\resources\\images\\ProductImages\\Xiaomi-Redmi-Note-8.png", false),
	   ("Huawei P10 Lite", "Huawei", "Qui andrà la descrizione.", 1000, 159.99, 22.0, 0, TIMESTAMP("2021-04-04",  "00:00:00"), TIMESTAMP("2021-04-04",  "00:00:00"), ".\\resources\\images\\ProductImages\\Huawei-P10-Lite.png", false),
       ("Apple Watch Series 6", "Apple", "Qui andrà la descrizione.", 1000, 430.99, 22.0, 0, TIMESTAMP("2021-04-05",  "00:00:00"), TIMESTAMP("2021-04-05",  "00:00:00"), ".\\resources\\images\\ProductImages\\Apple-Watch-Series-6.png", false);

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
	   ((SELECT product_id FROM product WHERE product_name = "Xiaomi Redmi Note 5 Pro"), (SELECT cat_id FROM category WHERE cat_name = "Smartphone nuovi")),
	   ((SELECT product_id FROM product WHERE product_name = "Apple Iphone X"), (SELECT cat_id FROM category WHERE cat_name = "Smartphone")),
       ((SELECT product_id FROM product WHERE product_name = "Xiaomi Redmi Note 8"), (SELECT cat_id FROM category WHERE cat_name = "Smartphone")),
       ((SELECT product_id FROM product WHERE product_name = "Huawei P10 Lite"), (SELECT cat_id FROM category WHERE cat_name = "Smartphone")),
	   ((SELECT product_id FROM product WHERE product_name = "Apple Watch Series 6"), (SELECT cat_id FROM category WHERE cat_name = "Smartwatch"));

CREATE TABLE order_info(
	order_id 			BIGINT AUTO_INCREMENT PRIMARY KEY,
	total 				DECIMAL(10,2) NOT NULL,
#	state				CHAR NOT NULL,		# Might be "S" for "shipped", "N" for "not shipped", etc.
    creation_date		TIMESTAMP NOT NULL,
    last_update_date	TIMESTAMP NOT NULL,
    customer_id			INT,
    address_id			INT,
    p_method_id			INT,			
    FOREIGN KEY(customer_id)
			REFERENCES user_info(user_id)
            ON UPDATE CASCADE
            ON DELETE NO ACTION,
	FOREIGN KEY(customer_id, address_id)
		REFERENCES user_address(user_id, address_id)
		ON UPDATE CASCADE
		ON DELETE NO ACTION,
	FOREIGN KEY(customer_id, p_method_id)
		REFERENCES payment_method(user_id, p_method_id)
		ON UPDATE CASCADE
		ON DELETE NO ACTION
);

ALTER TABLE order_info AUTO_INCREMENT= 200200;

INSERT INTO order_info(total, creation_date, last_update_date, customer_id, address_id, p_method_id)
VALUES(243.99, CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP(), 100101, 1, 1);

CREATE TABLE order_composition(
	order_id		BIGINT,
    product_id		INT,
    quantity		INT NOT NULL,
    price			DECIMAL(13, 2) NOT NULL,
    iva				DECIMAL(5,2) NOT NULL,
    discount		DECIMAL(5,2),
    PRIMARY KEY(order_id, product_id),
    FOREIGN KEY(order_id)
			REFERENCES order_info(order_id)
            ON UPDATE CASCADE
            ON DELETE CASCADE,
	FOREIGN KEY(product_id)
			REFERENCES product(product_id)
            ON UPDATE CASCADE
            ON DELETE NO ACTION					
);

INSERT INTO order_composition(order_id, product_id, quantity, price, iva, discount)
VALUES (200200, (SELECT product_id FROM product WHERE product_name = "Xiaomi Redmi Note 5 Pro"), 
        1, (SELECT price FROM product P WHERE product_id = P.product_id AND P.product_name = "Xiaomi Redmi Note 5 Pro"), 22.0, 0); 
