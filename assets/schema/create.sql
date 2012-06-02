CREATE TABLE date (
  date_id INTEGER PRIMARY KEY,
  date TIMESTAMP
);

CREATE TABLE transaction_partner (
  tp_id INTEGER PRIMARY KEY,
  account_holder VARCHAR(200),
  bank_name VARCHAR(200)
);

CREATE TABLE category (
  category_id INTEGER PRIMARY KEY,
  transaction_type VARCHAR(7) CHECK (transaction_type IN ('income','expense')) NOT NULL,
  name VARCHAR(200),
  parentcategoryid INTEGER REFERENCES Category(category_id)
);

CREATE TABLE transaction (
  transaction_id INTEGER PRIMARY KEY,
  date_id INTEGER REFERENCES date(date_id) NOT NULL,
  tp_id INTEGER REFERENCES transaction_partner(tp_id) NOT NULL,
  category_id INTEGER REFERENCES category(category_id) NOT NULL,
  amount DOUBLE PRECISION NOT NULL,
  currency VARCHAR(100),
  account_holder VARCHAR(200)
);