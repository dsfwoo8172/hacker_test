require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  let!(:user) { create(:user) }
  let!(:post_params) { 
    {
      post: {
        title: 'My Post',
        content: 'Lorem ipsum dolor sit amet.'
      }
    }
  }

  describe 'PATCH /votes' do
    let!(:post) { create(:post) }
    context 'when user is signed in' do
      before { sign_in user }

      it 'create a new vote for the post' do
        expect { patch "/posts/#{post.id}/upvote" }.to change(Vote, :count).by(1)
        expect(response).to have_http_status(:redirect)
      end
    end
  end

  describe 'POST /posts' do
    context 'when user is signed in' do
      before { sign_in user }

      it 'creates a new post' do
        post '/posts', params: post_params

        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(posts_path)
        expect(Post.count).to eq(1)
        expect(Post.last.title).to eq('My Post')
        expect(Post.last.content).to eq('Lorem ipsum dolor sit amet.')
        expect(Post.last.user).to eq(user)
      end
    end

    context 'when user is not signed in' do
      it 'redirects to the sign-in page' do
        post '/posts', params: post_params

        expect(response).to redirect_to(new_user_session_path)
        expect(Post.count).to eq(0)
      end
    end
  end

  describe 'GET /posts' do
    let!(:post1) { create(:post, title: 'Post 1') }
    let!(:post2) { create(:post, title: 'Post 2') }


    before { sign_in user }
    it 'displays all posts' do
      get '/posts'
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('Post 1')
      expect(response.body).to include('Post 2')
    end
  end

  describe 'GET /posts/:id' do
    let!(:post) { create(:post) }

    it 'displays a specific post' do
      get "/posts/#{post.id}"
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('test')
    end

    it 'displays comments of post' do
      get "/posts/#{post.id}"
      expect(post.comments.size).to eq(1)
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('layers')
    end
  end

  describe '.sorted_by_calculate_score' do
    it 'sorts posts in descending order based on calculated score' do
      post1 = create(:post, score: 10)
      post2 = create(:post, score: 5)
      post3 = create(:post, score: 15)

      sorted_posts = Post.user_with_votes_and_comments.order(score: :desc)

      expect(sorted_posts).to eq([post3, post1, post2])
    end
  end
end
