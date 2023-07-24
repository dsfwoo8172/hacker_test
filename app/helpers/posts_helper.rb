module PostsHelper
  def split_email(email)
    email.split("@").first.capitalize
  end

  def time_zone(time)
    time.in_time_zone(8).strftime("%F")
  end
end