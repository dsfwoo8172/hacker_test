class CommentsController < ApplicationController
  before_action :set_post, only: %i[create]
  
  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user
    
    if @comment.save
      redirect_to @post, notice: 'successfully!'
    else
      redirect_to @post, alert: @comment.errors.full_messages.join(', ')
    end
  end

  def upvote
    @comment = Comment.find(params[:id])
    if current_user.upvoted?(@comment)
      current_user.votes.find_by(voteable: @comment).destroy
    else
      @vote = @comment.votes.new(user: current_user, upvote: true)
      @vote.save
    end

    redirect_to(request.referer || root_path)
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :parent_id)
  end

  def set_post
    @post = Post.find(params[:post_id])
  end
end