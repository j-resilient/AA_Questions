require_relative 'questions_database.rb'

class Question
    attr_accessor :id, :title, :body, :author_id

    def self.find_by_id(target_id)
        question = QuestionsDatabase.instance.execute(<<-SQL, target_id)
            SELECT
               *
            FROM
               questions
            WHERE
               id = ?
        SQL
        question.length > 0 ? Question.new(question.first) : nil
    end

    def initialize(options)
        @id = options["id"]
        @title = options["title"]
        @body = options["body"]
        @author_id = ["author_id"]
    end
end