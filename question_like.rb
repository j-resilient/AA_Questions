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
    
    def initialize(options)
        @id = options['id']
        @question_id = options['question_id']
        @user_id = options['user_id']
    end
end