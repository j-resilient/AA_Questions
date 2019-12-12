require 'rspec'
require_relative '../question_follow'
require_relative '../questions_database'

describe 'QuestionFollow' do
    describe "::find_by_id" do
        it 'returns nil if id is not in database' do
            expect(QuestionFollow.find_by_id(50)).to eq(nil)
        end
        it 'returns a QuestionFollow object' do
            expect(QuestionFollow.find_by_id(1)).to be_an_instance_of(QuestionFollow)
        end
    end

    describe "::followers_for_question_id" do
        subject(:followers) { QuestionFollow.followers_for_question_id(1) }
        it "returns an array of User objects" do
            expect(followers).to be_an_instance_of(Array)
            followers.each do |follower|
                expect(follower).to be_an_instance_of(User)
            end
        end
        let(:q1_followers) { ['Potts', 'Stark'] }
        it "returns the correct followers for the given question id" do
            expect(followers.length).to eq(2)
            followers.each_with_index do |follower, idx|
                expect(follower.lname).to eq(q1_followers[idx])
            end
        end
    end
end