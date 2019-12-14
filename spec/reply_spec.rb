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
        let(:nil_parent_reply) { Reply.find_by_id(1) }
        it 'returns nil if there is no parent' do
            expect(nil_parent_reply.parent_reply).to eq(nil)
        end
    end

    describe "#child_replies" do
        let(:no_reply) { Reply.find_by_id(4) }
        it 'returns nil if there are no children' do
            expect(no_reply.child_replies).to eq(nil)
        end

        let(:reply) { Reply.find_by_id(3) }
        subject(:replies) { reply.child_replies }
        it 'returns an array of Reply objects' do
            expect(replies).to be_an_instance_of(Array)
            replies.each do |reply|
                expect(reply).to be_an_instance_of(Reply)
            end
        end
        it 'returns all immediate children of this reply' do 
            expect(replies.length).to eq( 2)
        end
    end

    describe "#save" do
        subject(:new_reply) { Reply.new({'id' => nil, 'question_id' => 1, 'parent_id' => nil,
        'user_id' => 2, 'body' => 'Q1 Level 1'}) }
        it 'inserts a new reply if reply does not already exist' do
            new_reply.save
            expect(Reply.find_by_question_id(1).last.body).to eq('Q1 Level 1')
            expect(new_reply.id).to_not be_nil
        end
        it 'updates replies if reply does exist' do
            reply = Reply.find_by_question_id(1).last
            current_id = reply.id
            reply.body = 'Q1 Level 2'
            reply.save
            expect(reply.id).to eq(current_id)
            expect(Reply.find_by_question_id(1).last.body).to eq('Q1 Level 2')
        end
    end
end