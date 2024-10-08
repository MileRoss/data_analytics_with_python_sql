CREATE DATABASE IF NOT EXISTS lab_mysql;
USE lab_mysql;

-- Drop and create 'cars' table
DROP TABLE IF EXISTS cars;
CREATE TABLE IF NOT EXISTS cars (
    ID INT NOT NULL AUTO_INCREMENT,
    VIN VARCHAR(45) NOT NULL UNIQUE,
    manufacturer VARCHAR(45) NOT NULL,
    model VARCHAR(45) NOT NULL,
    year YEAR NOT NULL,
    color VARCHAR(45) NOT NULL,
    PRIMARY KEY (ID)
);

-- Drop and create 'customers' table
DROP TABLE IF EXISTS customers;
CREATE TABLE IF NOT EXISTS customers (
    ID INT NOT NULL AUTO_INCREMENT,
    customer_id VARCHAR(45) NOT NULL UNIQUE,
    name VARCHAR(45) NOT NULL,
    phone_number VARCHAR(45) NOT NULL,
    email VARCHAR(100) UNIQUE,
    address VARCHAR(100) NOT NULL,
    city VARCHAR(45) NOT NULL,
    state_province VARCHAR(45) NOT NULL,
    country VARCHAR(45) NOT NULL,
    zip_postal_code VARCHAR(45) NOT NULL,
    PRIMARY KEY (ID)
);

-- Drop and create 'salespersons' table
DROP TABLE IF EXISTS salespersons;
CREATE TABLE IF NOT EXISTS salespersons (
    ID INT NOT NULL AUTO_INCREMENT,
    staff_id VARCHAR(45) NOT NULL UNIQUE,
    name VARCHAR(45) NOT NULL,
    store VARCHAR(45) NOT NULL,
    PRIMARY KEY (ID)
);

-- Drop and create 'invoices' table
DROP TABLE IF EXISTS invoices;
CREATE TABLE IF NOT EXISTS invoices (
    ID INT NOT NULL AUTO_INCREMENT,
    invoice_id VARCHAR(45) NOT NULL UNIQUE,
    date DATE,
    car_id INT NOT NULL,
    customer_id INT NOT NULL,
    salesperson_id INT NOT NULL,
    PRIMARY KEY (ID),
    CONSTRAINT fk_car_id FOREIGN KEY (car_id) REFERENCES cars (ID),
    CONSTRAINT fk_customer_id FOREIGN KEY (customer_id) REFERENCES customers (ID),
    CONSTRAINT fk_salesperson_id FOREIGN KEY (salesperson_id) REFERENCES salespersons (ID)
);