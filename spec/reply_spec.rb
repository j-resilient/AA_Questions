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

    describe "::find_by_user_id" do
        it 'returns nil if user_id has written no replies' do
            expect(Reply.find_by_user_id(10)).to eq(nil)
        end
        it 'returns a reply object' do
            expect(Reply.find_by_user_id(1)).to be_an_instance_of(Reply)
        end
        it 'returns the correct reply' do
            reply = Reply.find_by_user_id(1)
            expect(reply.id).to eq(1)
        end
    end

    describe "::find_by_question_id" do
        it 'returns nil if question has no replies' do
            expect(Reply.find_by_question_id(3)).to eq(nil)
        end
        it 'returns a reply objects' do
            replies = Reply.find_by_question_id(2)
            replies.each do |reply|
                expect(reply).to be_an_instance_of(Reply)
            end
        end
        it 'returns all replies' do
            replies = Reply.find_by_question_id(2)
            expect(replies.length).to eq(3)
        end
    end
end