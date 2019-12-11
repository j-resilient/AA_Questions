require 'rspec'
require_relative '../question_like'
require_relative '../questions_database'

describe 'QuestionLike' do
    describe "::find_by_id" do
        it 'returns nil if id is not in database' do
            expect(QuestionLike.find_by_id(9)).to eq(nil)
        end
        it 'returns a QuestionLike object' do
            expect(QuestionLike.find_by_id(1)).to be_an_instance_of(QuestionLike)
        end
    end
end