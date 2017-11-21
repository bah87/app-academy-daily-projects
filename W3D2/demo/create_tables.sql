CREATE TABLE departments (
  id INTEGER PRIMARY KEY,
  name VARCHAR(255) NOT NULL
);

CREATE TABLE professors (
  id INTEGER PRIMARY KEY,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL,
  department_id INTEGER NOT NULL,
  FOREIGN KEY (department_id) REFERENCES departments(id)
);

INSERT INTO
  departments (name)
VALUES
  ('mathematics'), ('physics');
  
INSERT INTO
  professors (first_name, last_name, department_id)
VALUES
  ('Albert', 'Einstein', (SELECT departments.id FROM departments WHERE departments.name = 'physics')),
  ('Kurt', 'Godel', (SELECT departments.id FROM departments WHERE departments.name = 'mathematics'));