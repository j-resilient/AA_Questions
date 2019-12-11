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

    def self.find_by_user_id(user_id)
        replies = QuestionsDatabase.instance.execute(<<-SQL, user_id)
            SELECT
               *
            FROM
               replies
            WHERE
               user_id = ?
        SQL
        replies.length > 0 ? replies.map { |reply| Reply.new(reply) } : nil
    end

    def self.find_by_question_id(question_id)
        reply = QuestionsDatabase.instance.execute(<<-SQL, question_id)
            SELECT
              *
            FROM
              replies
            WHERE
              question_id = ?
        SQL
        reply.length > 0 ? reply.map { |r| Reply.new(r) } : nil
    end

    def initialize(options)
        @id = options['id']
        @question_id = options['question_id']
        @parent_id = options['parent_id']
        @user_id = options['user_id']
        @body = options['body']
    end
end