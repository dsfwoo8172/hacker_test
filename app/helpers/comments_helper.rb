module CommentsHelper
  def order_children_comments_by_score(nested_comments)
    nested_comments.keys.sort_by { |comment| -comment.score }
  end
end