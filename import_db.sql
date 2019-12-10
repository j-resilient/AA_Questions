PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname TEXT,
  lname TEXT NOT NULL
);

INSERT INTO
  users(fname, lname)
VALUES
  ('Tony', 'Stark'),
  ('Pepper', 'Potts'),
  ('James', 'Rhodes');

DROP TABLE IF EXISTS questions

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title TEXT,
  body TEXT,
  author_id INTEGER NOT NULL

    FOREIGN KEY (author_id) REFERENCES users(id)
)

INSERT INTO
  questions (title, body, author_id)
VALUES
  ('Social Security Number', 'What is your social security number?', (
      SELECT
        id
      FROM
        users
      WHERE
        name LIKE 'Pepper Potts'
  ))
