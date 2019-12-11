require 'rspec'
require_relative '../user'
require_relative '../questions_database'

describe 'User' do
    describe "::find_by_id" do
        it 'returns nil if id is not in user table' do
            expect(User.find_by_id(9)).to eq(nil)
        end
        it 'returns an instance of User' do
            expect(User.find_by_id(1)).to be_an_instance_of(User)
        end
    end
end