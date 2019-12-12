require 'rspec'
require_relative '../reply'
require_relative '../questions_database'
require_relative '../question'

describe 'Reply' do
    describe "::find_by_id" do
        it 'returns nil if id is not in database' do
            expect(Reply.find_by_id(500)).to eq(nil)
        end
        it 'returns a Reply object' do
            expect(Reply.find_by_id(1)).to be_an_instance_of(Reply)
        end
    end

    describe "::find_by_user_id" do
        it 'returns nil if user_id has written no replies' do
            expect(Reply.find_by_user_id(10)).to eq(nil)
        end
        it 'returns an array reply objects' do
            replies = Reply.find_by_user_id(1)
            expect(replies).to be_an_instance_of(Array)
            replies.each do |reply|
                expect(reply).to be_an_instance_of(Reply)
            end
        end
        it 'returns the correct reply' do
            reply = Reply.find_by_user_id(1).first
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
            expect(replies.length).to eq(8)
        end
    end

    describe "author" do
        let(:reply) { Reply.find_by_id(1) }
        it 'returns a User object' do
            expect(reply.author).to be_an_instance_of(User)
        end
        it 'returns the correct user' do
            expect(reply.author.fname).to eq('Tony')
            expect(reply.author.lname).to eq('Stark')
        end
    end

    describe "#question" do
        let(:reply) { Reply.find_by_question_id(2).first }
        it 'returns a Question object' do
            expect(reply.question).to be_an_instance_of(Question)
        end
        it 'returns the correct question' do
            expect(reply.question.id).to eq(2)
        end
    end

    describe "#parent_reply" do
        let(:reply) { Reply.find_by_id(6) }
        it 'returns a Reply object' do
            expect(reply.parent_reply).to be_an_instance_of(Reply)
        end
        it 'returns the immediate parent' do
            parent = reply.parent_reply
            expect(parent.id).to eq(3)
        end
        it 'returns nil if there is no parent'
    end

    describe "#child_replies" do
        let(:reply) { }
        it 'returns an array of Reply objects'
        it 'returns all immediate children of this reply'
    end
end