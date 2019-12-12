DROP TABLE IF EXISTS question_follows;
DROP TABLE IF EXISTS question_likes;
DROP TABLE IF EXISTS replies;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS users;

PRAGMA foreign_keys = ON;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(255),
  lname VARCHAR(255) NOT NULL
);

INSERT INTO
  users (fname, lname)
VALUES
  ('Tony', 'Stark'), ('Pepper', 'Potts'), ('James', 'Rhodes'),
  ('Carol', 'Danvers'), ('Steve', 'Rogers'), ('Natasha', 'Romonov'),
  ('Bruce', 'Banner');


CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  body TEXT,
  author_id INTEGER NOT NULL,

  FOREIGN KEY (author_id) REFERENCES users(id)
);

INSERT INTO
  questions (title, body, author_id)
VALUES
  ('Q1', 'Q1', (SELECT id FROM users WHERE lname LIKE 'Potts')),
  ('Q2', 'Q2', ( SELECT id FROM users WHERE lname LIKE 'Stark')),
  ('Q3', 'Q3', (SELECT id FROM users WHERE lname = 'Danvers'));


CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO
  question_follows (question_id, user_id)
VALUES
  ((SELECT id FROM questions WHERE title LIKE 'Q1'),
  (SELECT id FROM users WHERE lname LIKE 'Potts')),
  ((SELECT id FROM questions WHERE title LIKE 'Q1'),
  (SELECT id FROM users WHERE lname LIKE 'Stark')),
  ((SELECT id FROM questions WHERE title LIKE 'Q2'),
  (SELECT id FROM users WHERE lname LIKE 'Stark')),
  ((SELECT id FROM questions WHERE title LIKE 'Q2'),
  (SELECT id FROM users WHERE lname LIKE 'Potts')),
  ((SELECT id FROM questions WHERE title LIKE 'Q2'),
  (SELECT id FROM users WHERE lname LIKE 'Rhodes')),
  ((SELECT id FROM questions WHERE title LIKE 'Q2'),
  (SELECT id FROM users WHERE lname LIKE 'Rogers')),
  ((SELECT id FROM questions WHERE title LIKE 'Q2'),
  (SELECT id FROM users WHERE lname LIKE 'Romonov')),
  ((SELECT id FROM questions WHERE title LIKE 'Q2'),
  (SELECT id FROM users WHERE lname LIKE 'Danvers')),
  ((SELECT id FROM questions WHERE title LIKE 'Q3'),
  (SELECT id FROM users WHERE lname LIKE 'Danvers'));

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  parent_id INTEGER,
  user_id INTEGER NOT NULL,
  body TEXT NOT NULL,

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (parent_id) REFERENCES replies(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO
  replies (question_id, user_id, body)
VALUES
  ((SELECT id FROM questions WHERE title LIKE 'Q1'),
    (SELECT id FROM users WHERE lname = 'Stark'), 'Q1 Level 1'),
  ((SELECT id FROM questions WHERE title LIKE 'Q2'),
    (SELECT id FROM users WHERE lname LIKE 'Romonov'), 'Q2 Level 1 a'),
  ((SELECT id FROM questions WHERE title LIKE 'Q2'),
    (SELECT id FROM users WHERE lname LIKE 'Rhodes'), 'Q2 Level 1 b'),
  ((SELECT id FROM questions WHERE title LIKE 'Q2'),
    (SELECT id FROM users WHERE lname LIKE 'Potts'), 'Q2 Level 1 c');

INSERT INTO
  replies (question_id, parent_id, user_id, body)
VALUES
  ((SELECT id FROM questions WHERE title LIKE 'Q2'),
    (SELECT id FROM replies WHERE body LIKE 'Q2 Level 1 a'),
    (SELECT id FROM users WHERE lname LIKE 'Rogers'), 'Q2 Level 2 a'),
  ((SELECT id FROM questions WHERE title LIKE 'Q2'),
    (SELECT id FROM replies WHERE body LIKE 'Q2 Level 1 b'),
    (SELECT id FROM users WHERE lname LIKE 'Danvers'), 'Q2 Level 2 b1'),
  ((SELECT id FROM questions WHERE title LIKE 'Q2'),
    (SELECT id FROM replies WHERE body LIKE 'Q2 Level 1 b'),
    (SELECT id FROM users WHERE lname LIKE 'Potts'), 'Q2 Level 2 b2'),
  ((SELECT id FROM questions WHERE title LIKE 'Q2'),
    (SELECT id FROM replies WHERE body LIKE 'Q2 Level 2 b2'),
    (SELECT id FROM users WHERE lname LIKE 'Stark'), 'Q2 Level 3 b2'),
  ((SELECT id FROM questions WHERE title LIKE 'Q2'),
    (SELECT id FROM replies WHERE body LIKE 'Q2 Level 3 b2'),
    (SELECT id FROM users WHERE lname LIKE 'Rhodes'), 'Q2 Level 4 b2');


CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO
  question_likes (question_id, user_id)
VALUES
  ((SELECT id FROM questions WHERE title LIKE 'Q1'),
  (SELECT id FROM users WHERE lname LIKE 'Stark')),
  ((SELECT id FROM questions WHERE title LIKE 'Q1'),
  (SELECT id FROM users WHERE lname LIKE 'Rhodes')),
  ((SELECT id FROM questions WHERE title LIKE 'Q2'),
  (SELECT id FROM users WHERE lname LIKE 'Potts')),
  ((SELECT id FROM questions WHERE title LIKE 'Q2'),
  (SELECT id FROM users WHERE lname LIKE 'Rhodes')),
  ((SELECT id FROM questions WHERE title LIKE 'Q2'),
  (SELECT id FROM users WHERE lname LIKE 'Rogers')), 
  ((SELECT id FROM questions WHERE title LIKE 'Q2'),
  (SELECT id FROM users WHERE lname LIKE 'Romonov')),
  ((SELECT id FROM questions WHERE title LIKE 'Q2'),
  (SELECT id FROM users WHERE lname LIKE 'Danvers'));