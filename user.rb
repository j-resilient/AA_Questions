require_relative 'questions_database.rb'

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

    def initialize(options)
        @id = options['id']
        @fname = options['fname']
        @lname = options['lname']
    end
end