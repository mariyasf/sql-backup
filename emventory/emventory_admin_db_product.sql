USE emventory_admin_db;

-- Category Table
CREATE TABLE category (
    id INT PRIMARY KEY AUTO_INCREMENT,
    category_id VARCHAR(255) UNIQUE NOT NULL,
    name VARCHAR(255) NOT NULL,
    image VARCHAR(255),
    parent_id VARCHAR(255),
    depth INT DEFAULT 1,
    org_id VARCHAR(255) NOT NULL
);

-- Attribute Table
CREATE TABLE attribute (
    id INT PRIMARY KEY AUTO_INCREMENT,
    attribute_id VARCHAR(255) UNIQUE NOT NULL,
    name VARCHAR(255) NOT NULL,
    org_id VARCHAR(255) NOT NULL,
    
    FOREIGN KEY (org_id) REFERENCES organization(org_id) ON DELETE CASCADE
); 

-- Attribute Value Table
CREATE TABLE attribute_value (
    id INT PRIMARY KEY AUTO_INCREMENT,
    attribute_value_id VARCHAR(255) UNIQUE NOT NULL,
    value VARCHAR(255) NOT NULL,
    attribute_id VARCHAR(255) NOT NULL,
    
    FOREIGN KEY (attribute_id) REFERENCES attribute(attribute_id) ON DELETE CASCADE
);


-- Product Unit Table
CREATE TABLE product_unit (
    id INT PRIMARY KEY AUTO_INCREMENT,
    unit_id VARCHAR(255) UNIQUE NOT NULL,
    name VARCHAR(255) NOT NULL,
    org_id VARCHAR(255) NOT NULL,
    
    
    FOREIGN KEY (org_id) REFERENCES organization(org_id) ON DELETE CASCADE
);

-- Product Rack Table
CREATE TABLE product_rack (
    id INT PRIMARY KEY AUTO_INCREMENT,
    rack_id VARCHAR(255) UNIQUE NOT NULL,
    name VARCHAR(255) NOT NULL,
    org_id VARCHAR(255) NOT NULL,
    
    FOREIGN KEY (org_id) REFERENCES organization(org_id) ON DELETE CASCADE
);

-- Product Brand Table
CREATE TABLE product_brand (
    id INT PRIMARY KEY AUTO_INCREMENT,
    brand_id VARCHAR(255) UNIQUE NOT NULL,
    name VARCHAR(255) NOT NULL,
    org_id VARCHAR(255) NOT NULL,
    
    FOREIGN KEY (org_id) REFERENCES organization(org_id) ON DELETE CASCADE
);

-- Supplier Table
CREATE TABLE supplier (
    id INT PRIMARY KEY AUTO_INCREMENT,
    org_id VARCHAR(255) NOT NULL,
    supplier_id VARCHAR(255) UNIQUE NOT NULL,
    supplier_name TEXT NOT NULL,
    
    FOREIGN KEY (org_id) REFERENCES organization(org_id) ON DELETE CASCADE
);

 -- Product Table
CREATE TABLE product (
    id INT PRIMARY KEY AUTO_INCREMENT,
    product_id VARCHAR(255) UNIQUE NOT NULL,
    org_id VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL,
    category VARCHAR(255) NOT NULL,
    brand VARCHAR(255) NOT NULL,
    supplier VARCHAR(255) NOT NULL,
    description MEDIUMTEXT,
    unit VARCHAR(255) NOT NULL,
    expiry_date DATE,
    stock_alert_qty INT NOT NULL,
    rack  VARCHAR(255) NOT NULL,
    total_stock INT NOT NULL,
    buying_price INT,
	selling_price INT, 
    createDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    updatedAt DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 
 
    FOREIGN KEY (org_id) REFERENCES organization(org_id) ON DELETE CASCADE,
    FOREIGN KEY (category) REFERENCES category(category_id) ON DELETE CASCADE,
    FOREIGN KEY (brand) REFERENCES product_brand(brand_id),
    FOREIGN KEY (supplier) REFERENCES supplier(supplier_id),
    FOREIGN KEY (unit) REFERENCES product_unit(unit_id),
    FOREIGN KEY (rack) REFERENCES product_rack(rack_id) 
);
SELECT * FROM product;

SELECT * FROM product;
-- DROP TABLE product;
-- ALTER TABLE product
-- ADD CONSTRAINT variation FOREIGN KEY (variation_id) REFERENCES variation(variation_id),
-- ADD CONSTRAINT product_image FOREIGN KEY (image_id) REFERENCES product_image(image_id);




-- Variation Table
CREATE TABLE variation (
    id INT PRIMARY KEY AUTO_INCREMENT,
    variation_id VARCHAR(255) UNIQUE NOT NULL,
    product_id VARCHAR(255) NOT NULL,
    stock INT NOT NULL,
    org_id VARCHAR(255) NOT NULL,
    store_id VARCHAR(255) NOT NULL,
     
    FOREIGN KEY (product_id) REFERENCES product(product_id) ON DELETE CASCADE,
    FOREIGN KEY (org_id) REFERENCES organization(org_id),
    FOREIGN KEY (store_id) REFERENCES store(store_id)
);

-- Variation Attribute Table
CREATE TABLE variation_attribute (
    id INT PRIMARY KEY AUTO_INCREMENT,
    variation_attribute_id VARCHAR(255) NOT NULL,
    variation_id VARCHAR(255) NOT NULL,
    attribute_id VARCHAR(255) NOT NULL,
    attribute_value_id VARCHAR(255) NOT NULL,
     
    FOREIGN KEY (variation_id) REFERENCES variation(variation_id) ON DELETE CASCADE,
    FOREIGN KEY (attribute_id) REFERENCES attribute(attribute_id),
    FOREIGN KEY (attribute_value_id) REFERENCES attribute_value(attribute_value_id)
);

-- Specification Table
CREATE TABLE specification (
    id INT PRIMARY KEY AUTO_INCREMENT,
    specification_id VARCHAR(255) NOT NULL,
    product_id VARCHAR(255) NOT NULL,
    spec_name TEXT NOT NULL,
    spec_value TEXT NOT NULL,
    createDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    updatedAt DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
     
    FOREIGN KEY (product_id) REFERENCES product(product_id) ON DELETE CASCADE
);

-- Product Image Table
CREATE TABLE product_image (
    id INT PRIMARY KEY AUTO_INCREMENT,
    image_id VARCHAR(255) NOT NULL,
    product_id VARCHAR(255) NOT NULL,
    image_1 TEXT,
    image_2 TEXT,
    image_3 TEXT,
    image_4 TEXT,
    updatedAt DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
     
    FOREIGN KEY (product_id) REFERENCES product(product_id) ON DELETE CASCADE
);


-- Step 1: Add columns
ALTER TABLE product
ADD COLUMN variation_id VARCHAR(255) NOT NULL,
ADD COLUMN image_id VARCHAR(255) NOT NULL;

CREATE INDEX idx_image_id ON product_image(image_id);

-- Step 2: Add foreign key constraints
ALTER TABLE product
ADD CONSTRAINT fk_variation FOREIGN KEY (variation_id) REFERENCES variation(variation_id),
ADD CONSTRAINT fk_product_image FOREIGN KEY (image_id) REFERENCES product_image(image_id);
