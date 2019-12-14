# AA_Questions  
An application to create and manage a database of students questions.  
It tracks questions, replies to questions, replies to replies, and question likes.  
Uses Ruby, Rspec, and SQLite.  
## To run
cat import_db.sql | sqlite3 questions.db
## Learning Goals  
(From App Academy Description)  
> Know how to use a SQL script to construct a database
>
> Be able to use queries, written in SQL, in your Ruby code
>
> Be able to debug SQL syntax errors
>
> Know how a basic ORM (Object-Relational Mapping) system works
>
> Be able to write SQL queries to solve problems without using Ruby code
>
> Be able to use joins instead of Ruby code
>
> Be able to use GROUP BY and ORDER BY instead of Ruby code
## SQL  
The database consists of three tables:  
'users' tracks the user's first and last names. 
'questions' tracks the title, the body, and the associated author (foreign key) of the questions  
'question_follows' is a join table joining 'users' to 'questions' and vice versa  
'replies' keeps references to the question, the parent reply, and the author user; it also keeps the actual reply  
'question_likes' keeps references to the user and the question
## Ruby  
The QuestionsDatabase class only returns hashes. Each database has a corresponding model class to create objects out of the data returned from the database.  
We were give the names and a little information for each method we needed to create.
## Rspec Tests  
All of the rspec tests are based on the seeded values from import_db.sql, so you have to reset the database prior to running the specs.