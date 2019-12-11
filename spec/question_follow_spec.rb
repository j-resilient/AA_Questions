require 'rspec'
require_relative '../question_follow'
require_relative '../questions_database'

describe 'QuestionFollow' do
    describe "::find_by_id" do
        it 'returns nil if id is not in database' do
            expect(QuestionFollow.find_by_id(9)).to eq(nil)
        end
        it 'returns a QuestionFollow object' do
            expect(QuestionFollow.find_by_id(1)).to be_an_instance_of(QuestionFollow)
        end
    end
end