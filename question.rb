require_relative 'questions_database.rb'
require_relative 'user.rb'
require_relative 'reply.rb'

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

    def self.find_by_author_id(target_id)
        questions = QuestionsDatabase.instance.execute(<<-SQL, target_id)
            SELECT
              *
            FROM
              questions
            WHERE
              author_id = ?
        SQL
        questions.length > 0 ? questions.map { |question| Question.new(question) } : nil
    end

    def self.most_followed(n)
      QuestionFollow.most_followed_questions(n)
    end

    def self.most_liked(n)
      QuestionLike.most_liked_questions(n)
    end

    def initialize(options)
        @id = options["id"]
        @title = options["title"]
        @body = options["body"]
        @author_id = options["author_id"]
    end
    
    def author
      User.find_by_id(@author_id)
    end

    def replies
      Reply.find_by_question_id(@id)
    end

    def followers
      QuestionFollow.followers_for_question_id(@id)
    end

    def likers
      QuestionLike.likers_for_question_id(@id)
    end

    def num_likes
      QuestionLike.num_likes_for_question_id(@id)
    end
end
