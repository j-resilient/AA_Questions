require_relative 'questions_database'

class QuestionLike
    attr_accessor :question_id, :user_id

    def self.find_by_id(target_id)
        like = QuestionsDatabase.instance.execute(<<-SQL, target_id)
            SELECT
               *
            FROM
               question_likes
            WHERE
               id = ?
        SQL
        like.length > 0 ? QuestionLike.new(like.first) : nil
    end

    def self.likers_for_question_id(question_id)
        likers = QuestionsDatabase.instance.execute(<<-SQL, question_id)
            SELECT
              users.*
            FROM
              users
            JOIN
              question_likes ON users.id = question_likes.user_id
            WHERE
              question_likes.question_id = ?
        SQL
        likers.length > 0 ? likers.map { |l| User.new(l) } : nil
    end
    
    def initialize(options)
        @id = options['id']
        @question_id = options['question_id']
        @user_id = options['user_id']
    end
end