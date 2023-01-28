CREATE TABLE IF NOT EXISTS employees (
    emp_id SERIAL PRIMARY KEY,
    name VARCHAR(60) NOT NULL,
    department VARCHAR(60) NOT NULL,
    superior INTEGER NOT NULL REFERENCES employees(emp_id)
);
