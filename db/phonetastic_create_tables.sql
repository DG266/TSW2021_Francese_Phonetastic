DROP SCHEMA IF EXISTS phonetastic_db;
CREATE SCHEMA phonetastic_db;
USE phonetastic_db;

# WARNING: passwords are stored as plaintext!
CREATE TABLE user_info (
    user_id INT AUTO_INCREMENT,
    email VARCHAR(255) UNIQUE NOT NULL,
    pwd VARCHAR(32) NOT NULL,
	first_name	VARCHAR(255),
    last_name	VARCHAR(255),
    birth_date	DATE,
    sex			CHAR,
    tel_number	VARCHAR(255),
    PRIMARY KEY (user_id)
);

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

# I wouldn't store credit card information in this database... 
CREATE TABLE payment_method(
	user_id		INT,
    p_method_id	INT,
	card_number VARCHAR(255) NOT NULL,
    exp_date 	DATE NOT NULL,
	PRIMARY KEY(user_id, p_method_id),
    FOREIGN KEY(user_id)
			REFERENCES user_info(user_id)
			ON UPDATE CASCADE
            ON DELETE CASCADE
);

CREATE TABLE coupon(
	coupon_id			VARCHAR(255),
    start_date			TIMESTAMP NOT NULL,
    end_date			TIMESTAMP NOT NULL,
	is_active			BOOLEAN DEFAULT(TRUE) NOT NULL,
    discount_percentage	DECIMAL(4,2) NOT NULL,
	CHECK(start_date < end_date),
	PRIMARY KEY(coupon_id)
);

CREATE TABLE category(
	cat_id			INT AUTO_INCREMENT,
    cat_name		VARCHAR(255) NOT NULL,
    superior_cat 	INT,
    PRIMARY KEY(cat_id),
    FOREIGN KEY(superior_cat)
			REFERENCES category(cat_id)
            ON UPDATE CASCADE
            ON DELETE CASCADE
);

# Product pics will be saved in the file system of the server 
CREATE TABLE product(
	product_id				INT AUTO_INCREMENT,
    product_name			VARCHAR(255) NOT NULL,
    product_description		VARCHAR(1000) NOT NULL,
    quantity				INT NOT NULL,
    price 					DECIMAL(10,2) NOT NULL,
    iva						DECIMAL(4,2) NOT NULL,
    discount				DECIMAL(4,2),	
#   image					BLOB,
# Possible solution to maintain product information (even if they're discontinued etc.)
#	is_deleted				BOOLEAN DEFAULT(FALSE),    
	PRIMARY KEY(product_id)
);

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

CREATE TABLE order_info(
	order_id 			BIGINT AUTO_INCREMENT,
	total 				DECIMAL(10,2) NOT NULL,
    coupon_id			VARCHAR(255),
#	state				CHAR NOT NULL,		# Might be "S" for "shipped", "N" for "not shipped", etc.
    creation_date		TIMESTAMP NOT NULL,
    last_update_date	TIMESTAMP NOT NULL,
    customer_id			INT,
	PRIMARY KEY(order_id),
    FOREIGN KEY(coupon_id)
			REFERENCES coupon(coupon_id)
            ON UPDATE CASCADE
            ON DELETE NO ACTION,
    FOREIGN KEY(customer_id)
			REFERENCES user_info(user_id)
            ON UPDATE CASCADE
            ON DELETE SET NULL
);


CREATE TABLE payment_details(
	order_id		BIGINT,
    state			CHAR NOT NULL,			# Very similar to order_info(state): "P" for "paid", "N" for "not paid", etc.
    payment_date	TIMESTAMP,
    user_id			INT,
    p_method_id		INT,
    PRIMARY KEY(order_id),
    FOREIGN KEY(order_id)
			REFERENCES order_info(order_id)
            ON UPDATE CASCADE
            ON DELETE CASCADE,
    FOREIGN KEY(user_id, p_method_id)
			REFERENCES payment_method(user_id, p_method_id)
            ON UPDATE CASCADE
            ON DELETE SET NULL
);	

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

CREATE TABLE review(
	review_id		INT AUTO_INCREMENT,
	user_id			INT,
    product_id		INT,
    rev_text		VARCHAR(1000),
    rev_date		TIMESTAMP NOT NULL,
    score			DECIMAL(2,1) NOT NULL CHECK(score >= 0 AND score <= 5.0),
    PRIMARY KEY(review_id),
    FOREIGN KEY(user_id)
			REFERENCES user_info(user_id)
            ON UPDATE CASCADE
            ON DELETE SET NULL,
	FOREIGN KEY(product_id)
			REFERENCES product(product_id)
            ON UPDATE CASCADE
            ON DELETE CASCADE
);

# CUSTOM AUTO_INCREMENT VALUES 
ALTER TABLE user_info AUTO_INCREMENT = 100100;
ALTER TABLE order_info AUTO_INCREMENT= 200200;
# MORE...
