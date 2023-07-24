require 'rails_helper'

RSpec.describe "UsersController", type: :request do
  describe 'POST /users' do
    it 'creates a new user' do
      post '/users', params: { user: attributes_for(:user) }
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(root_path)
      expect(User.count).to eq(1)
    end
  end

  describe 'POST /users/sign_in' do
    let!(:user) { create(:user) }

    it 'signs in a user' do
      post '/users/sign_in', params: { user: { email: user.email, password: user.password } }
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(root_path)
    end
  end
end
