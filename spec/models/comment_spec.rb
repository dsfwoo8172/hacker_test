require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'associations' do
    it { should belong_to(:post) }
    it { should belong_to(:user) }
  end

  describe 'valid attributes' do
    it { should validate_presence_of(:content) }
  end

  describe 'custom validations' do

    it 'checks ancestry depth' do
      comment = build(:comment, ancestry: "/1/2/3/4/5/6/7/8/")
      comment.valid?
      expect(comment.errors[:base]).to include('more than 8 layers')
    end

    it 'allows valid ancestry depth' do
      comment = build(:comment, ancestry: "/1/2/3/4/5/6/7/")
      comment.valid?
      expect(comment.errors[:base]).to be_empty
    end
  end
end
