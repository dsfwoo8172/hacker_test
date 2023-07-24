class Comment < ApplicationRecord
  include Scoreable
  has_ancestry

  belongs_to :post
  belongs_to :user
  has_many :votes, as: :voteable
  
  validates :content, presence: true
  validate :check_ancestry_depth

  private

  def check_ancestry_depth
    max_depth = 7
    errors.add(:base, "more than 8 layers") if depth > max_depth
  end

  def self.sorted_by_score_and_ancestry
    all_comments = roots.sort_by { |root_comment| [-root_comment.score] }

    all_comments.each do |root_comment|
      sort_descendants_by_score(root_comment)
    end

    all_comments
  end

  private

  def self.sort_descendants_by_score(comment)
    comment.children.sort_by { |child_comment| [-child_comment.score] }.each do |child_comment|
      sort_descendants_by_score(child_comment)
    end
  end
end