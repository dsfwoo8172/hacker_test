require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'association' do
    it { should have_many(:comments) }
    it { should have_many(:votes) }
    it { should belong_to(:user) }
  end

  describe 'valid attributes' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:content) }
  end
end
