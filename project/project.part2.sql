------------
DROP TABLE customer CASCADE;
DROP TABLE account CASCADE;
DROP TABLE brand CASCADE;
DROP TABLE c_phone_number CASCADE;
DROP TABLE c_address CASCADE;
DROP TABLE have_acc CASCADE;
DROP TABLE makes CASCADE;
DROP TABLE orders CASCADE;
DROP TABLE products CASCADE;
DROP TABLE sales CASCADE;
DROP TABLE store CASCADE;
DROP TABLE v_phone_number CASCADE;
DROP TABLE vendor CASCADE;
DROP TABLE contains CASCADE;
DROP TABLE descriptions CASCADE;
------------

CREATE TABLE v_phone_number (
	phone_id INT,
	phone VARCHAR(20),
	PRIMARY KEY (phone_id)
);

CREATE TABLE vendor (
	v_id INT,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	phone_id INTEGER,
	PRIMARY KEY (v_id),
	FOREIGN KEY (phone_id) REFERENCES v_phone_number
);

CREATE TABLE brand (
	brand_id INT,
	name VARCHAR(50),
	PRIMARY KEY (brand_id)
);

CREATE TABLE descriptions (
    description_id INT,
    description TEXT,
    PRIMARY KEY (description_id)
);

CREATE TABLE products (
	UPC_code VARCHAR(12),
	description_id INT,
	price INT,
	name VARCHAR(50),
	p_amount INT,
	arrival DATE,
	packaging VARCHAR(50),
	size INT,
	v_id INT,
	brand_id INT,
	PRIMARY KEY (UPC_code),
	FOREIGN KEY (v_id) REFERENCES vendor,
	FOREIGN KEY (brand_id) REFERENCES brand,
	FOREIGN KEY (description_id) REFERENCES descriptions
);

CREATE TABLE orders (
	order_id INT,
	date TIMESTAMP,
	UPC_code VARCHAR(12),
	amount INT,
	brand_id INT,
	PRIMARY KEY (order_id),
	FOREIGN KEY (UPC_code) REFERENCES products,
	FOREIGN KEY (brand_id) REFERENCES brand
);

CREATE TABLE customer (
	c_id INT,
	last_name VARCHAR(50),
	first_name VARCHAR(50),
	pay_method VARCHAR(20),
	PRIMARY KEY (c_id)
);

CREATE TABLE makes (
    c_id INT,
    order_id INT,
    FOREIGN KEY (c_id) REFERENCES customer,
    FOREIGN KEY (order_id) REFERENCES orders
);

CREATE TABLE c_phone_number (
	phone_id INT,
	phone VARCHAR(50),
	PRIMARY KEY (phone_id)
);

create table c_address (
	address_id INT,
	address VARCHAR(50),
	PRIMARY KEY (address_id)
);

CREATE TABLE account (
	user_name VARCHAR(20),
	password VARCHAR(15),
	phone_id INT,
	address_id INT,
	order_id INT,
	pay_method VARCHAR(20),
	PRIMARY KEY (user_name),
	FOREIGN KEY (order_id) REFERENCES orders,
	FOREIGN KEY (phone_id) REFERENCES c_phone_number,
	FOREIGN KEY (address_id) REFERENCES c_address
);

CREATE TABLE store (
	store_id INT,
	open_time TIME,
	close_time TIME,
	name VARCHAR(50),
	street VARCHAR(50),
	city VARCHAR(50),
	PRIMARY KEY (store_id)
);

CREATE TABLE sales (
    store_id INT,
    UPC_code VARCHAR(12),
    FOREIGN KEY (store_id) REFERENCES store,
    FOREIGN KEY (UPC_code) REFERENCES products
);

CREATE TABLE have_acc (
    c_id INT,
    user_name VARCHAR(50),
    FOREIGN KEY (c_id) REFERENCES customer,
    FOREIGN KEY (user_name) REFERENCES account
);

CREATE TABLE contains (
    order_id INT,
    UPC_code VARCHAR(12),
    FOREIGN KEY (order_id) REFERENCES orders,
    FOREIGN KEY (UPC_code) REFERENCES products
);