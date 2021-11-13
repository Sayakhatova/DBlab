create table customers (
    id integer primary key,
    name varchar(255),
    birth_date date
);

create table accounts(
    account_id varchar(40) primary key ,
    customer_id integer references customers(id),
    currency varchar(3),
    balance float,
    "limit" float
);

create table transactions (
    id serial primary key ,
    date timestamp,
    src_account varchar(40) references accounts(account_id),
    dst_account varchar(40) references accounts(account_id),
    amount float,
    status varchar(20)
);

INSERT INTO customers VALUES (201, 'John', '2021-11-05');
INSERT INTO customers VALUES (202, 'Anny', '2021-11-02');
INSERT INTO customers VALUES (203, 'Rick', '2021-11-24');

INSERT INTO accounts VALUES ('NT10204', 201, 'KZT', 1000, null);
INSERT INTO accounts VALUES ('AB10203', 202, 'USD', 100, 0);
INSERT INTO accounts VALUES ('DK12000', 203, 'EUR', 500, 200);
INSERT INTO accounts VALUES ('NK90123', 201, 'USD', 400, 0);
INSERT INTO accounts VALUES ('RS88012', 203, 'KZT', 5000, -100);

INSERT INTO transactions VALUES (1, '2021-11-05 18:00:34.000000', 'NT10204', 'RS88012', 1000, 'commited');
INSERT INTO transactions VALUES (2, '2021-11-05 18:01:19.000000', 'NK90123', 'AB10203', 500, 'rollback');
INSERT INTO transactions VALUES (3, '2021-06-05 18:02:45.000000', 'RS88012', 'NT10204', 400, 'init');

-- 1
-- In indexes. It is fast but it can be useless if someone changed data bases.

-- 2
-- Privilege is ability while role is position. A user privilege is a right to execute a particular type .
-- Roles are created by users and used to group together privileges or other roles.

-- 2a
CREATE ROLE administrator SUPERUSER;
GRANT ALL PRIVILEGES ON customers TO administrator;
CREATE ROLE support;
GRANT ALL PRIVILEGES ON transactions TO support;
CREATE ROLE accountant;
GRANT ALL PRIVILEGES ON accounts TO accountant;

-- 2b
CREATE USER a1 WITH password '12356';
GRANt accountant TO a1;
CREATE USER a2 WITH password '44544';
GRANT administrator TO a2;
CREATE USER a3 WITH password '54544';
GRANT support TO a3;

-- 2c
GRANT administrator TO accountant, support;

-- 2d
REVOKE SELECT ON customers FROM administrator;
REVOKE SELECT ON accounts FROM accountant;

-- 3
ALTER TABLE transactions
ALTER COLUMN amount SET NOT NULL;

ALTER TABLE transactions
ALTER COLUMN date SET NOT NULL;

-- 5a
CREATE UNIQUE INDEX index_account on accounts(customer_id, currency);

-- 5b
CREATE INDEX index_transaction ON accounts(currency, balance);

-- 6
BEGIN;

UPDATE accounts SET balance = balance + 500 WHERE account_id = 'RS88012';
UPDATE accounts SET balance = balance - 500 WHERE account_id = 'NT10204';
COMMIT;

IF balance < LIMIT WHERE account_id = 'RS88012' THEN ROLLBACK;
ELSE COMMIT;

COMMIT;
