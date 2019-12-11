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

    def initialize(options)
        @id = options['id']
        @question_id = options['question_id']
        @user_id = options['user_id']
    end
end