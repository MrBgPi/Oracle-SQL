DROP TABLE RCV_Vacation_Tour_Destination;
DROP TABLE RCV_Customer_Vacation;
DROP TABLE RCV_Agent_Training;
DROP TABLE RCV_Destination;
DROP TABLE RCV_Training;
DROP TABLE RCV_Vacation_Tour;
DROP TABLE RCV_Customer;
DROP TABLE RCV_Rating;
DROP TABLE RCV_Agent;

CREATE TABLE RCV_Customer (
    customer_number NUMBER NOT NULL,
    customer_first_name VARCHAR2(20) NOT NULL,
    customer_last_name VARCHAR2(20) NOT NULL,
    customer_phone_number NUMBER(10) NOT NULL,
    customer_street_address VARCHAR2(20) NOT NULL,
    customer_customer_city CHAR(2) NOT NULL,
    customer_province CHAR(2) NOT NULL,
    customer_postal_code VARCHAR2(6) NOT NULL,
    agent_ID NUMBER
);

CREATE TABLE RCV_Vacation_Tour (
    vacation_code NUMBER NOT NULL,
    vacation_description VARCHAR2(20),
    vacation_region CHAR(2) NOT NULL,
    agent_ID NUMBER,
    rating_id NUMBER
);

CREATE TABLE RCV_Customer_Vacation (
    customer_number NUMBER NOT NULL,
    vacation_code NUMBER NOT NULL
);

CREATE TABLE RCV_Rating (
    rating_id NUMBER NOT NULL,
    rating_description VARCHAR2(20),
    rating_code CHAR(1) NOT NULL
);

CREATE TABLE RCV_Agent (
    agent_ID NUMBER NOT NULL,
    agent_first_name VARCHAR2(20) NOT NULL,
    agent_last_name VARCHAR2(20) NOT NULL,
    agent_years_experience NUMBER(2) NOT NULL,
    agent_specialty VARCHAR(10) NOT NULL,
    agent_level VARCHAR(3) NOT NULL
);

CREATE TABLE RCV_Training (
    training_code NUMBER NOT NULL,
    training_description VARCHAR2(30) NOT NULL,
    training_hour INTEGER NOT NULL
);

CREATE TABLE RCV_Agent_Training (
    agent_ID NUMBER NOT NULL,
    training_code NUMBER NOT NULL,
    training_date_completed DATE NOT NULL
);

CREATE TABLE RCV_Destination (
    dest_code NUMBER,
    dest_city VARCHAR2(10) NOT NULL,
    dest_state CHAR(2) NOT NULL,
    dest_country CHAR(2) NOT NULL
);

CREATE TABLE RCV_Vacation_Tour_Destination (
    vacation_code NUMBER NOT NULL,
    dest_code NUMBER NOT NULL
);


--primary key--
ALTER TABLE RCV_Vacation_Tour
ADD CONSTRAINT RCV_Vacation_Tour_vacation_code_PK PRIMARY KEY (vacation_code);
ALTER TABLE RCV_Customer
ADD CONSTRAINT RCV_Customer_number_PK PRIMARY KEY (customer_number);
ALTER TABLE RCV_Destination
ADD CONSTRAINT RCV_Destination_dest_code PRIMARY KEY (dest_code);
ALTER TABLE RCV_Rating
ADD CONSTRAINT RCV_Rating_vacation_code PRIMARY KEY (rating_id);
ALTER TABLE RCV_Training
ADD CONSTRAINT RCV_Training_code PRIMARY KEY (training_code);
ALTER TABLE RCV_Agent
ADD CONSTRAINT RCV_agent_id PRIMARY KEY (agent_ID);

-- FOREIGN KEYS
-- RCV_Customer_Vacation
ALTER TABLE RCV_Customer_Vacation
ADD CONSTRAINT RCV_Customer_Vacation_Customer_FK FOREIGN KEY (customer_number) REFERENCES RCV_Customer(customer_number);
ALTER TABLE RCV_Customer_Vacation
ADD CONSTRAINT RCV_Customer_Vacation_Tour_FK FOREIGN KEY (vacation_code) REFERENCES RCV_Vacation_Tour(vacation_code);

-- RCV_Vacation_Tour
ALTER TABLE RCV_Vacation_Tour
ADD CONSTRAINT RCV_Agent_Vacation_Tour_FK FOREIGN KEY (agent_ID) REFERENCES RCV_Agent(agent_ID);
ALTER TABLE RCV_Vacation_Tour
ADD CONSTRAINT RCV_Rating_Vacation_Tour_FK FOREIGN KEY (rating_id) REFERENCES RCV_Rating(rating_id);

-- RCV_Vacation_Tour_Destination
ALTER TABLE RCV_Vacation_Tour_Destination
ADD CONSTRAINT RCV_Vacation_Tour_Destination_Vacation_Tour_FK FOREIGN KEY (vacation_code) REFERENCES RCV_Vacation_Tour(vacation_code);
ALTER TABLE RCV_Vacation_Tour_Destination
ADD CONSTRAINT RCV_Vacation_Tour_Destination_Destination_FK FOREIGN KEY (dest_code) REFERENCES RCV_Destination(dest_code);

-- RCV_Agent_Training
ALTER TABLE RCV_Agent_Training
ADD CONSTRAINT RCV_Agent_Agent_Training_FK FOREIGN KEY (agent_id) REFERENCES RCV_Agent(agent_id);
ALTER TABLE RCV_Agent_Training
ADD CONSTRAINT RCV_Training_Agent_Training_FK FOREIGN KEY (training_code) REFERENCES RCV_Training(training_code);

-- RCV_Customer
ALTER TABLE RCV_Customer
ADD CONSTRAINT RCV_Customer_Agent_FK FOREIGN KEY (agent_id) REFERENCES RCV_Agent(agent_id);


-- CONSTRAINTS
ALTER TABLE RCV_Customer
ADD CONSTRAINT RCV_Customer_customer_province_CK CHECK (customer_province IN ('BC','AB','SK','MB','ON','QC','NB','NS','NL','NT','NU','PE','YT'));
ALTER TABLE RCV_Rating
ADD CONSTRAINT RCV_Rating_rating_code_CK CHECK (rating_code IN ('E','M','B','X'));
ALTER TABLE RCV_Vacation_Tour
ADD CONSTRAINT RCV_Vacation_Tour_vacation_region_CK CHECK (vacation_region IN ('CA','US','EU'));
ALTER TABLE RCV_Agent
ADD CONSTRAINT RCV_Agent_agent_years_experience_CK CHECK (agent_years_experience > 0 AND agent_years_experience < 99);
ALTER TABLE RCV_Agent
ADD CONSTRAINT RCV_Agent_agent_specialty_CK CHECK (agent_specialty IN ('Canada','US','Europe','Cruises','Adventure'));
ALTER TABLE RCV_Agent
ADD CONSTRAINT RCV_Agent_agent_level_CK CHECK (agent_level IN ('I','II','III','IV'));







