
-- Day 2 – Constraints, Sample Data & Queries

-- 1. Add Indexes
CREATE INDEX idx_user_email ON users(email);
CREATE INDEX idx_user_hotel ON users(hotel_id);
CREATE INDEX idx_bill_created_at ON bills(created_at);

mysql> CREATE INDEX idx_user_hotel ON users(hotel_id);
Query OK, 0 rows affected (0.22 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> CREATE INDEX idx_bill_created_at ON bills(created_at);
Query OK, 0 rows affected (0.04 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql>  CREATE INDEX idx_user_role ON users (role);
Query OK, 0 rows affected (0.05 sec)
Records: 0  Duplicates: 0  Warnings: 0

--  2. Insert Sample Hotels
INSERT INTO hotels (name, address) VALUES 
('Taj Palace', 'Delhi'),
('The Oberoi', 'Mumbai'),
('Leela Palace', 'Bangalore');

select *from hotels;
  1  | Delhi     | Taj Palace   |
  2  | Mumbai    | The Oberoi   |
  3  | Bangalore | Leela Palace 




--  3. Insert Sample Users
INSERT INTO users (username, password, role, hotel_id) VALUES 
('admin1', 'adminpass1', 'ADMIN', 1),
('staff1', 'staffpass1', 'STAFF', 1),
('admin2', 'adminpass2', 'ADMIN', 2),
('staff2', 'staffpass2', 'STAFF', 2);

mysql> select *from users;
+----+------------+-------+----------+----------+
| id | password   | role  | username | hotel_id |
+----+------------+-------+----------+----------+
|  1 | adminpass1 | ADMIN | admin1   |        1 |
|  2 | staffpass1 | STAFF | staff1   |        1 |
|  3 | adminpass2 | ADMIN | admin2   |        2 |
|  4 | adminpass1 | ADMIN | admin1   |        3 |
|  
+----+------------+-------+----------+----------+



--  4. Insert Sample Products
INSERT INTO products (name, price, hotel_id) VALUES 
('Paneer Butter Masala', 250.00, 1),
('Veg Biryani', 180.00, 1),
('Chicken Curry', 300.00, 2),
('Naan', 40.00, 2);


mysql> select *from products;
+----+----------------------+-------+----------+
| id | name                 | price | hotel_id |
+----+----------------------+-------+----------+
|  1 | Paneer Butter Masala |   250 |        1 |
|  2 | Veg Biryani          |   180 |        1 |
|  3 | Chicken Curry        |   300 |        2 |
|  4 | Naan                 |    40 |        2 |
+----+------------+-------+----------+----------+





--  5. Insert Sample Bills
INSERT INTO bills (created_at, hotel_id, user_id) VALUES 
('2025-06-01 12:00:00', 1, 1),
('2025-06-02 18:30:00', 1, 2),
('2025-06-03 13:15:00', 2, 3);


mysql> select *from bills;
+----+----------------------------+----------+---------+
| id | created_at                 | hotel_id | user_id |
+----+----------------------------+----------+---------+
|  1 | 2025-06-01 12:00:00.000000 |        1 |       1 |
|  2 | 2025-06-02 18:30:00.000000 |        1 |       2 |
|  3 | 2025-06-03 13:15:00.000000 |        2 |       3 |
+----+----------------------------+----------+---------+
3 rows in set (0.00 sec)




--  6. Insert Sample Bill Items
INSERT INTO bill_items (quantity, bill_id, product_id) VALUES 
(2, 1, 1),  -- 2 x Paneer Butter Masala
(1, 1, 2),  -- 1 x Veg Biryani
(3, 2, 1),  -- 3 x Paneer Butter Masala
(2, 3, 3),  -- 2 x Chicken Curry
(4, 3, 4);  -- 4 x Naan

mysql> select *from bill_items;
+----+----------+---------+------------+
| id | quantity | bill_id | product_id |
+----+----------+---------+------------+
|  4 |        2 |       1 |          1 |
|  5 |        1 |       1 |          2 |
|  6 |        3 |       2 |          1 |
|  7 |        2 |       3 |          3 |
|  8 |        4 |       3 |          4 |
+----+----------+---------+------------+
5 rows in set (0.00 sec)




--  7. Query: Fetch Products by Hotel
-- Get all products for hotel_id = 1
SELECT * FROM products WHERE hotel_id = 1;


mysql> SELECT * FROM products WHERE hotel_id = 1;
+----+----------------------+-------+----------+
| id | name                 | price | hotel_id |
+----+----------------------+-------+----------+
|  1 | Paneer Butter Masala |   250 |        1 |
|  2 | Veg Biryani          |   180 |        1 |
+----+----------------------+-------+----------+
2 rows in set (0.01 sec)




--  8. Query: Total Bill Amount in a Date Range
-- Calculate total for bills from 1st June to 4th June 2025

SELECT b.id AS bill_id, SUM(p.price * bi.quantity) AS total_amount
FROM bills b
JOIN bill_items bi ON b.id = bi.bill_id
JOIN products p ON bi.product_id = p.id
WHERE b.created_at BETWEEN '2025-06-01' AND '2025-06-04'
GROUP BY b.id;


+---------+--------------+
| bill_id | total_amount |
+---------+--------------+
|       1 |          680 |
|       2 |          750 |
|       3 |          760 |
+---------+--------------+
3 rows in set (0.01 sec)



--  9. Query: Bills by Specific User
-- Bills generated by user_id = 1
SELECT * FROM bills WHERE user_id = 1;

mysql> SELECT * FROM bills WHERE user_id = 1;
+----+----------------------------+----------+---------+
| id | created_at                 | hotel_id | user_id |
+----+----------------------------+----------+---------+
|  1 | 2025-06-01 12:00:00.000000 |        1 |       1 |
+----+----------------------------+----------+---------+
1 row in set (0.00 sec)

