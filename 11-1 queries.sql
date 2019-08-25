-- queries for assignment 11.1

USE salespeople;

drop table product;
drop table client;
drop table salesman;
drop table sales_order_details;

Create table if not exists product (product_id varchar(10) primary key, product_name varchar(20), manufacturer_name char(20),product_rate decimal(9,4), sell_price decimal(9,4),product_description varchar(25));
Create table if not exists client (client_id varchar(10) primary key, client_name char(20),address varchar(15), city char(15),pin int, state char(15),bal_due decimal(9,4));
Create table if not exists salesman (salesman_id varchar(10) primary key, salesman_name char(20),address varchar(15), city char(15),pin int, state char(15),salary decimal(9,4));
Create table if not exists sales_order_details (sales_order_no varchar(10) primary key, sales_order_date date, client_id varchar(10) references client(client_id), salesman_id varchar(10) references salesman(salesman_id) , bill_payby_party char(5), delivery_date date,product_rate decimal(9,4), tot_quantity_order int,cancel_date date default NULL);

-- We can use INSERT IGNORE to continue script after failing to insert due to primary key already existing (treat errors as warning)

Insert into product values('p001','lux_soap','Lux_international','15.67','20.43','soap');
Insert into product values('p002','copy','times_copy_org','14.80','16.40','copy');
Insert into product values('p003','marry_biscuit','marigold_org','2218.80','2220.40','buiskit'); Insert into product values('p004','mitsubisi_pen','pen_international','2015.67','2120.43','pen'); Insert into product values('p005','learn_books','book_world','5104.80','5116.40','book'); Insert into product values('p006','tata_steel','tata_org','5118.80','5120.40','tata');
Insert into product values('p007','seagate hdd','seaget_world','5104.80','5116.40','HDD1034'); Insert into product values('p008','dvd writer','frontec_org','5118.80','5120.40',' DVDRW');
Insert into client values('cn01001','alak roy',' b.d.para','amarpur','799101','tripura','390.9'); Insert into client values('cn01002','suman roy',' puk para','agartala','799102','tripura','2390.9'); Insert into client values('cn01004','priya das',' chora para','kamalpur','799301','tripura','1390.9'); Insert into client values('cn01005','mita mia',' kamal para','singur','799721','tripura','190.9'); Insert into client values('cn01006','pulak roy',' bircity','sonitpur','799141','assam','110.9');
Insert into client values('cn01007','munni das',' nappam','sonitpur','799152','assam','190.9'); Insert into client values('cn01008','kusum roy',' city_dos','tezpur','799141','assam','110.9'); Insert into client values('cn01009','mina das',' pachmile','tezpur','799152','assam','190.9');
Insert into client values('cn01003','moytree nayak',' pachmile','tezpur','799152','assam','9990.9'); Insert into client values('cn01010','pauri mia',' pachmile','tezpur','799152','assam','2990.9'); Insert into client values('cn01011','manali das',' satmile','tezpur','799154','assam','3990.9');

Insert into salesman values('s001','Rohan das','nappam','Tezpur','79970','Assam','8000');
Insert into salesman values('s002','Rohan das','nappam','Tezpur','799170','Assam','8000');
Insert into salesman values('s003','Smita das','nirjuli','itanagar','799701','Arunachal','9000');
Insert into salesman values('s004','Kabir bora','nappam','Tezpur','799703','Assam','8500');
Insert into salesman values('s005','Neha singh','borbota ','sonitpur','795970','assam','9600');
Insert into salesman values('s006','Priya agarwal','gandhi road ','32 distric','799750','delhi','9900'); Insert into salesman values('s007','Ashok Paul','filmcity','munnabari ','799740','mumbai','8900');

Insert IGNORE into sales_order_details values('on01001','2008-08-01','cn01001','s001','yes','2008-08-20', '2220.40','50',NULL);
Insert IGNORE into sales_order_details values('on01002','2008-08-12','cn01004','s001', 'yes','2008-08-23', '2220.40','15',NULL);
Insert IGNORE into sales_order_details values('on01003','2008-08-12','cn01005','s003', 'yes','2008-08-26', '2220.40','10',NULL);
Insert IGNORE into sales_order_details values('on01004','2008-08-13','cn01004','s001', 'yes','2008-08-20', '2220.40','15',NULL);
Insert IGNORE into sales_order_details values('on01005','2008-08-14','cn01002','s002', 'no','2008-08-30', '2220.40','52', '2008-03-28');
Insert IGNORE into sales_order_details values('on01006','2008-08-15','cn01001','s001', 'yes','2008-08-31', '2220.40','53',NULL);
Insert IGNORE into sales_order_details values('on01007','2008-01-16','cn01003','s004', 'yes','2008-08-28', '2220.40','54',NULL);
Insert IGNORE into sales_order_details values('on01008','2008-02-01','cn01004','s003', 'no','2008-08-28', '8220.40','54', '2008-03-18');

-- a
SELECT client_name, city
FROM client;

-- b
SELECT product_name
FROM salespeople.product;

-- c
SELECT client_name
FROM client
WHERE client_name LIKE "_a%";

-- d
SELECT client_name
FROM client
WHERE city = "TEZPUR";

-- e
SELECT *
FROM product
WHERE sell_price > 2000 AND sell_price <= 5000;

-- f
ALTER TABLE salespeople.product
ADD new_price INT;

-- g
-- ALTER TABLE product
-- CHANGE COLUMN product_rate new_product_rate INT NULL;

-- g BETTER WAY
ALTER TABLE product
RENAME COLUMN product_rate TO new_product_rate;

-- h
SELECT *
FROM salespeople.product
ORDER BY product_description;

-- i 
SELECT sales_order_no, sales_order_date
FROM salespeople.sales_order_details;

-- j
DELETE
FROM salespeople.sales_order_details
WHERE delivery_date < '2008-08-25';

-- k
UPDATE salespeople.sales_order_details
	SET sales_order_date='2016-02-01'
	WHERE sales_order_no='on01008';

-- l
UPDATE salespeople.client
	SET bal_due=1200
	WHERE client_id='cn01003';
	
-- m
SELECT *
FROM salespeople.product
WHERE product_description = 'HDD1034' OR product_description = ' DVDRW';

-- n
SELECT client_name, city, state
FROM salespeople.client
WHERE NOT state = 'ASSAM';

-- o
SELECT *
FROM salespeople.sales_order_details
WHERE cancel_date LIKE '____-03-__';