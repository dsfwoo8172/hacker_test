class Post < ApplicationRecord
  include Scoreable
  self.per_page = 10
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :votes, as: :voteable

  scope :user_with_votes_and_comments, -> { includes(:user, :votes, :comments) }

  validates :title, :content, presence: true
end
