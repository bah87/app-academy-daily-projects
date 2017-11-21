DROP TABLE users; DROP TABLE questions; DROP TABLE question_follows; DROP TABLE replies; DROP TABLE question_likes;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname TEXT NOT NULL,
  lname TEXT NOT NULL
);

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title TEXT NOT NULL,
  body TEXT,
  user_id INTEGER NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  body TEXT,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,
  parent_id INTEGER,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (parent_id) REFERENCES replies(id)
);

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO 
  users (fname, lname)
VALUES
  ('Brendan', 'Higgins'),
  ('Hamilton', 'Sands'),
  ('Mark','Twain'),
  ('Timothy', 'Shmimothy'),
  ('Bill', 'Gates');
  
INSERT INTO
  questions (title, body, user_id)
VALUES
  ('Help', 'Where am I?', (SELECT users.id FROM users WHERE users.fname = 'Brendan' AND users.lname = 'Higgins')),
  ('SQL', 'How do joins work?', (SELECT users.id FROM users WHERE users.fname = 'Hamilton' AND users.lname = 'Sands')),
  ('Excuse Me', 'The bathroom?', (SELECT users.id FROM users WHERE users.fname = 'Brendan' AND users.lname = 'Higgins'));
  
INSERT INTO
  question_follows (user_id, question_id)
VALUES
  (1,1),
  (1,3),  
  (2,2),  
  (2,3),  
  (5,2),
  (3,1),
  (4,1);
  
INSERT INTO 
  replies (body, user_id, question_id, parent_id)
VALUES
  ('It is over there', 2, 3, NULL),
  ('I thought it wasn''t', 1, 3, 1),
  ('Combine tables based on two columns', 5, 2, NULL);

INSERT INTO
  question_likes (user_id, question_id)
VALUES 
  (3,1),
  (2,2),
  (5,2),
  (4,1),
  (3,2),
  (4,3);
