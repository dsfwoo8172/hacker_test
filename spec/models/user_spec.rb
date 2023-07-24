require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'association' do
    it { should have_many(:posts) }
    it { should have_many(:votes) }
    it { should have_many(:comments) }
  end

  describe 'valid attributes' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_uniqueness_of(:email).case_insensitive }
  end
end
