PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS question_likes;

CREATE TABLE question_likes (
    question_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,

    FOREIGN KEY (question_id) REFERENCES questions(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS replies;

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

DROP TABLE IF EXISTS question_follows;

CREATE TABLE question_follows
(
    question_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,

    FOREIGN KEY (question_id) REFERENCES questions(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS questions;

CREATE TABLE questions
(
    id INTEGER PRIMARY KEY,
    title TEXT,
    body TEXT,
    author_id INTEGER NOT NULL,

    FOREIGN KEY (author_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname TEXT,
  lname TEXT NOT NULL
);

INSERT INTO
  users (fname, lname)
VALUES
  ('Tony', 'Stark'),
  ('Pepper', 'Potts'),
  ('James', 'Rhodes');

INSERT INTO
  questions
    (title, body, author_id)
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
  question_follows (question_id, user_id)
VALUES
  ((SELECT id FROM questions WHERE title = 'Social Security Number'),
  (SELECT id FROM users WHERE lname = 'Rhodes'));

INSERT INTO
  replies (question_id, user_id, body)
VALUES
  (1, 
  (SELECT id FROM users WHERE lname = 'Stark' AND fname = 'Tony'),
  '5? There is definitely a 5 in there.');

INSERT INTO
  question_likes (question_id, user_id)
VALUES
  ((SELECT id FROM questions WHERE title = 'Social Security Number'),
  (SELECT id FROM users WHERE lname = 'Rhodes'));