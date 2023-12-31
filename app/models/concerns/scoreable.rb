module Scoreable
  extend ActiveSupport::Concern

  def compute_score!
    time = (Time.now - self.created_at) / 3600.0
    gravity = 1.5
    points = self.votes.size

    score = (points - 1)/(time + 2) ** gravity
    self.update(score: score * 1000)
  end
end