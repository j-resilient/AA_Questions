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

    def self.num_likes_for_question_id(question_id)
        num = QuestionsDatabase.instance.execute(<<-SQL, question_id)
            SELECT
              COUNT(*)
            FROM 
              question_likes
            WHERE
              question_id = ?
        SQL
        # num is returned as an array of hashes where COUNT(*) is the key for the actual count
        num.first["COUNT(*)"]
    end

    def self.liked_questions_for_user_id(user_id)
        questions = QuestionsDatabase.instance.execute(<<-SQL, user_id)
            SELECT
              questions.*
            FROM
              questions
            JOIN
              question_likes ON questions.id = question_likes.question_id
            WHERE
              question_likes.user_id = ?
        SQL
        questions.length > 0 ? questions.map { |q| Question.new(q) } : nil
    end

    def self.most_liked_questions(n)
        questions = QuestionsDatabase.instance.execute(<<-SQL, n)
            SELECT
              questions.*
            FROM
              questions
            JOIN
              question_likes ON questions.id = question_likes.question_id
            GROUP BY 
              questions.id
            ORDER BY
              COUNT(*) DESC
            LIMIT
              ?
        SQL
        questions.delete(nil)
        questions.length > 0 ? questions.map { |q| Question.new(q) } : nil
    end
    
    def initialize(options)
        @id = options['id']
        @question_id = options['question_id']
        @user_id = options['user_id']
    end
end