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

    describe "::num_likes_for_question_id" do
        it 'returns the correct number of likes for a question' do
            expect(QuestionLike.num_likes_for_question_id(2)).to eq(5)
        end
        it 'returns 0 if there are no likes' do
            expect(QuestionLike.num_likes_for_question_id(3)).to eq(0)
        end
    end

    describe "::liked_questions_for_user_id" do
        subject(:questions) { QuestionLike.liked_questions_for_user_id(3) }
        it 'returns an array of Question objects' do
            expect(questions).to be_an_instance_of(Array)
            questions.each do |q|
                expect(q).to be_an_instance_of(Question)
            end
        end
        it 'returns the questions that the user liked' do
            liked_questions = [1, 2]
            questions.map! { |q| q.id }
            expect(questions).to match_array(liked_questions)
        end
        it 'returns nil if the user has not liked any questions' do
            expect(QuestionLike.liked_questions_for_user_id(7)).to be_nil
        end
    end

    describe "::most_liked_questions" do
        subject(:most_liked) { QuestionLike.most_liked_questions(2) }
        it 'returns an array of Question objects' do
            expect(most_liked).to be_an_instance_of(Array)
            most_liked.each do |like|
                expect(like).to be_an_instance_of(Question)
            end
        end
        it 'returns at most n objects' do
            expect(most_liked.length).to eq(2)
        end
        it 'returns the most liked questions' do
            expected_ids = [1, 2]
            most_liked.map! { |q| q.id }
            expect(most_liked).to match_array(expected_ids)
        end
    end
end