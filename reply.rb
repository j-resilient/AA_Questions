require_relative 'questions_database.rb'

class Reply
    attr_accessor :id, :question_id, :parent_id, :user_id, :body

    def self.find_by_id(target_id)
        reply = QuestionsDatabase.instance.execute(<<-SQL, target_id)
            SELECT
               *
            FROM
               replies
            WHERE
               id = ?
        SQL
        reply.length > 0 ? Reply.new(reply.first) : nil
    end

    def initialize(options)
        @id = options['id']
        @question_id = options['question_id']
        @parent_id = options['parent_id']
        @user_id = options['user_id']
        @body = options['body']
    end
end