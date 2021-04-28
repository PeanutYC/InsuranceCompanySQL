# Create tables
# Employee Table
CREATE TABLE  "EMPLOYEE" 
   (	"EMP_ID" NUMBER NOT NULL ENABLE, 
	"EMP_NAME" VARCHAR2(50) NOT NULL ENABLE, 
	"EMP_IC" NUMBER NOT NULL ENABLE, 
	"EMP_ADDR" VARCHAR2(255) NOT NULL ENABLE, 
	"EMP_TEL" NUMBER NOT NULL ENABLE, 
	"EMP_EMAIL" VARCHAR2(100) NOT NULL ENABLE, 
	"EMP_TYPE" VARCHAR2(50) NOT NULL ENABLE, 
	"EMP_DATEJOIN" DATE NOT NULL ENABLE, 
	 CONSTRAINT "EMP_PK" PRIMARY KEY ("EMP_ID")
  USING INDEX  ENABLE, 
	 CONSTRAINT "EMPIC" UNIQUE ("EMP_IC")
  USING INDEX  ENABLE, 
	 CONSTRAINT "EMP_CK" CHECK (length(emp_ic) = 12) ENABLE, 
	 CONSTRAINT "PHONE_CK" CHECK (length(emp_tel) < 12) ENABLE
   )
/

# Customer Table
CREATE TABLE  "CUSTOMER" 
   (	"CUST_ID" NUMBER NOT NULL ENABLE, 
	"CUST_NAME" VARCHAR2(50) NOT NULL ENABLE, 
	"CUST_IC" NUMBER NOT NULL ENABLE, 
	"CUST_ADDR" VARCHAR2(255) NOT NULL ENABLE, 
	"CUST_TEL" NUMBER NOT NULL ENABLE, 
	"CUST_EMAIL" VARCHAR2(100) NOT NULL ENABLE, 
	"EMP_ID" NUMBER NOT NULL ENABLE, 
	 CONSTRAINT "CUSTOMER_PK" PRIMARY KEY ("CUST_ID")
  USING INDEX  ENABLE, 
	 CONSTRAINT "CUSTIC" UNIQUE ("CUST_IC")
  USING INDEX  ENABLE, 
	 CONSTRAINT "CUST_CK" CHECK (length(cust_ic) = 12) ENABLE, 
	 CONSTRAINT "CUSTTEL_CK" CHECK (length(cust_tel) <12) ENABLE
   )
/
ALTER TABLE  "CUSTOMER" ADD FOREIGN KEY ("EMP_ID")
	  REFERENCES  "EMPLOYEE" ("EMP_ID") ENABLE
/

# Sales Table
create table Sales( 
    sales_id number not null constraint sales_pk primary key, 
    sales_name varchar2(50) not null,
    date_purchase varchar2(200) not null,
    sales_premium varchar2(200) not null,
    emp_id number not null,  
    foreign key (emp_id) references Employee(emp_id)  
)

# Training Table
CREATE TABLE Training ( 
    train_code number not null constraint training_pk primary key, 
    train_date DATE not null, 
    train_time varchar2(20) not null, 
    train_topic varchar2(100) not null 
)


# Manager Table
create table Manager(  
    manager_id number not null constraint manager_pk primary key,  
    manager_position varchar2(50) not null, 
    emp_id number not null,  
    foreign key (emp_id) references Employee(emp_id)  
)

# Agent Table
create table Agent(  
    agent_id number not null constraint agent_pk primary key,  
    agent_ranking number not null, 
    emp_id number not null,  
    foreign key (emp_id) references Employee(emp_id)  
)

ALTER TABLE Agent
ADD CONSTRAINT agent_r UNIQUE(agent_ranking);

# Product Table
create table Product(  
    product_id number not null constraint product_pk primary key,  
    product_name varchar2(255) not null, 
    product_des varchar2(350) not null,
    product_launchDate date not null
)
ALTER TABLE Product
ADD CONSTRAINT pro_name UNIQUE(product_name);

# Policy Table
create table Policy(  
    policy_no number not null constraint policy_pk primary key, 
    insured_name varchar2(50) not null, 
    sum_assured number(*,2) not null,
    insurance_type varchar2(50) not null,
    insurance_status varchar2(50) not null,
    cust_id number,
    product_id number,
    CONSTRAINT cust_fk FOREIGN KEY (cust_id) REFERENCES Customer(cust_id),
    CONSTRAINT prod_fk FOREIGN KEY (product_id) REFERENCES Product(product_id)
)

# Payment Table
create table Payment(  
    pay_no number not null constraint trans_pk primary key, 
    pay_date date not null,
    pay_amount number(*,2) not null,
    cust_id number,
    policy_no number,
    CONSTRAINT cus_fk FOREIGN KEY (cust_id) REFERENCES Customer(cust_id),
    CONSTRAINT policy_fk FOREIGN KEY (policy_no) REFERENCES Policy(policy_no)
);

# Claim Table
create table Claim(  
    claim_id number not null constraint claim_pk primary key, 
    claim_date date not null,
    claim_amount number(*,2) not null,
    cust_id number,
    policy_no number,
    CONSTRAINT fk_cust FOREIGN KEY (cust_id) REFERENCES Customer(cust_id),
    CONSTRAINT fk_policy FOREIGN KEY (policy_no) REFERENCES Policy(policy_no)
);

# Bridge Entities
# Enroll
CREATE TABLE  "ENROLL" 
   (	"TRAIN_CODE" NUMBER NOT NULL ENABLE, 
	"EMP_ID" NUMBER NOT NULL ENABLE, 
	 PRIMARY KEY ("TRAIN_CODE", "EMP_ID")
  USING INDEX  ENABLE
   )
/
ALTER TABLE  "ENROLL" ADD CONSTRAINT "EN_FK1" FOREIGN KEY ("TRAIN_CODE")
	  REFERENCES  "TRAINING" ("TRAIN_CODE") ON DELETE CASCADE ENABLE
/
ALTER TABLE  "ENROLL" ADD CONSTRAINT "EN_FK2" FOREIGN KEY ("EMP_ID")
	  REFERENCES  "EMPLOYEE" ("EMP_ID") ON DELETE CASCADE ENABLE
/

# Supervise
CREATE TABLE  "SUPERVISE" 
   (	"MANAGER_ID" NUMBER, 
	"AGENT_ID" NUMBER, 
	 PRIMARY KEY ("MANAGER_ID", "AGENT_ID")
  USING INDEX  ENABLE
   )
/
ALTER TABLE  "SUPERVISE" ADD CONSTRAINT "FK_AGENT" FOREIGN KEY ("AGENT_ID")
	  REFERENCES  "AGENT" ("AGENT_ID") ON DELETE CASCADE ENABLE
/
ALTER TABLE  "SUPERVISE" ADD CONSTRAINT "FK_MANAGER" FOREIGN KEY ("MANAGER_ID")
	  REFERENCES  "MANAGER" ("MANAGER_ID") ON DELETE CASCADE ENABLE
/

# Sell
CREATE TABLE  "SELL" 
   (	"PRODUCT_ID" NUMBER, 
	"EMP_ID" NUMBER, 
	 PRIMARY KEY ("PRODUCT_ID", "EMP_ID")
  USING INDEX  ENABLE
   )
/
ALTER TABLE  "SELL" ADD CONSTRAINT "EMP_FK" FOREIGN KEY ("EMP_ID")
	  REFERENCES  "EMPLOYEE" ("EMP_ID") ON DELETE CASCADE ENABLE
/
ALTER TABLE  "SELL" ADD CONSTRAINT "PRODUCT_FK" FOREIGN KEY ("PRODUCT_ID")
	  REFERENCES  "PRODUCT" ("PRODUCT_ID") ON DELETE CASCADE ENABLE
    
    
    
# Queries

Insert Data Statements
/* Employee */
INSERT ALL
	INTO Employee(emp_id, emp_name, emp_ic, emp_addr, emp_tel, emp_email, emp_type, emp_dateJoin) VALUES (001, 'Isaac', 860101073829, 'Baker Street', 0123456789, 'issac@gmail.com', 'manager', DATE '1999-01-01')
	INTO Employee(emp_id, emp_name, emp_ic, emp_addr, emp_tel, emp_email, emp_type, emp_dateJoin) VALUES (002, 'Aha', 881101083729, 'Maiden Land', 7112659193, 'aha@yahoo.com', 'manager', DATE '2009-04-01')
	INTO Employee(emp_id, emp_name, emp_ic, emp_addr, emp_tel, emp_email, emp_type, emp_dateJoin) VALUES (003, 'Ahmad', 870101073820, 'Pearl Street', 5145318471, 'ahmad@gmail.com', 'agent' , DATE '2008-03-03')
	INTO Employee(emp_id, emp_name, emp_ic, emp_addr, emp_tel, emp_email, emp_type, emp_dateJoin) VALUES (004, 'Kacy', 760101083829, 'Wall Street', 6204541799, 'kacy@hotmail.com', 'agent', DATE '2020-12-10')
	INTO Employee(emp_id, emp_name, emp_ic, emp_addr, emp_tel, emp_email, emp_type, emp_dateJoin) VALUES (005, 'Sabastian', 660101102429, 'Broadway', 5199784733, 'sabas3@gmail.com', 'manager', DATE '2007-08-09')
	INTO Employee(emp_id, emp_name, emp_ic, emp_addr, emp_tel, emp_email, emp_type, emp_dateJoin) VALUES (006, 'Dalen', 770101083829, 'Houston Street', 6758447400, 'dalen2@gmail.com', 'agent', DATE '2015-11-22')
    INTO Employee(emp_id, emp_name, emp_ic, emp_addr, emp_tel, emp_email, emp_type, emp_dateJoin) VALUES (007, 'Ereka', 700428309293, 'Ronald Street', 0187762093, 'ereka870@gmail.com', 'agent', DATE '1998-02-01')
    INTO Employee(emp_id, emp_name, emp_ic, emp_addr, emp_tel, emp_email, emp_type, emp_dateJoin) VALUES (008, 'Henry', 882307084923, 'Voltaire Road', 072340987, 'henry2@yahoo.com', 'agent', DATE '2007-04-01')
SELECT * FROM DUAL

INSERT INTO Employee(emp_id, emp_name, emp_ic, emp_addr, emp_tel, emp_email, emp_type, emp_dateJoin) VALUES (035, 'HoHo', 780502938482, 'Allen Way', 0230495812, 'hoho@lion.com', 'agent', DATE '2020-11-04');


/*Manager*/
INSERT ALL
    INTO Manager(manager_id, manager_position, emp_id) VALUES (01,'District Manager', 001)
    INTO Manager(manager_id, manager_position, emp_id) VALUES (02,'Unit Manager', 002)
    INTO Manager(manager_id, manager_position, emp_id) VALUES (03,'Unit Manager', 005)
SELECT * FROM DUAL

/*Agent*/
INSERT ALL
    INTO Agent(agent_id, agent_ranking, emp_id) VALUES (01,3, 003)
    INTO Agent(agent_id, agent_ranking, emp_id) VALUES (02,1, 004)
    INTO Agent(agent_id, agent_ranking, emp_id) VALUES (03,2, 006)
    INTO Agent(agent_id, agent_ranking, emp_id) VALUES (04,5, 007)
    INTO Agent(agent_id, agent_ranking, emp_id) VALUES (05,4, 008)
    INTO Agent(agent_id, agent_ranking, emp_id) VALUES (06,6, 035)
SELECT * FROM DUAL


/* CUSTOMER */
INSERT ALL
	INTO Customer(cust_id, cust_name, cust_ic, cust_addr, cust_tel, cust_email, emp_id) VALUES (0001, 'Ali', 860101073829, 'Baker Street', 0123456789, 'ali@gmail.com', 002)
	INTO Customer(cust_id, cust_name, cust_ic, cust_addr, cust_tel, cust_email, emp_id)  VALUES (0002, 'Jason', 881101083729, 'Maiden Land', 7112659193, 'jason@yahoo.com', 003)
	INTO Customer(cust_id, cust_name, cust_ic, cust_addr, cust_tel, cust_email, emp_id)  VALUES (0003, 'Lee', 870101073820, 'Pearl Street', 5145318471, 'lee@gmail.com', 006)
	INTO Customer(cust_id, cust_name, cust_ic, cust_addr, cust_tel, cust_email, emp_id) VALUES (0004, 'Kacy', 760101083829, 'Wall Street', 6204541799, 'kacy@gmail.com', 003)
	INTO Customer(cust_id, cust_name, cust_ic, cust_addr, cust_tel, cust_email, emp_id) VALUES (0005, 'Hebe', 660101102429, 'Broadway', 5199784733, 'hebe@gmail.com', 005)
SELECT * FROM dual;  

/*Training */  
INSERT ALL
	INTO Training(train_code, train_date, train_time, train_topic) VALUES (001, DATE '2019-08-07', '10.00 AM', 'Digital Marketing')
	INTO Training(train_code, train_date, train_time, train_topic) VALUES (002, DATE '2019-09-01', '10.00 AM', 'Sales')
    	INTO Training(train_code, train_date, train_time, train_topic) VALUES (003, DATE '2019-07-05', '10.00 AM', 'Communication')
    	INTO Training(train_code, train_date, train_time, train_topic) VALUES (004, DATE '2019-05-05', '10.00 AM', 'English')
INTO Training(train_code, train_date, train_time, train_topic) VALUES (1005, DATE '2019-11-12', '10.00 AM', 'Life Protection')
    	INTO Training(train_code, train_date, train_time, train_topic) VALUES (1006, DATE '2019-09-09', '10.00 AM', 'Medical Protection')
 	INTO Training(train_code, train_date, train_time, train_topic) VALUES (1007, DATE '2019-04-05', '10.00 AM', 'Accident Protection')
    	INTO Training(train_code, train_date, train_time, train_topic) VALUES (1008, DATE '2019-09-05', '10.00 AM', 'Motor Insurance')
    	INTO Training(train_code, train_date, train_time, train_topic) VALUES (1009, DATE '2019-12-11', '10.00 AM', 'Savings and Investment')
    	INTO Training(train_code, train_date, train_time, train_topic) VALUES (1010, DATE '2019-10-11', '10.00 AM', 'Critical Illness Protection')
SELECT * FROM dual;

/*Enroll*/
INSERT ALL
    INTO Enroll (train_code, emp_id) values (1001,001)
    INTO Enroll (train_code, emp_id) values (1001,002)
    INTO Enroll (train_code, emp_id) values (1001,005)
    INTO Enroll (train_code, emp_id) values (1002,001)
    INTO Enroll (train_code, emp_id) values (1002,002)
    INTO Enroll (train_code, emp_id) values (1002,003)
    INTO Enroll (train_code, emp_id) values (1002,004)
    INTO Enroll (train_code, emp_id) values (1002,005)
    INTO Enroll (train_code, emp_id) values (1002,006)
    INTO Enroll (train_code, emp_id) values (1005,007)
    INTO Enroll (train_code, emp_id) values (1005,008)
    INTO Enroll (train_code, emp_id) values (1006,007)
    INTO Enroll (train_code, emp_id) values (1006,008)
SELECT * FROM dual;
 
 
/*Product*/
INSERT ALL
    INTO Product(product_id, product_name, product_des, product_launchDate) VALUES (001, 'Product A', 'Des A', DATE'2000-01-01')
    INTO Product(product_id, product_name, product_des, product_launchDate) VALUES (002, 'Product B', 'Des B', DATE'2000-03-01')
    INTO Product(product_id, product_name, product_des, product_launchDate) VALUES (003, 'Product C', 'Des C', DATE'2000-04-01')
    INTO Product(product_id, product_name, product_des, product_launchDate) VALUES (004, 'Product D', 'Des D', DATE'2002-05-01')
    INTO Product(product_id, product_name, product_des, product_launchDate) VALUES (005, 'Product E', 'Des E', DATE'2003-06-01')
SELECT * FROM DUAL
 
/*Policy*/
INSERT ALL 
    INTO Policy (policy_no, insured_name, sum_assured, insurance_type, insurance_status, cust_id) VALUES (0001, 'Hwang', 1000000, 'life', 'active',0001)
    INTO Policy (policy_no, insured_name, sum_assured, insurance_type, insurance_status, cust_id) VALUES (0002, 'Keng', 1250000, 'health', 'active',0002)
SELECT * FROM DUAL;
 
INSERT INTO Policy(policy_no, insured_name, sum_assured, insurance_type, insurance_status, cust_id, product_id) values (003, 'Ilishah', 5000000, 'life', 'expired', 004, 1)
 
INSERT INTO Policy(policy_no, insured_name, sum_assured, insurance_type, insurance_status, cust_id, product_id) values (004, 'Kalis', 1200000, 'health', 'expired', 003, 3)
 
INSERT INTO Policy(policy_no, insured_name, sum_assured, insurance_type, insurance_status, cust_id, product_id) values (005, 'Kayvan', 1250000, 'car', 'expired', 006, 4)
 
 
/*Payment*/
INSERT ALL 
    INTO Payment (pay_no, pay_date, pay_amount, cust_id, policy_no) VALUES (0001, DATE '2019-08-05', 1500, 0001, 0001)
    INTO Payment (pay_no, pay_date, pay_amount, cust_id, policy_no) VALUES (0002, DATE '2019-10-15', 2000, 0001, 0001)
    INTO Payment (pay_no, pay_date, pay_amount, cust_id, policy_no) VALUES (0003, DATE '2019-10-16', 3000, 0002, 0002)
SELECT * FROM DUAL;
 
/*Sales*/
INSERT ALL
    INTO Sales (sales_id, sales_name, date_purchase, sales_premium, emp_id) values (001, 'Sales A', DATE'2018-05-05', 10500, 001)
    INTO Sales (sales_id, sales_name, date_purchase, sales_premium, emp_id) values (002, 'Sales B', DATE'2018-06-05', 10500, 001)
    INTO Sales (sales_id, sales_name, date_purchase, sales_premium, emp_id) values (003, 'Sales C', DATE'2018-06-15', 10500, 003)
    INTO Sales (sales_id, sales_name, date_purchase, sales_premium, emp_id) values (004, 'Sales D', DATE'2018-07-12', 10500, 002)
    INTO Sales (sales_id, sales_name, date_purchase, sales_premium, emp_id) values (005, 'Sales E', DATE'2018-07-20', 10500, 003)
SELECT * FROM DUAL
 
/*Claim*/
INSERT ALL
    INTO Claim(claim_id, claim_date, claim_amount, cust_id, policy_no) VALUES (001, Date'2008-01-05', 12500, 001, 001)
    INTO Claim(claim_id, claim_date, claim_amount, cust_id, policy_no) VALUES (002, Date'2010-03-15', 5500, 002, 002)
    INTO Claim(claim_id, claim_date, claim_amount, cust_id, policy_no) VALUES (003, Date'2015-05-01', 500, 003, 004)
    INTO Claim(claim_id, claim_date, claim_amount, cust_id, policy_no) VALUES (004, Date'2015-07-20', 300, 003, 004)
 
SELECT * FROM DUAL
 
/*Supervise*/
INSERT ALL
    INTO Supervise(manager_id,agent_id) values (1,1)
    INTO Supervise(manager_id,agent_id) values (2,2)
    INTO Supervise(manager_id,agent_id) values (3,3)
SELECT * FROM DUAL
 
/*Sell*/
INSERT ALL
    INTO Sell(product_id, emp_id) values (1,3)
    INTO Sell(product_id, emp_id) values (5,6)
    INTO Sell(product_id, emp_id) values (2,4)
    INTO Sell(product_id, emp_id) values (4,1)
    INTO Sell(product_id, emp_id) values (3,5)
SELECT * FROM DUAL
 
INSERT ALL
    INTO Sell (product_id, emp_id) values (1,1)
    INTO Sell (product_id, emp_id) values (1,2)
    INTO Sell (product_id, emp_id) values (2,1)
    INTO Sell (product_id, emp_id) values (2,3)
SELECT * FROM dual;

# Query Statements 
# View employees enrolled training with training topic
SELECT Employee.emp_name, Enroll.train_code, Training.train_topic
FROM Enroll
INNER JOIN Employee ON Enroll.emp_id = Employee.emp_id
INNER JOIN Training ON Enroll.train_code = Training.train_code
ORDER BY Enroll.emp_id ASC
 
# Total customer transaction 
SELECT customer.cust_name, SUM(payment.pay_amount) AS pay_total
FROM Customer
INNER JOIN Payment ON payment.cust_id = customer.cust_id
GROUP BY customer.cust_name

# Update agent ranking
UPDATE Agent
SET agent_ranking = CASE agent_id
WHEN 1 THEN 1
WHEN 2 THEN 3
WHEN 3 THEN 2
END
WHERE agent_id BETWEEN 1 AND 3
 
# View customer serviced by (verified)
SELECT customer.cust_name, employee.emp_name, employee.emp_type
FROM Employee
INNER JOIN customer ON customer.emp_id = employee.emp_id
ORDER BY customer.cust_id ASC
 
# Add new customer details
INSERT ALL
	INTO Customer(cust_id, cust_name, cust_ic, cust_addr, cust_tel, cust_email, emp_id) VALUES (0006, 'Lang',800320073928 , 'Berklyn Street', 064837615, 'lang80@yahoo.com', 006)
	INTO Customer(cust_id, cust_name, cust_ic, cust_addr, cust_tel, cust_email, emp_id) VALUES (0007, 'Mark', 700102074921, 'Broadway', 0183945739, 'markHunter@gmail.com', 004)
INTO Customer(cust_id, cust_name, cust_ic, cust_addr, cust_tel, cust_email, emp_id) VALUES (0008, 'Yow', 980203109388, 'Pahang road', 01042830948, 'yow00@hotmail.com', 002)
SELECT * FROM dual;  

# Assign new agent to the customer (verified)
UPDATE Customer
SET emp_id = 1
WHERE cust_id = 1

# Show policy with insurance status ‘expired’ (verified)
SELECT policy.policy_no, customer.cust_id, customer.cust_name
FROM Policy
INNER JOIN Customer ON policy.cust_id = customer.cust_id
WHERE policy.insurance_status = 'expired'
ORDER BY cust_id ASC
 
# Delete
DELETE FROM Employee
WHERE emp_id = 35;
 
# Display when to when (payment)
SELECT payment.pay_date, customer.cust_name, payment.pay_amount 
FROM Payment
INNER JOIN CUSTOMER ON Payment.cust_id = Customer.cust_id
WHERE PAY_DATE 
BETWEEN '10-01-2019' AND '10-31-2019';
 
# View monthly sales of agents
SELECT sales.date_purchase, employee.emp_id, employee.emp_name, SUM(sales.sales_premium) AS "Total Sales"
FROM Sales
INNER JOIN Employee ON sales.emp_id = employee.emp_id
WHERE sales.date_purchase BETWEEN DATE'2018-07-01' AND DATE'2018-07-31'
GROUP BY sales.date_purchase, employee.emp_id,employee.emp_name
 
# View total monthly sales
SELECT SUM(sales_premium) AS "Total Sales"
FROM sales
WHERE date_purchase BETWEEN DATE '2018-06-01' AND DATE '2018-06-30'

