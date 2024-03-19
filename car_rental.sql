CREATE TABLE Branch
(branch_ID INT PRIMARY KEY,
 branch_name VarChar(50) NOT NULL,
 branch_phone CHAR(10) NOT NULL,
 branch_address VARCHAR(50) NOT NULL,
 branch_city VARCHAR(50) NOT NULL,
 branch_state CHAR(2) NOT NULL,
 branch_zipcode CHAR(5) NOT NULL
);
CREATE TABLE Vehicle_Type
(vehicle_type VARCHAR(15) PRIMARY KEY,
 price_per_day DECIMAL(8,2) NOT NULL 
);
CREATE TABLE Insurance
(insurance_type VARCHAR(15) PRIMARY KEY,
 bodily_coverage DECIMAL(8,2) NOT NULL,
 medical_coverage DECIMAL(8,2) NOT NULL,
 collision_coverage DECIMAL(8,2) NOT NULL
);
CREATE TABLE Rental_Insurance
(vehicle_type VARCHAR(15),
 insurance_type VARCHAR(15),
 insurance_price DECIMAL(8,2) NOT NULL,
 PRIMARY KEY(vehicle_type,insurance_type),
 CONSTRAINT TYPEFK
 FOREIGN KEY (vehicle_type) REFERENCES Vehicle_Type(vehicle_type)
 ON DELETE CASCADE,
 CONSTRAINT INSURANCETYPEFK
 FOREIGN KEY (insurance_type) REFERENCES Insurance(insurance_type)
 ON DELETE CASCADE 
);
CREATE TABLE Customer
(License_No VARCHAR(15) PRIMARY KEY,
 customer_fname VARCHAR(50) NOT NULL,
 customer_lname VARCHAR(50) NOT NULL,
 customer_DOB DATE NOT NULL,
 customer_phone CHAR(10) NOT NULL,
 customer_address VARCHAR(50) NOT NULL,
 customer_city VARCHAR(50) NOT NULL,
 customer_state Char(2) NOT NULL,
 customer_zipcode Char(5) NOT NULL
);
CREATE TABLE Vehicle
(VIN CHAR(17) PRIMARY KEY,
 branch_ID INT NOT NULL,
 vehicle_type VARCHAR(15) NOT NULL,
 vehicle_status VARCHAR(15) NOT NULL,
 seats INT NOT NULL,
 make VARCHAR(20),
 model VARCHAR(20),
 vehicle_year CHAR(4),
 color VARCHAR(10),
 CONSTRAINT VINTYPEFK
 FOREIGN KEY (vehicle_type) REFERENCES Vehicle_Type(vehicle_type)
 ON DELETE CASCADE,
 CONSTRAINT VINBRANCHFK
 FOREIGN KEY (branch_ID) REFERENCES Branch(branch_ID)
 ON DELETE CASCADE 
);
CREATE TABLE Reservation
(reservation_ID INT PRIMARY KEY,
 pickup_date DATE NOT NULL,
 return_date DATE NOT NULL,
 mileage_start INT NOT NULL,
 mileage_end INT,
 rental_amount DECIMAL(8,2) NOT NULL,
 insurance_amount DECIMAL(8,2) NOT NULL,
 reservation_status VARCHAR(10) NOT NULL,
 license_no VARCHAR(15) NOT NULL,
 VIN CHAR(17) NOT NULL,
 insurance_type VARCHAR(15),
 drop_branch_ID INT, 
 CONSTRAINT RESBRANCHFK
 FOREIGN KEY (drop_branch_ID) REFERENCES Branch(branch_ID)
 ON DELETE CASCADE,
 CONSTRAINT RESLICENSEFK
 FOREIGN KEY (license_no) REFERENCES Customer(license_no)
 ON DELETE CASCADE,
 CONSTRAINT VINRESFK
 FOREIGN KEY (VIN) REFERENCES Vehicle(VIN)
 ON DELETE CASCADE,
 CONSTRAINT INSURANCERESFK
 FOREIGN KEY (insurance_type) REFERENCES Insurance(insurance_type)
 ON DELETE CASCADE
);
CREATE TABLE PAYMENT
(payment_ID INT PRIMARY KEY,
 amount DECIMAL(8,2) NOT NULL,
 card_no CHAR(16),
 exp_date DATE,
 name_on_card VARCHAR(50),
 CVV CHAR(3),
 reservation_ID INT NOT NULL,
 cash_payment CHAR(1),
 CONSTRAINT PAYMENTRESERVATIONFK
 FOREIGN KEY (reservation_ID) REFERENCES Reservation(reservation_ID)
 ON DELETE CASCADE
);
CREATE TABLE Add_On_Product
(product_ID INT PRIMARY KEY,
 product_name VARCHAR(15) NOT NULL,
 product_price DECIMAL(8,2) NOT NULL
);
CREATE TABLE Add_Onto
(product_ID INT,
 reservation_ID INT,
 PRIMARY KEY(product_ID,reservation_ID),
 CONSTRAINT ADDRESERVFK
 FOREIGN KEY (reservation_ID) REFERENCES Reservation(reservation_ID)
 ON DELETE CASCADE,
 CONSTRAINT ADDPRODUCTFK
 FOREIGN KEY (product_ID) REFERENCES Add_On_Product(Product_ID)
 ON DELETE CASCADE
);
CREATE TABLE Employee(
emp_ID INT NOT NULL PRIMARY KEY,
branch_ID INT, 
emp_fname VARCHAR (50) NOT NULL, 
emp_lname VARCHAR (50) NOT NULL, 
emp_address VARCHAR(50) NOT NULL,
emp_city VARCHAR (50) NOT NULL,
emp_state VARCHAR (2) NOT NULL,
emp_zipcode CHAR (5) NOT NULL,
salary DECIMAL(12,4),
CONSTRAINT EMPBRANCHFK
FOREIGN KEY(branch_ID) REFERENCES Branch(branch_ID)
ON DELETE CASCADE
);
CREATE TABLE Review
(review_ID INT NOT NULL,
 license_no VarChar(15) NOT NULL,
 rating INT,
 comments VarChar(250),
 PRIMARY KEY(review_ID,License_No),
 CONSTRAINT CUSTREVIEWFK
 FOREIGN KEY (License_No) REFERENCES CAR_USER(License_No)
 ON DELETE CASCADE
);
INSERT INTO Branch(branch_ID,branch_name,branch_phone,branch_address,branch_city,branch_state,branch_zipcode)
VALUES (101,'The Wheel Deal','5129271048','480 Amanda St','Austin','TX',73301);
INSERT INTO Branch(branch_ID,branch_name,branch_phone,branch_address,branch_city,branch_state,branch_zipcode)
VALUES (102,'The Wheel Deal','8014827491','145 Kensington Way','Salt Lake City','UT',84115);
INSERT INTO Branch(branch_ID,branch_name,branch_phone,branch_address,branch_city,branch_state,branch_zipcode)
VALUES (103,'The Wheel Deal','4103817491','9285 Oak Bridge Street','Baltimore','MD',21201);
INSERT INTO Branch(branch_ID,branch_name,branch_phone,branch_address,branch_city,branch_state,branch_zipcode)
VALUES (104,'The Wheel Deal','3125827192','434 Archer Heights Road', 'Chicago','IL',60007);
INSERT INTO Branch(branch_ID,branch_name,branch_phone,branch_address,branch_city,branch_state,branch_zipcode)
VALUES (105,'The Wheel Deal','5103719281','7788 Nob Hill Road', 'San Francisco','CA',94016);
INSERT INTO vehicle_type (vehicle_type,price_per_day) 
VALUES ('Standard',49.95);
INSERT INTO vehicle_type (vehicle_type,price_per_day) 
VALUES ('SUV',89.95);
INSERT INTO vehicle_type (vehicle_type,price_per_day) 
VALUES ('Van',109.95);
INSERT INTO vehicle_type (vehicle_type,price_per_day) 
VALUES ('Luxury',149.95);
INSERT INTO Insurance (insurance_type,bodily_coverage,medical_coverage,collision_coverage) 
VALUES ('Liability',25000.00,25000.00,25000.00);
INSERT INTO Insurance (insurance_type,bodily_coverage,medical_coverage,collision_coverage) 
VALUES ('Personal',50000.00,50000.00,0.00);
INSERT INTO rental_insurance (vehicle_type,insurance_type,insurance_price)
VALUES('Standard','Personal',10.99);
INSERT INTO rental_insurance (vehicle_type,insurance_type,insurance_price)
VALUES('SUV','Personal',12.99);
INSERT INTO rental_insurance (vehicle_type,insurance_type,insurance_price)
VALUES('Van','Personal',14.99);
INSERT INTO rental_insurance (vehicle_type,insurance_type,insurance_price)
VALUES('Luxury','Personal',19.99);
INSERT INTO rental_insurance (vehicle_type,insurance_type,insurance_price)
VALUES('Standard','Liability',19.99);
INSERT INTO rental_insurance (vehicle_type,insurance_type,insurance_price)
VALUES('SUV','Liability',24.99);
INSERT INTO rental_insurance (vehicle_type,insurance_type,insurance_price)
VALUES('Van','Liability',29.99);
INSERT INTO rental_insurance (vehicle_type,insurance_type,insurance_price)
VALUES('Luxury','Liability',49.99);
INSERT INTO customer(License_No,customer_fname,customer_lname,customer_DOB,customer_phone,customer_address,customer_city, customer_state, customer_zipcode)
VALUES('E12905109','Michael','Scott','1961-08-03', '3729182748','633 Manhattan Lane', 'Dallas', 'TX', '75243');
INSERT INTO customer(License_No,customer_fname,customer_lname,customer_DOB,customer_phone,customer_address,customer_city, customer_state, customer_zipcode)
VALUES('C11609103','Jim','Halpert','1977-07-08','2847192846','8532 Garden Lane','Chicopee', 'MA', '01020');
INSERT INTO customer(License_No,customer_fname,customer_lname,customer_DOB,customer_phone,customer_address,customer_city, customer_state, customer_zipcode)
VALUES('G30921561','Phillys','Vance','1992-01-08','8018461928','4 Overlook Drive', 'Winter Park', 'FL', '32792');
INSERT INTO customer(License_No,customer_fname,customer_lname,customer_DOB,customer_phone,customer_address,customer_city, customer_state, customer_zipcode)
VALUES('R12098127','Dwight','Schrute','1983-04-05','9174917284','126 Marshall Street', 'Torrington', 'CT', '06790');
INSERT INTO customer(License_No,customer_fname,customer_lname,customer_DOB,customer_phone,customer_address,customer_city, customer_state, customer_zipcode)
VALUES('M12098127','Pam','Beesly','1993-10-25','5918391846','43 Greenville Road', 'Danville', 'CA', '94507');
INSERT INTO customer(License_No,customer_fname,customer_lname,customer_DOB,customer_phone,customer_address,customer_city, customer_state, customer_zipcode)
VALUES('C42327864','Angela','Martin','1981-07-02','9253891284','4 Piney Ridge Ct', 'Alamo', 'CA', '94506');
INSERT INTO vehicle(VIN,branch_ID,vehicle_type,vehicle_status,seats,make,model,vehicle_year,color)
VALUES('JH4CC2550NC003182',101,'Standard','Available',5,'Ford','Fusion','2015','Grey');
INSERT INTO vehicle(VIN,branch_ID,vehicle_type,vehicle_status,seats,make,model,vehicle_year,color)
VALUES('1FTZR15VXXTB07251',101,'SUV','Available',8,'Ford','Expedition','2012','Black');
INSERT INTO vehicle(VIN,branch_ID,vehicle_type,vehicle_status,seats,make,model,vehicle_year,color)
VALUES('1MEFM53S4XA661641',102,'Standard','Available',5,'Toyota','Camry','2016','Blue');
INSERT INTO vehicle(VIN,branch_ID,vehicle_type,vehicle_status,seats,make,model,vehicle_year,color)
VALUES('ZCFJS7458M1953433',102,'Luxury','Booked',5,'BMW','M550','2014','White');
INSERT INTO vehicle(VIN,branch_ID,vehicle_type,vehicle_status,seats,make,model,vehicle_year,color)
VALUES('JH4DB1550NS000306',103,'Standard','Available',5,'Honda','Civic','2018','Black');
INSERT INTO vehicle(VIN,branch_ID,vehicle_type,vehicle_status,seats,make,model,vehicle_year,color)
VALUES('JH4DB1650MS013392',103,'Van','Booked',15,'Ford','Transit','2014','White');
INSERT INTO vehicle(VIN,branch_ID,vehicle_type,vehicle_status,seats,make,model,vehicle_year,color)
VALUES('1FABP21B4CK165368',104,'Standard','Available',5,'Honda','Accord','2012','Green');
INSERT INTO vehicle(VIN,branch_ID,vehicle_type,vehicle_status,seats,make,model,vehicle_year,color)
VALUES('4F4CR16UXRTM62412',104,'SUV','Booked',7,'SUV','Acura MDX','2014','Blue');
INSERT INTO vehicle(VIN,branch_ID,vehicle_type,vehicle_status,seats,make,model,vehicle_year,color)
VALUES('2G1WL54T4R9165225',105,'Standard','Booked',5,'Chrysler','300','2017','Gold');
INSERT INTO vehicle(VIN,branch_ID,vehicle_type,vehicle_status,seats,make,model,vehicle_year,color)
VALUES('JA3AP57J5SY000719',105,'Luxury','Available',5,'Audi','Q5','2016','White');
INSERT INTO Reservation(reservation_ID,pickup_date,return_date,mileage_start,mileage_end,rental_amount,insurance_amount,reservation_status,License_No,VIN,insurance_type,drop_branch_ID)
VALUES(1,'2022-11-18','2022-11-20',81256,81301,299.9,19.99,'Reserved','E12905109','ZCFJS7458M1953433','Personal',102);
INSERT INTO Reservation(reservation_ID,pickup_date,return_date,mileage_start,mileage_end,rental_amount,insurance_amount,reservation_status,License_No,VIN,insurance_type,drop_branch_ID)
VALUES(2,'2022-11-17','2022-11-21',75413,75890,549.75,14.99,'Reserved','C11609103','JH4DB1650MS013392','Personal',103);
INSERT INTO Reservation(reservation_ID,pickup_date,return_date,mileage_start,mileage_end,rental_amount,insurance_amount,reservation_status,License_No,VIN,insurance_type,drop_branch_ID)
VALUES(3,'2022-11-18','2022-11-23',68430,68652,449.75,24.99,'Reserved','G30921561','4F4CR16UXRTM62412','Liability',104);
INSERT INTO Reservation(reservation_ID,pickup_date,return_date,mileage_start,mileage_end,rental_amount,insurance_amount,reservation_status,License_No,VIN,insurance_type,drop_branch_ID)
VALUES(4,'2022-11-17','2022-11-20',59281,59456,149.85,19.99,'Reserved','R12098127','2G1WL54T4R9165225','Liability',105);
INSERT INTO Reservation(reservation_ID,pickup_date,return_date,mileage_start,mileage_end,rental_amount,insurance_amount,reservation_status,License_No,VIN,insurance_type,drop_branch_ID)
VALUES(5,'2022-10-04','2022-10-06',92148,92234,179.90,12.99,'Completed','M12098127','1FTZR15VXXTB07251','Personal',101);
INSERT INTO Reservation(reservation_ID,pickup_date,return_date,mileage_start,mileage_end,rental_amount,insurance_amount,reservation_status,License_No,VIN,insurance_type,drop_branch_ID)
VALUES(6,'2022-09-15','2022-09-18',78451,78643,149.85,19.99,'Completed','C42327864','JH4DB1550NS000306','Liability',103);
INSERT INTO Employee(emp_ID, branch_ID, emp_fname,emp_lname,emp_address,emp_city,emp_state,emp_zipcode,salary)
VALUES(1001, 101,'Stanley','Hudson','200 Maxberg Street','Austin','TX', '73301','31000');
INSERT INTO Employee(emp_ID, branch_ID, emp_fname,emp_lname,emp_address,emp_city,emp_state,emp_zipcode,salary)
VALUES(1002, 101,'Toby','Flenderson','305 Penn Ave','Austin','TX', '73301','34000');
INSERT INTO Employee(emp_ID, branch_ID, emp_fname,emp_lname,emp_address,emp_city,emp_state,emp_zipcode,salary)
VALUES(1003, 102,'Holly' ,'Flax','16 Stanford Street','Salt Lake City','UT', '84415','30000');
INSERT INTO Employee(emp_ID, branch_ID, emp_fname,emp_lname,emp_address,emp_city,emp_state,emp_zipcode,salary)
VALUES(1004, 103,'Andy' ,'Bernard','1413 Vine Road','Baltimore','MD' ,'21201','33000');
INSERT INTO Employee(emp_ID, branch_ID, emp_fname,emp_lname,emp_address,emp_city,emp_state,emp_zipcode,salary)
VALUES(1005, 103, 'Jan', 'Levinson','1613 Parka Street','Baltimore','MD' ,'21201','36000');
INSERT INTO Employee(emp_ID, branch_ID, emp_fname,emp_lname,emp_address,emp_city,emp_state,emp_zipcode,salary)
VALUES(1006, 104, 'Kevin' ,'Malone','85 Silver Street','Chicago','IL', '60007','37000');
INSERT INTO Employee(emp_ID, branch_ID, emp_fname,emp_lname,emp_address,emp_city,emp_state,emp_zipcode,salary)
VALUES(1007, 105,'Oscar' ,'Martinez','971 Fieldstone Avenue','San Francisco','CA', '94016','32000');
INSERT INTO Review(review_ID, License_No, rating, comments)
VALUES(1, 'M12098127', 5, 'Car was great. We had no issues with the rental');
INSERT INTO Review(review_ID, License_No, rating, comments)
VALUES(2, 'C42327864', 3, 'Overall the rental was good, except the window was jammed.');
INSERT INTO Payment(payment_ID,amount,card_no,exp_date,name_on_card,CVV,reservation_ID,cash_payment)
VALUES(1001,319.89,'1234111122223333','2028-01-25','Angela Martin','123',6,'N');
INSERT INTO Payment(payment_ID,amount,card_no,exp_date,name_on_card,CVV,reservation_ID,cash_payment)
VALUES(1002,564.74,NULL,NULL,NULL,NULL,5,'Y');
INSERT INTO Payment(payment_ID,amount,card_no,exp_date,name_on_card,CVV,reservation_ID,cash_payment)
VALUES(1003,474.74,NULL,NULL,NULL,NULL,1,'Y');
INSERT INTO Payment(payment_ID,amount,card_no,exp_date,name_on_card,CVV,reservation_ID,cash_payment)
VALUES(1004,169.84,'1234567811112222','2030-05-05','Jim Halpert','456',2,'N');
INSERT INTO Payment(payment_ID,amount,card_no,exp_date,name_on_card,CVV,reservation_ID,cash_payment)
VALUES(1005,192.89,NULL,NULL,NULL,NULL,3,'Y');
INSERT INTO Payment(payment_ID,amount,card_no,exp_date,name_on_card,CVV,reservation_ID,cash_payment)
VALUES(1006,169.84,NULL,NULL,NULL,NULL,4,'Y');
INSERT INTO add_on_product(product_ID,product_name,product_price)
VALUES(1,'GPS Navigation',49.95);
INSERT INTO add_on_product(product_ID,product_name,product_price)
VALUES(2,'Ski Rack',15.95);
INSERT INTO add_on_product(product_ID,product_name,product_price)
VALUES(3,'Snow Chains',10.95);
INSERT INTO add_on_product(product_ID,product_name,product_price)
VALUES(4,'Baby Seater',29.95);
INSERT INTO add_onto(product_ID,reservation_ID)
VALUES(3,1);
INSERT INTO add_onto(product_ID,reservation_ID)
VALUES(2,1);
INSERT INTO add_onto(product_ID,reservation_ID)
VALUES(4,4);