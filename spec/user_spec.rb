require 'rspec'
require_relative '../user'
require_relative '../questions_database'
require_relative '../question'

describe 'User' do
    describe "::find_by_id" do
        it 'returns nil if id is not in user table' do
            expect(User.find_by_id(9)).to eq(nil)
        end
        it 'returns an instance of User' do
            expect(User.find_by_id(1)).to be_an_instance_of(User)
        end
    end

    describe "::find_by_name" do
        it 'returns nil if name is not in users db' do
            expect(User.find_by_name('Clint', 'Barton')).to eq(nil)
        end
        it 'returns an instance of User' do
            expect(User.find_by_name('Tony', 'Stark')).to be_an_instance_of(User)
        end
    end

    describe "#authored_questions" do
        it 'returns nil if the user has asked no questions' do
            rhodey = User.find_by_name('James', 'Rhodes')
            expect(rhodey.authored_questions).to eq(nil)
        end

        subject(:pepper) { User.find_by_name('Pepper', 'Potts') }
        it 'returns all questions by user' do
            questions = pepper.authored_questions
            expect(questions.length).to eq(1)
            expect(questions.first.title).to eq('Social Security Number')
        end
    end
end