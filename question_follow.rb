require_relative 'questions_database.rb'

class QuestionFollow
    def self.find_by_id(target_id)
        follow = QuestionsDatabase.instance.execute(<<-SQL, target_id)
            SELECT
               *
            FROM
               question_follows
            WHERE
               id = ?
        SQL
        follow.length > 0 ? QuestionFollow.new(follow.first) : nil
    end

    def self.followers_for_question_id(question_id)
        followers = QuestionsDatabase.instance.execute(<<-SQL, question_id)
            SELECT
              *
            FROM
              users
            JOIN
              question_follows ON users.id = question_follows.user_id
            WHERE
              question_follows.question_id = ?
        SQL
        followers.length > 0 ? followers.map { |f| User.new(f) } : nil
    end

    def initialize(options)
        @id = options['id']
        @question_id = options['question_id']
        @user_id = options['user_id']
    end
end