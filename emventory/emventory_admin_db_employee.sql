USE emventory_admin_db;

CREATE TABLE employee (
  id 			  INT PRIMARY KEY AUTO_INCREMENT,
  employee_id     VARCHAR(255) NOT NULL UNIQUE,
  name            VARCHAR(255) NOT NULL,
  number          VARCHAR(20) NOT NULL,
  address         VARCHAR(255) NOT NULL,
  designation     VARCHAR(255) NOT NULL,
  nid             VARCHAR(100),
  org_id          VARCHAR(255) NOT NULL,
  store_id        VARCHAR(255) NOT NULL,
  user_id		  VARCHAR(255) NOT NULL,
  commissionRate  INT,
  image           VARCHAR(255),
  status          ENUM('ACTIVE', 'INACTIVE') DEFAULT 'ACTIVE',
  date            DATETIME DEFAULT CURRENT_TIMESTAMP,
  
  FOREIGN KEY (store_id) REFERENCES store(store_id) ON DELETE CASCADE
);

CREATE TABLE activity (
  id 		INT PRIMARY KEY AUTO_INCREMENT,
  org_id    VARCHAR(255),
  store_id  VARCHAR(255),
  user_id   VARCHAR(255),
  des       TEXT,
  event_id  VARCHAR(255),
  date      DATETIME DEFAULT CURRENT_TIMESTAMP
);
