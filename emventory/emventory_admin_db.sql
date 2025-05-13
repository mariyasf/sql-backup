DROP DATABASE emventory_admin_db ;

CREATE DATABASE IF NOT EXISTS emventory_admin_db;
USE emventory_admin_db;

CREATE TABLE admin (
    id INT AUTO_INCREMENT PRIMARY KEY,
    admin_id VARCHAR(255) UNIQUE NOT NULL,
    name VARCHAR(255) NOT NULL,
	number VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    date DATETIME DEFAULT CURRENT_TIMESTAMP
);
SELECT * FROM admin;

-- Organization Table
CREATE TABLE organization (
    id INT PRIMARY KEY AUTO_INCREMENT,
    org_id VARCHAR(255) UNIQUE,
    user_type ENUM('ecommerce', 'enterprise'),
    status ENUM('ACTIVE', 'INACTIVE') DEFAULT 'ACTIVE',
    plan ENUM('Free', 'Premium') DEFAULT 'Free',
    plan_expiary DATE,
    date DATETIME DEFAULT CURRENT_TIMESTAMP
);

SELECT * FROM organization;

-- Organization Info Table
CREATE TABLE organization_info (
    id INT PRIMARY KEY AUTO_INCREMENT,
    org_id VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL,
    owner_name VARCHAR(255) NOT NULL,
    number VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    logo VARCHAR(255),
    location VARCHAR(255) NOT NULL,
    type ENUM('Clothing', 'Electronics', 'Grocery', 'Jewellery', 'Others') NOT NULL,
     category_length VARCHAR (255) NOT NULL,
    currency VARCHAR(255),
    createDate DATETIME  DEFAULT CURRENT_TIMESTAMP,
    updateDate DATETIME,

    FOREIGN KEY (org_id) REFERENCES organization(org_id) ON DELETE CASCADE
);
SELECT * FROM organization_info;

-- Store Table
CREATE TABLE store (
    id INT PRIMARY KEY AUTO_INCREMENT,
    store_id VARCHAR(255) UNIQUE NOT NULL,
    org_id VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL,
    manager VARCHAR(255) NOT NULL,
    number VARCHAR(255),
    location VARCHAR(255),
    type ENUM('MOTHER', 'BRANCH') NOT NULL,
    status ENUM('ACTIVE', 'INACTIVE') DEFAULT 'ACTIVE',
    date DATETIME DEFAULT CURRENT_TIMESTAMP,
    user_id VARCHAR(255),
    FOREIGN KEY (org_id) REFERENCES organization(org_id) ON DELETE CASCADE
);


-- Role Table
CREATE TABLE role (
    id INT PRIMARY KEY AUTO_INCREMENT,
    org_id VARCHAR(255),   
    role_id  VARCHAR(255) UNIQUE NOT NULL,  
    role_name VARCHAR(255) NOT NULL,
    date DATETIME DEFAULT CURRENT_TIMESTAMP,   
    
    FOREIGN KEY (org_id) REFERENCES organization(org_id) ON DELETE CASCADE
);
INSERT INTO role (role_id, role_name) VALUES
   (1, 'ADMIN'),
  (2, 'MANAGER'),
  (3, 'ACCOUNTANT'),
  (4, 'SALESMAN'),
  (5, 'SUPPORT');


-- Role Access Table
CREATE TABLE role_access (
    id INT PRIMARY KEY AUTO_INCREMENT,
    org_id VARCHAR(255) NOT NULL,
    role_id  VARCHAR(255) NOT NULL,
    create_permission TEXT,
    read_permission TEXT,
    delete_permission TEXT,
    update_permission TEXT,
    
	FOREIGN KEY (org_id) REFERENCES organization(org_id) ON DELETE CASCADE,
	FOREIGN KEY (role_id) REFERENCES role(role_id)
);

-- User Table
CREATE TABLE user (
    id INT PRIMARY KEY AUTO_INCREMENT,
	user_id VARCHAR(255) NOT NULL UNIQUE, 
    name VARCHAR(255) NOT NULL,
    number VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    image VARCHAR(255),
	isComplete ENUM('YES', 'NO') DEFAULT 'NO',
    role_id  VARCHAR(255) NOT NULL,
    status ENUM('ACTIVE', 'INACTIVE') DEFAULT 'ACTIVE',
    date DATETIME DEFAULT CURRENT_TIMESTAMP,
    org_id VARCHAR(255),
    store_id VARCHAR(255),
    
    FOREIGN KEY (role_id) REFERENCES role(role_id),
    FOREIGN KEY (org_id) REFERENCES organization(org_id) ON DELETE CASCADE,
    FOREIGN KEY (store_id) REFERENCES store(store_id) ON DELETE CASCADE
);
 
 
 
-- Subscription Table
CREATE TABLE subscription_history (
    id INT PRIMARY KEY AUTO_INCREMENT,
    org_id VARCHAR(255) NOT NULL,
    plan ENUM('FREE', 'BASIC', 'PREMIUM') DEFAULT 'FREE',
    plan_start DATE NOT NULL,
    plan_end DATE NOT NULL,
    updatedAt DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    FOREIGN KEY (org_id) REFERENCES organization(org_id) ON DELETE CASCADE
);


-- Subscription Payment Table
CREATE TABLE subscription_payment (
    id INT PRIMARY KEY AUTO_INCREMENT,
    org_id VARCHAR(255) NOT NULL,
    payment_id VARCHAR(255) NOT NULL,
    subscription_plan ENUM('FREE', 'PREMIUM') NOT NULL,
    paid_amount FLOAT NOT NULL,
    payment_method VARCHAR(255) NOT NULL,
    date DATETIME NOT NULL,
    
    FOREIGN KEY (org_id) REFERENCES organization(org_id) ON DELETE CASCADE
);
