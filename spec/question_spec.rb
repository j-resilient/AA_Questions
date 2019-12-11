require 'rspec'
require_relative '../question'
require_relative '../questions_database'

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
end