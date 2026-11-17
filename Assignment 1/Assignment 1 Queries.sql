CREATE DATABASE IF NOT EXISTS assignment_db;
USE assignment_db;

-- 1. Create a simple table countries
DROP TABLE IF EXISTS countries;
CREATE TABLE countries (
    country_id varchar(2),
    country_name varchar(40),
    region_id decimal(10,0)
);

-- 2. Create table countries if it does not already exist
CREATE TABLE IF NOT EXISTS countries (
    country_id varchar(2),
    country_name varchar(40),
    region_id decimal(10,0)
);

-- 3. Create the structure of dup_countries similar to countries
DROP TABLE IF EXISTS dup_countries;
CREATE TABLE dup_countries LIKE countries;

-- 4. Create a duplicate copy of countries table including structure and data
DROP TABLE IF EXISTS dup_countries;
CREATE TABLE dup_countries AS SELECT * FROM countries;

-- 5. Create table countries with explicit NULL constraints
DROP TABLE IF EXISTS countries;
CREATE TABLE countries (
    country_id varchar(2) NULL,
    country_name varchar(40) NULL,
    region_id decimal(10,0) NULL
);

-- 6. Create table jobs with a check constraint for max_salary <= 25000
DROP TABLE IF EXISTS jobs;
CREATE TABLE jobs (
    job_id varchar(10) NOT NULL PRIMARY KEY,
    job_title varchar(35) NOT NULL,
    min_salary decimal(6,0),
    max_salary decimal(6,0),
    CONSTRAINT chk_max_salary CHECK (max_salary <= 25000)
);

-- 7. Create table countries restricting entries to Italy, India, and China
DROP TABLE IF EXISTS countries;
CREATE TABLE countries (
    country_id varchar(2),
    country_name varchar(40),
    region_id decimal(10,0),
    CONSTRAINT chk_country CHECK (country_name IN ('Italy', 'India', 'China'))
);

-- 8. Create table job_histry with format check constraint for end_date
DROP TABLE IF EXISTS job_histry;
CREATE TABLE job_histry (
    employee_id decimal(6,0) NOT NULL,
    start_date date NOT NULL,
    end_date varchar(10) NOT NULL,
    job_id varchar(10) NOT NULL,
    department_id decimal(4,0),
    CONSTRAINT chk_end_date CHECK (end_date LIKE '--/--/----')
);

-- 9. Create table countries ensuring country_id avoids duplicates (UNIQUE)
DROP TABLE IF EXISTS countries;
CREATE TABLE countries (
    country_id varchar(2) UNIQUE,
    country_name varchar(40),
    region_id decimal(10,0)
);

-- 10. Create table jobs with default values
DROP TABLE IF EXISTS jobs;
CREATE TABLE jobs (
    job_id varchar(10) NOT NULL PRIMARY KEY,
    job_title varchar(35) NOT NULL DEFAULT ' ',
    min_salary decimal(6,0) DEFAULT 8000,
    max_salary decimal(6,0) DEFAULT NULL
);

-- 11. Create table countries where country_id is a primary key
DROP TABLE IF EXISTS countries;
CREATE TABLE countries (
    country_id varchar(2) NOT NULL PRIMARY KEY,
    country_name varchar(40),
    region_id decimal(10,0)
);

-- 12. Create table countries with auto-incrementing unique country_id
DROP TABLE IF EXISTS countries;
CREATE TABLE countries (
    country_id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    country_name varchar(40),
    region_id decimal(10,0)
);

-- 13. Create table countries with composite unique key (country_id, region_id)
DROP TABLE IF EXISTS countries;
CREATE TABLE countries (
    country_id varchar(2),
    country_name varchar(40),
    region_id decimal(10,0),
    CONSTRAINT pk_countries UNIQUE (country_id, region_id)
);

-- 14. Create table job_history with foreign key referencing jobs(JOB_ID as varchar(10))
DROP TABLE IF EXISTS job_history;
DROP TABLE IF EXISTS jobs;
CREATE TABLE jobs (
    JOB_ID varchar(10) NOT NULL PRIMARY KEY,
    JOB_TITLE varchar(35) NOT NULL,
    MIN_SALARY decimal(6,0) DEFAULT NULL,
    MAX_SALARY decimal(6,0) DEFAULT NULL
) ENGINE=InnoDB;

CREATE TABLE job_history (
    employee_id decimal(6,0) NOT NULL PRIMARY KEY,
    start_date date NOT NULL,
    end_date date NOT NULL,
    job_id varchar(10) NOT NULL,
    department_id decimal(4,0),
    FOREIGN KEY (job_id) REFERENCES jobs(JOB_ID)
) ENGINE=InnoDB;

-- 15. Create table employees with composite foreign key referencing departments
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;
CREATE TABLE departments (
    DEPARTMENT_ID decimal(4,0) NOT NULL DEFAULT 0,
    DEPARTMENT_NAME varchar(30) NOT NULL,
    MANAGER_ID decimal(6,0) NOT NULL DEFAULT 0,
    LOCATION_ID decimal(4,0) DEFAULT NULL,
    PRIMARY KEY (DEPARTMENT_ID, MANAGER_ID)
) ENGINE=InnoDB;

CREATE TABLE employees (
    employee_id decimal(6,0) NOT NULL PRIMARY KEY,
    first_name varchar(20),
    last_name varchar(25) NOT NULL,
    email varchar(25) NOT NULL,
    phone_number varchar(20),
    hire_date date NOT NULL,
    job_id varchar(10) NOT NULL,
    salary decimal(8,2),
    commission decimal(2,2),
    manager_id decimal(6,0) NOT NULL,
    department_id decimal(4,0) NOT NULL,
    FOREIGN KEY (department_id, manager_id) REFERENCES departments(DEPARTMENT_ID, MANAGER_ID)
) ENGINE=InnoDB;

-- 16. Create table employees with single-column foreign keys to departments and jobs
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;
CREATE TABLE departments (
    DEPARTMENT_ID decimal(4,0) NOT NULL DEFAULT 0 PRIMARY KEY,
    DEPARTMENT_NAME varchar(30) NOT NULL,
    MANAGER_ID decimal(6,0) DEFAULT NULL,
    LOCATION_ID decimal(4,0) DEFAULT NULL
) ENGINE=InnoDB;

CREATE TABLE employees (
    employee_id decimal(6,0) NOT NULL PRIMARY KEY,
    first_name varchar(20),
    last_name varchar(25) NOT NULL,
    email varchar(25) NOT NULL,
    phone_number varchar(20),
    hire_date date NOT NULL,
    job_id varchar(10) NOT NULL,
    salary decimal(8,2),
    commission decimal(2,2),
    manager_id decimal(6,0),
    department_id decimal(4,0),
    FOREIGN KEY (department_id) REFERENCES departments(DEPARTMENT_ID),
    FOREIGN KEY (job_id) REFERENCES jobs(JOB_ID)
) ENGINE=InnoDB;

-- Setup parent jobs table with integer JOB_ID for questions 17 to 20
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS job_history;
DROP TABLE IF EXISTS jobs;
CREATE TABLE jobs ( 
    JOB_ID integer NOT NULL UNIQUE PRIMARY KEY, 
    JOB_TITLE varchar(35) NOT NULL DEFAULT ' ', 
    MIN_SALARY decimal(6,0) DEFAULT 8000, 
    MAX_SALARY decimal(6,0) DEFAULT NULL
) ENGINE=InnoDB;

-- 17. Create employees with ON UPDATE CASCADE and ON DELETE RESTRICT
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (
    employee_id int NOT NULL PRIMARY KEY,
    first_name varchar(20),
    last_name varchar(25) NOT NULL,
    job_id int NOT NULL,
    salary decimal(8,2),
    CONSTRAINT fk_job_17 FOREIGN KEY (job_id) REFERENCES jobs(JOB_ID)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
) ENGINE=InnoDB;

-- 18. Create employees with ON DELETE CASCADE and ON UPDATE RESTRICT
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (
    employee_id int NOT NULL PRIMARY KEY,
    first_name varchar(20),
    last_name varchar(25) NOT NULL,
    job_id int NOT NULL,
    salary decimal(8,2),
    CONSTRAINT fk_job_18 FOREIGN KEY (job_id) REFERENCES jobs(JOB_ID)
    ON DELETE CASCADE
    ON UPDATE RESTRICT
) ENGINE=InnoDB;

-- 19. Create employees with ON DELETE SET NULL and ON UPDATE SET NULL
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (
    employee_id int NOT NULL PRIMARY KEY,
    first_name varchar(20),
    last_name varchar(25) NOT NULL,
    job_id int NULL,
    salary decimal(8,2),
    CONSTRAINT fk_job_19 FOREIGN KEY (job_id) REFERENCES jobs(JOB_ID)
    ON DELETE SET NULL
    ON UPDATE SET NULL
) ENGINE=InnoDB;

-- 20. Create employees with ON DELETE NO ACTION and ON UPDATE NO ACTION
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (
    employee_id int NOT NULL PRIMARY KEY,
    first_name varchar(20),
    last_name varchar(25) NOT NULL,
    job_id int NOT NULL,
    salary decimal(8,2),
    CONSTRAINT fk_job_20 FOREIGN KEY (job_id) REFERENCES jobs(JOB_ID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE=InnoDB;