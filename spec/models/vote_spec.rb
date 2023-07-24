require 'rails_helper'

RSpec.describe Vote, type: :model do
  describe 'association' do
    it { should belong_to(:user) }
  end
end
