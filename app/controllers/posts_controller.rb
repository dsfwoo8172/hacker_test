class PostsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create upvote]
  before_action :set_post, only: %i[show upvote]

  def index
    @posts = Post.user_with_votes_and_comments
                 .page(params[:page])
                 .order(score: :desc)
  end

  def new
    @post = current_user.posts.new
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to posts_path, notice: '新增貼文成功!'
    else
      render :new
    end
  end

  def show
    @post
  end

  def upvote
    if current_user.upvoted?(@post)
      current_user.votes.find_by(voteable: @post).destroy
    else
      @vote = @post.votes.new(user: current_user, upvote: true)
      @vote.save
    end

    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end

  def set_post
    @post = Post.find params[:id]
  end
end