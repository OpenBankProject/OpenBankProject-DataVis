CREATE TABLE bank (
  bank_id INTEGER PRIMARY KEY,
  name VARCHAR(200)
);

CREATE TABLE date (
  date_id INTEGER PRIMARY KEY,
  date TIMESTAMP
);

CREATE TABLE transaction_partner (
  tp_id INTEGER PRIMARY KEY,
  name VARCHAR(200),
  alias VARCHAR(200),
  bank_id INTEGER REFERENCES bank(bank_id) NOT NULL
);

CREATE TABLE category (
  category_id INTEGER PRIMARY KEY,
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
  transaction_type VARCHAR(7) CHECK (type IN ('income','expense')),
  name VARCHAR(200)
);