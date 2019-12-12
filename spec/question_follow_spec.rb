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

    describe "::followed_questions_for_user_id" do
        let(:follows_nil) { User.find_by_name('Bruce', 'Banner') }
        let(:follows_two) { User.find_by_name('Pepper', 'Potts') }
        subject(:questions) { QuestionFollow.followed_questions_for_user_id(follows_two.id)}

        it "returns nil if user isn't following any questions" do
            expect(QuestionFollow.followed_questions_for_user_id(follows_nil.id)).to eq(nil)
        end
        it "returns an array of Question objects" do
            expect(questions).to be_an_instance_of(Array)
            questions.each do |question|
                expect(question).to be_an_instance_of(Question)
            end
        end
        it "returns the correct questions" do
            expect(questions.first.title).to eq('Q1')
        end
    end
end