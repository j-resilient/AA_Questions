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
end