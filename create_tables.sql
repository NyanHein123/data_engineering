
/* 
Creating the Customer table to record the customer information:
- CUSTOMER_ID: a unique id for each customer
- FIRST_NAME: the first name of the customer
- LAST_NAME: the last name of the customer
- COM_Name: the company name of the customer
- PH_NUM: the phone number of the customer
*/
CREATE TABLE CUSTOMER
(CUSTOMER_ID VARCHAR(10) NOT NULL,
FIRST_NAME VARCHAR(20),
LAST_NAME VARCHAR(20),
COM_NAME VARCHAR(30),
PH_NUM VARCHAR(30),
PRIMARY KEY(CUSTOMER_ID));


/* 
Creating table to record data for employee
- EMPLOYEE_ID: A unique id for each employee as primary key
- FIRST_NAME: the first name of the employee
- LAST_NAME: the last name of the employee
- GENDER: the gender of the employee
- PH_NUM: the phone number of the employee


*/
CREATE TABLE EMPLOYEE
(EMPLOYEE_ID VARCHAR(10) NOT NULL,
FIRST_NAME VARCHAR(20),
LAST_NAME VARCHAR(20),
GENDER CHAR(1),
PH_NUM VARCHAR(30),
PRIMARY KEY(EMPLOYEE_ID));

/* 
Creating DATASET table to record the name of the dataset
which will be used or is used to train the model
- DATASET_ID: A unique id for each dataset(primary key)
- DATASET_NAME: the name of the dataset
*/
CREATE TABLE DATASET(
DATASET_ID VARCHAR(10) NOT NULL PRIMARY KEY,
DATASET_NAME VARCHAR(30));


/* creating table to record model type */
CREATE TABLE MODEL_TYPE(
MODEL_CODE VARCHAR(10) NOT NULL PRIMARY KEY,
TYPENAME VARCHAR(40));

/* 
Creating the MODEL table to record model information. This table includes:
- MODEL_ID: The primary key for the model.
- PAR_MODEL_ID: A foreign key that references MODEL_ID, allowing the table to reference itself(potential to be a parent model).
- COM_DATE: The completion date of the model.
- MODEL_CODE: A foreign key that references MODEL_TYPE, linking each model to a specific model type.
- DATASET_ID: A foreign key that references DATASET, ensuring each model is associated with a single and specific dataset.
- TRN_ACCURACY: The training accuracy of the model, stored as a decimal.
*/
CREATE TABLE MODEL(
MODEL_ID VARCHAR(10) NOT NULL PRIMARY KEY,
PAR_MODEL_ID VARCHAR(10),
COM_DATE DATE,
MODEL_CODE VARCHAR(10) NOT NULL, 
DATASET_ID VARCHAR(10) NOT NULL,
TRN_ACCURACY DECIMAL(3,1),
FOREIGN KEY (PAR_MODEL_ID) REFERENCES MODEL(MODEL_ID),
FOREIGN KEY (DATASET_ID) REFERENCES DATASET(DATASET_ID),
FOREIGN KEY (MODEL_CODE) REFERENCES MODEL_TYPE(MODEL_CODE));

/*
creating table to record the orders

*/
CREATE TABLE ORDERS(
ORDER_ID VARCHAR(10) NOT NULL PRIMARY KEY, 
CMP_DATE DATE NOT NULL,
CUSTOMER_ID VARCHAR(10) NOT NULL,
ORDER_DATE DATE,
REQ_ACCURACY DECIMAL(3,1) NOT NULL,
FOREIGN KEY(CUSTOMER_ID) REFERENCES CUSTOMER(CUSTOMER_ID));

/*
The Req_model_type table is to record  the required models for an order if the customer specified any model types.
*/

CREATE TABLE REQ_MODEL_TYPE(
MODEL_CODE VARCHAR(10) NOT NULL, 
ORDER_ID VARCHAR(10) NOT NULL,
PRIMARY KEY(MODEL_CODE,ORDER_ID),
FOREIGN KEY(MODEL_CODE) REFERENCES MODEL_TYPE(MODEL_CODE),
FOREIGN KEY(ORDER_ID) REFERENCES ORDERS(ORDER_ID));

/* The solution 
table is to record the solution of the orders, 
employee_id specify who gives the solution, which model as a solution,
and which order has solution
*/

CREATE TABLE SOLUTION(
ORDER_ID VARCHAR(10) NOT NULL,
EMPLOYEE_ID VARCHAR(10) NOT NULL,
MODEL_ID VARCHAR(10) NOT NULL,
ASSG_DATE DATE NOT NULL,
PRIMARY KEY(ORDER_ID,EMPLOYEE_ID,MODEL_ID),
FOREIGN KEY(ORDER_ID) REFERENCES ORDERS(ORDER_ID),
FOREIGN KEY(EMPLOYEE_ID) REFERENCES EMPLOYEE(EMPLOYEE_ID),
FOREIGN KEY(MODEL_ID) REFERENCES MODEL(MODEL_ID));

