require 'rspec'
require_relative '../question'
require_relative '../questions_database'
require_relative '../user'

describe 'Question' do
    describe "::find_by_id" do
        it 'returns nil if id is not in database' do
            expect(Question.find_by_id(50)).to eq(nil)
        end
        it 'returns a Question object' do
            expect(Question.find_by_id(1)).to be_an_instance_of(Question)
        end
    end

    describe "::find_by_author_id" do
        it 'returns nil if the author has no questions' do
            expect(Question.find_by_author_id(3)).to eq(nil)
        end
        it 'returns correct question(s)' do
            question = Question.find_by_author_id(2).first
            expect(question.title).to eq('Q1')
        end
        it 'returns an array of Question objects' do
            questions = Question.find_by_author_id(2)
            expect(questions).to be_an_instance_of(Array)
            questions.each do |question|
                expect(question).to be_an_instance_of(Question)
            end
        end
    end

    describe "#author" do
        let(:question) { Question.find_by_id(1) }
        subject(:author) { question.author }
        it 'returns a user object' do
            expect(author).to be_an_instance_of(User)
        end
        it 'returns the correct author of the question' do
            expect(author.fname).to eq('Pepper')
            expect(author.lname).to eq('Potts')
        end
    end
    
    describe "#replies" do
        let(:question) { Question.find_by_id(2)}
        subject(:replies) { question.replies }
        it 'returns an array of reply objects' do
            expect(replies).to be_an_instance_of(Array)
            replies.each do |reply|
                expect(reply).to be_an_instance_of(Reply)
            end
        end
        it 'returns the correct number of replies' do
            expect(replies.length).to eq(8)
        end
    end

    describe "#followers" do
        let(:question) { Question.find_by_id(1) }
        subject(:followers) { question.followers}

        it 'returns an array of User objects' do
            expect(followers).to be_an_instance_of(Array)
            followers.each do |f|
                expect(f).to be_an_instance_of(User)
            end
        end
    end

    describe "::most_followed" do
        let(:question) { Question.find_by_id(2) }
        it 'returns an array of Question objects' do
            expect(Question.most_followed(2)).to be_an_instance_of(Array)
            Question.most_followed(2).each do |q|
                expect(q).to be_an_instance_of(Question)
            end
        end
    end

    let(:question) { Question.find_by_id(2) }
    describe "#likers" do
        it 'returns an array of User objects' do
            likers = question.likers
            expect(likers).to be_an_instance_of(Array)
            likers.each do |l|
                expect(l).to be_an_instance_of(User)
            end
        end
    end

    describe "#num_likes" do
        it 'returns number of likes' do
            expect(question.num_likes).to eq(5)
        end
    end

    describe "::most_liked" do
        it 'returns the correct number of questions' do
            expect(Question.most_liked(2).length).to eq(2)
        end
    end
end