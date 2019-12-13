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
        let(:questions) { pepper.authored_questions }
        it 'returns an array of Question objects' do
            expect(questions).to be_an_instance_of(Array)
            questions.each do |question|
                expect(question).to be_an_instance_of(Question)
            end
        end
        it 'returns all questions by user' do
            expect(questions.length).to eq(1)
            expect(questions.first.title).to eq('Q1')
        end
    end

    describe "#authored_replies" do
        it 'returns nil if the user has no replies' do
            banner = User.find_by_name('Bruce', "Banner")
            expect(banner.authored_replies).to eq(nil)
        end
        it 'returns all replies by user' do
            tony = User.find_by_name('Tony', 'Stark')
            expect(tony.authored_replies.length).to eq(2)
        end
    end

    describe "#followed_questions" do
        subject(:user) { User.find_by_name('Pepper', 'Potts') }
        it 'returns an array of Question objects' do
            questions = user.followed_questions
            expect(questions).to be_an_instance_of(Array)
            questions.each do |q|
                expect(q).to be_an_instance_of(Question)
            end
        end
    end

    describe "#average_karma" do
        subject(:tony) { User.find_by_id(1) }
        it 'returns the average number of likes' do
            expect(tony.average_karma).to eq(5)
        end
    end

    describe "#save" do
        subject(:new_user) { User.new({ 'id' => nil, 'fname' => 'Peter', 'lname' => 'Porker'}) }

        it 'inserts a new user into Users if they do not exist' do
            new_user.save
            expect(User.find_by_name('Peter', 'Porker')).to_not be_nil
            expect(new_user.id).to eq(8)
        end
        it 'updates Users if user does exist' do
            peter = User.find_by_name('Peter', 'Porker')
            peter.lname = 'Parker'
            expect(peter.id).to eq(8)
            peter.save
            expect(User.find_by_name('Peter', 'Parker')).to_not be_nil
            expect(User.find_by_name('Peter', 'Porker')).to be_nil
        end
    end
end