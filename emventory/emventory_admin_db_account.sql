USE emventory_admin_db;

CREATE TABLE account_heads (
    id INT PRIMARY KEY AUTO_INCREMENT,
    account_heads_id VARCHAR(255) UNIQUE NOT NULL,
    code VARCHAR(255) UNIQUE NOT NULL,
    account_type ENUM('DEBIT', 'CREDIT') NOT NULL,
    name VARCHAR(255) NOT NULL,
    type VARCHAR(255) NOT NULL,
    description TEXT,
    org_id VARCHAR(255),
    
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  
	FOREIGN KEY (org_id) REFERENCES organization(org_id) ON DELETE CASCADE
);


INSERT INTO account_heads (account_heads_id, code, account_type, name, type, org_id) 
VALUES 
('AH-001', 'AST-001', 'DEBIT', 'Assets', 'Asset', 'ORG_396fa57b-7ac0-4061-8d59-d972fe8ae90e'),
('AH-002', 'AST-002', 'DEBIT', 'Cash', 'Asset', 'ORG_396fa57b-7ac0-4061-8d59-d972fe8ae90e'),
('AH-003', 'AST-003', 'CREDIT', 'Accounts Payable', 'Liability', 'ORG_396fa57b-7ac0-4061-8d59-d972fe8ae90e'),
('AH-004', 'EXP-001', 'DEBIT', 'Rent Expense', 'Expense', 'ORG_396fa57b-7ac0-4061-8d59-d972fe8ae90e'),
('AH-005', 'REV-001', 'CREDIT', 'Service Revenue', 'Income', 'ORG_396fa57b-7ac0-4061-8d59-d972fe8ae90e');

SELECT * FROM account_heads;
SELECT * FROM account;

CREATE TABLE account (
    id INT PRIMARY KEY AUTO_INCREMENT,
    account_id VARCHAR(255) UNIQUE NOT NULL,
    org_id VARCHAR(255) NOT NULL,
    store_id VARCHAR(255) NOT NULL,
    
    name VARCHAR(255),
    account_type ENUM('CASH', 'BANK', 'OTHER') NOT NULL,
    holder_name VARCHAR(255),
    account_no VARCHAR(255),
    pos_percentage INT,
    balance DECIMAL(15,2),
    opening_bal DECIMAL(15,2),
    status ENUM('ACTIVE', 'INACTIVE') DEFAULT 'ACTIVE',
    date TIMESTAMP NOT NULL,
    
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


CREATE TABLE account_transaction (
	id INT PRIMARY KEY AUTO_INCREMENT,
    trn_id VARCHAR(255) UNIQUE NOT NULL,
    org_id VARCHAR(255) NOT NULL,
    account_id VARCHAR(255) NOT NULL,
    particularName VARCHAR(255) NOT NULL,
    particularValue VARCHAR(255) NOT NULL,
    debit FLOAT NOT NULL,
    credit FLOAT NOT NULL,
    balance FLOAT NOT NULL,
    date DATETIME NOT NULL,
    
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (account_id) REFERENCES Account(account_id) ON DELETE CASCADE,
    FOREIGN KEY (org_id) REFERENCES organization(org_id) ON DELETE CASCADE
    
);

CREATE TABLE expense (
    id INT PRIMARY KEY AUTO_INCREMENT,
    expense_id VARCHAR(255) UNIQUE NOT NULL,
    trn_id VARCHAR(255),
    org_id VARCHAR(255) NOT NULL,
    store_id VARCHAR(255) NOT NULL,
    account_id VARCHAR(255) NOT NULL,
    expense_by VARCHAR(255),
    expense_head VARCHAR(255) NOT NULL,
    amount DECIMAL(15,2) NOT NULL,
    des TEXT,
    date DATETIME NOT NULL,
    balance DECIMAL(15,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (account_id) REFERENCES account(account_id),
    FOREIGN KEY (expense_by) REFERENCES employee(employee_id),
    FOREIGN KEY (store_id, org_id) REFERENCES store(store_id, org_id)
);

CREATE TABLE supplier_transaction (
    id INT PRIMARY KEY AUTO_INCREMENT,
    supplier_transaction_id VARCHAR(255) UNIQUE NOT NULL,
    org_id VARCHAR(255) NOT NULL,
    supplier_id VARCHAR(255) NOT NULL,
    supplier_bill_id VARCHAR(255) NOT NULL,
    account_id VARCHAR(255) NOT NULL,
    amount DECIMAL(15,2) NOT NULL,
    date DATETIME NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (account_id) REFERENCES account(account_id),
    FOREIGN KEY (supplier_id) REFERENCES supplier(supplier_id),
    FOREIGN KEY (supplier_bill_id) REFERENCES supplier_bill(supplier_bill_id)
);

CREATE TABLE account_transfer (
    id INT PRIMARY KEY AUTO_INCREMENT,
    account_transfer_id VARCHAR(255) UNIQUE NOT NULL,
    org_id VARCHAR(255) NOT NULL,
    from_account_id VARCHAR(255) NOT NULL,
    to_account_id VARCHAR(255) NOT NULL,
    transferBalance DECIMAL(15,2) NOT NULL,
    date DATETIME NOT NULL,
    frm_ac_bal DECIMAL(15,2),
    to_ac_bal DECIMAL(15,2),
    
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (from_account_id) REFERENCES account(account_id),
    FOREIGN KEY (to_account_id) REFERENCES account(account_id)
);


CREATE TABLE bill_transfer (
    id INT PRIMARY KEY AUTO_INCREMENT,
    supplier_id VARCHAR(255) NOT NULL,
    supplier_name VARCHAR(255) NOT NULL,
    bill_transfer_id VARCHAR(255) UNIQUE NOT NULL,
    org_id VARCHAR(255) NOT NULL,
    account_id VARCHAR(255) NOT NULL,
    credit DECIMAL(15,2) NOT NULL,
    balance DECIMAL(15,2) NOT NULL,
    supplier_bill_id VARCHAR(255) NOT NULL,
    date DATETIME NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (supplier_id) REFERENCES supplier(supplier_id) ON DELETE CASCADE,
    FOREIGN KEY (supplier_bill_id) REFERENCES supplier_bill(supplier_bill_id),
    FOREIGN KEY (account_id) REFERENCES account(account_id)
);


CREATE TABLE sale_info (
    id INT PRIMARY KEY AUTO_INCREMENT,
    sale_id VARCHAR(255) UNIQUE NOT NULL,
    trn_id VARCHAR(255),
    org_id VARCHAR(255) NOT NULL,
    store_id VARCHAR(255) NOT NULL,
    c_id VARCHAR(255),
    c_name VARCHAR(255),
    c_number VARCHAR(255),
    c_address TEXT,
    total_payable DECIMAL(15,2) NOT NULL,
    total_paid DECIMAL(15,2) NOT NULL,
    discount_type VARCHAR(255),
    discount DECIMAL(15,2),
    payment_mode_cash VARCHAR(255),
    payment_mode_card VARCHAR(255),
    payment_mode_other VARCHAR(255),
    cashAcc VARCHAR(255),
    bankAcc VARCHAR(255),
    otherAcc VARCHAR(255),
    cash_paid DECIMAL(15,2),
    bank_paid DECIMAL(15,2),
    other_paid DECIMAL(15,2),
    due DECIMAL(15,2),
    sold_by VARCHAR(255),
    referred_by VARCHAR(255),
    discount_value DECIMAL(15,2),
    status ENUM('ACTIVE', 'INACTIVE') DEFAULT 'ACTIVE',
    date DATETIME DEFAULT CURRENT_TIMESTAMP,
    pointAmount DECIMAL(15,2),
    vatAmount DECIMAL(15,2),
    balance DECIMAL(15,2),
    return_sale_id VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (store_id, org_id) REFERENCES store(store_id, org_id),
    FOREIGN KEY (sold_by) REFERENCES employee(employee_id),
    FOREIGN KEY (cashAcc) REFERENCES account(account_id),
    FOREIGN KEY (bankAcc) REFERENCES account(account_id),
    FOREIGN KEY (otherAcc) REFERENCES account(account_id)
);