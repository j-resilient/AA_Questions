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
  ('Carol', 'Danvers'), ('Steve', 'Rogers'), ('Natasha', 'Romonov');


CREATE TABLE questions
(
  id INTEGER PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  body TEXT,
  author_id INTEGER NOT NULL,

  FOREIGN KEY (author_id) REFERENCES users(id)
);

INSERT INTO
  questions (title, body, author_id)
VALUES
  ('Social Security Number', 'What is your social security number?', (
    SELECT
      id
    FROM
      users
    WHERE
        lname LIKE 'Potts'
    ));

INSERT INTO
    questions (title, body, author_id)
VALUES (
    'Captain', 'Captain??', (
      SELECT
        id
      FROM
        users
      WHERE
        lname LIKE 'Rogers'
    ));

INSERT INTO
  questions (title, body, author_id)
VALUES
  ('Goose', 'Has anyone seen my cat?',
  (SELECT id FROM users WHERE lname = 'Danvers'));

CREATE TABLE question_follows
(
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO
  question_follows (question_id, user_id)
VALUES
  ((SELECT id FROM questions WHERE title = 'Social Security Number'),
    (SELECT id FROM users WHERE lname = 'Rhodes'));

INSERT INTO
  question_follows (question_id, user_id)
VALUES
  ((SELECT id FROM questions WHERE title = 'Captain'),
    (SELECT id FROM users WHERE lname = 'Rogers'));

INSERT INTO
  question_follows (question_id, user_id)
VALUES
  ((SELECT id FROM questions WHERE title = 'Captain'),
    (SELECT id FROM users WHERE lname = 'Danvers'));

INSERT INTO
  question_follows (question_id, user_id)
VALUES
  ((SELECT id FROM questions WHERE title = 'Captain'),
    (SELECT id FROM users WHERE lname = 'Romonov'));


CREATE TABLE replies
(
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
  (1,
    (SELECT id FROM users WHERE lname = 'Stark' AND fname = 'Tony'), 
    '5? There is definitely a 5 in there.');

INSERT INTO
  replies (question_id, user_id, body)
VALUES
  (2,
    (SELECT id FROM users WHERE lname = 'Danvers' AND fname = 'Carol'),
    'Captain.');

INSERT INTO
  replies (question_id, user_id, body)
VALUES
  (2,
    (SELECT id FROM users WHERE lname = 'Rogers' AND fname = 'Steve'),
    'Captain.');

INSERT INTO
  replies (question_id, user_id, body)
VALUES
  (2,
    (SELECT id FROM users WHERE lname = 'Danvers' AND fname = 'Carol'), 'Captain.');

CREATE TABLE question_likes
(
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO
  question_likes
  (question_id, user_id)
VALUES
  ((SELECT id
    FROM questions
    WHERE title = 'Social Security Number'),
    (SELECT id
    FROM users
    WHERE lname = 'Rhodes'));

INSERT INTO
  question_likes
  (question_id, user_id)
VALUES
  ((SELECT id
    FROM questions
    WHERE title = 'Social Security Number'),
    (SELECT id
    FROM users
    WHERE lname = 'Danvers'));

INSERT INTO
  question_likes (question_id, user_id)
VALUES
  ((SELECT id FROM questions WHERE title = 'Captain'),
    (SELECT id FROM users WHERE lname = 'Romonov'));

INSERT INTO
  question_likes (question_id, user_id)
VALUES
  ((SELECT id FROM questions WHERE title = 'Captain'),
    (SELECT id FROM users WHERE lname = 'Danvers'));