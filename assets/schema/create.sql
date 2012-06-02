CREATE TABLE bank (
  bank_id INTEGER PRIMARY KEY,
  name VARCHAR(200),
  bic VARCHAR(11)
);

CREATE TABLE date (
  date_id INTEGER PRIMARY KEY,
  date TIMESTAMP
);

CREATE TABLE sender (
  sender_id INTEGER PRIMARY KEY,
  name VARCHAR(200),
  alias VARCHAR(200),
  bank_id INTEGER REFERENCES bank(bank_id) NOT NULL,
  iban VARCHAR(34),
  opencorporateurl VARCHAR(200)
);

CREATE TABLE receiver (
  receiver_id INTEGER PRIMARY KEY,
  name VARCHAR(200),
  alias VARCHAR(200),
  bank_id INTEGER REFERENCES bank(bank_id) NOT NULL,
  iban VARCHAR(34),
  opencorporateurl VARCHAR(200)
);

CREATE TABLE category (
  category_id INTEGER PRIMARY KEY,
  name VARCHAR(200),
  parentcategoryid INTEGER REFERENCES Category(category_id)
);

CREATE TABLE transaction (
  transaction_id INTEGER PRIMARY KEY,
  date_id INTEGER REFERENCES date(date_id) NOT NULL,
  sender_id INTEGER REFERENCES sender(sender_id) NOT NULL,
  receiver_id INTEGER REFERENCES receiver(receiver_id) NOT NULL,
  category_id INTEGER REFERENCES category(category_id) NOT NULL,
  amount FLOAT NOT NULL,
  currency VARCHAR(100),
  type VARCHAR(7) CHECK (type IN ('income','expense'))
);