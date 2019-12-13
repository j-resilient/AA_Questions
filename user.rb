require_relative 'questions_database.rb'
require_relative 'question'

class User
    attr_accessor :id, :fname, :lname

    def self.find_by_id(target_id)
        user = QuestionsDatabase.instance.execute(<<-SQL, target_id)
            SELECT
              *
            FROM
              users
            WHERE
              id = ? 
        SQL
        user.length > 0 ? User.new(user.first) : nil
    end

    def self.find_by_name(first_name, last_name)
      user = QuestionsDatabase.instance.execute(<<-SQL, first_name, last_name)
            SELECT
              *
            FROM
              users
            WHERE
              fname LIKE ? AND lname LIKE ? 
        SQL
        user.length > 0 ? User.new(user.first) : nil
    end

    def initialize(options)
        @id = options['id']
        @fname = options['fname']
        @lname = options['lname']
    end

    def authored_questions
      Question.find_by_author_id(@id)
    end

    def authored_replies
      Reply.find_by_user_id(@id)
    end

    def followed_questions
      QuestionFollow.followed_questions_for_user_id(@id)
    end

    def average_karma
      average = QuestionsDatabase.instance.execute(<<-SQL, @id)
        SELECT
          CAST(COUNT(DISTINCT question_likes.id) AS FLOAT)/COUNT(DISTINCT questions.id)
        FROM
          questions
        LEFT OUTER JOIN
          question_likes ON questions.id = question_likes.question_id
        WHERE
          questions.author_id = ?
      SQL
      average.first.flatten[1]
    end
end