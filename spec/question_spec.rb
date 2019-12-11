require 'rspec'
require_relative '../question'
require_relative '../questions_database'
require_relative '../user'

describe 'Question' do
    describe "::find_by_id" do
        it 'returns nil if id is not in database' do
            expect(Question.find_by_id(9)).to eq(nil)
        end
        it 'returns a Question object' do
            expect(Question.find_by_id(1)).to be_an_instance_of(Question)
        end
    end

    describe "::find_by_author_id" do
        it 'returns nil if the author has no questions' do
            expect(Question.find_by_author_id(10)).to eq(nil)
        end
        it 'returns correct question(s)' do
            question = Question.find_by_author_id(2).first
            expect(question.title).to eq('Social Security Number')
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
end