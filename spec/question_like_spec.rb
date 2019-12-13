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

    describe "::likers_for_question_id" do
        subject(:likers) { QuestionLike.likers_for_question_id(1) }
        it 'returns an array of User objects' do
            expect(likers).to be_an_instance_of(Array)
            likers.each do |liker|
                expect(liker).to be_an_instance_of(User)
            end
        end
        it 'returns nil if question has no likers' do
            expect(QuestionLike.likers_for_question_id(3)).to eq(nil)
        end
        it 'returns the correct likers' do
            expected_likers = ['Stark', 'Rhodes']
            likers.map! { |l| l.lname }
            expect(likers).to match_array(expected_likers)
        end
    end
end