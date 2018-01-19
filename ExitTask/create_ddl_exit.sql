--*******************
-- Exit task
--*******************
-- STAGE LEVEL
--*******************
CREATE TABLE scott.stage_customers
  (
    ID            NUMBER(10) NOT NULL,
    NAME          VARCHAR2(100 BYTE) NOT NULL,
    username      VARCHAR2(100 BYTE),
    email         VARCHAR2(100 BYTE),
    dateofbirth   DATE,
    streetaddress VARCHAR2(150 BYTE),
    city          VARCHAR2(100 BYTE),
    country       VARCHAR2(100 BYTE),
    zip           VARCHAR2(20 BYTE),
    state         VARCHAR2(10 BYTE) NOT NULL,
    phone         VARCHAR2(20 BYTE) NOT NULL
  );
--*******************
CREATE TABLE scott.stage_products
  (
    products               NUMBER(10)NOT NULL,
    productname            VARCHAR2(200 BYTE) NOT NULL,
    companyname            VARCHAR2(200 BYTE) NOT NULL,
    price                  NUMBER(25,2) NOT NULL,
    warehouselocationstate VARCHAR2(10 BYTE) NOT NULL
  );
--*******************
CREATE TABLE scott.stage_payments
  (
    paymentid        NUMBER(10) NOT NULL,
    customerid       NUMBER(10) NOT NULL,
    productid        NUMBER(10) NOT NULL,
    transactiondate  DATE NOT NULL,
    creditcard       VARCHAR2(12 BYTE),
    creditcardnumber VARCHAR2(19 BYTE)
  );
--*******************
CREATE TABLE scott.stage_pay_list
  ( file_payments VARCHAR2(150 BYTE)
  );
--*******************
-- DWH LEVEL
--*******************
CREATE SEQUENCE scott.sqn_dwh_customers MINVALUE 1 MAXVALUE 9999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER NOCYCLE nopartition ;
CREATE SEQUENCE scott.sqn_dwh_products MINVALUE 1 MAXVALUE 9999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER NOCYCLE nopartition ;
CREATE SEQUENCE scott.sqn_dwh_payments MINVALUE 1 MAXVALUE 9999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER NOCYCLE nopartition ;
CREATE SEQUENCE scott.sqn_dwh_error_payments MINVALUE 1 MAXVALUE 9999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER NOCYCLE nopartition ;
--*******************
CREATE TABLE scott.dwh_customers
    (
      surr_id       NUMBER(10) PRIMARY KEY,
      ID            NUMBER(10) NOT NULL,
      NAME          VARCHAR2(100 BYTE) NOT NULL,
      username      VARCHAR2(100 BYTE),
      email         VARCHAR2(100 BYTE),
      dateofbirth   DATE,
      streetaddress VARCHAR2(150 BYTE),
      city          VARCHAR2(100 BYTE),
      country       VARCHAR2(100 BYTE),
      zip           VARCHAR2(20 BYTE),
      state         VARCHAR2(10 BYTE) NOT NULL,
      phone         VARCHAR2(20 BYTE) NOT NULL
    );
--*******************
CREATE TABLE scott.dwh_products
    (
      surr_id                NUMBER(10) PRIMARY KEY,
      products               NUMBER(10) NOT NULL,
      productname            VARCHAR2(200 BYTE) NOT NULL,
      companyname            VARCHAR2(200 BYTE) NOT NULL,
      price                  NUMBER(25,2) NOT NULL,
      warehouselocationstate VARCHAR2(10 BYTE) NOT NULL
    );
--*******************
 CREATE TABLE scott.dwh_fct_payments
    (
      surr_id          NUMBER(10) PRIMARY KEY,
      paymentid        NUMBER(10) NOT NULL,
      customerid       NUMBER(10) NOT NULL,
      productid        NUMBER(10) NOT NULL,
      transactiondate  DATE NOT NULL,
      price            NUMBER(25,2) NOT NULL,
      creditcard       VARCHAR2(12 BYTE) NOT NULL,
      creditcardnumber VARCHAR2(19 BYTE) NOT NULL,
      isinterstate     NUMBER(1),
      CONSTRAINT fk_customer
        FOREIGN KEY (customerid)
        REFERENCES dwh_customers(surr_id),
      CONSTRAINT fk_supplier
       FOREIGN KEY (productid)
       REFERENCES dwh_products(surr_id)
    );
--*******************
  CREATE TABLE scott.dwh_error_payments
    (
      surr_id          NUMBER(10) PRIMARY KEY,
      paymentid        NUMBER(10),
      customerid       NUMBER(10),
      productid        NUMBER(10),
      transactiondate  DATE,
      creditcard       VARCHAR2(12 BYTE),
      creditcardnumber VARCHAR2(19 BYTE),
      errormessage     VARCHAR2(255 BYTE)
    );
 
  