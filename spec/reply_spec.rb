require 'rspec'
require_relative '../reply'
require_relative '../questions_database'

describe 'Reply' do
    describe "::find_by_id" do
        it 'returns nil if id is not in database' do
            expect(Reply.find_by_id(9)).to eq(nil)
        end
        it 'returns a Reply object' do
            expect(Reply.find_by_id(1)).to be_an_instance_of(Reply)
        end
    end
end