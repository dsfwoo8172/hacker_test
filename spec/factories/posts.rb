FactoryBot.define do
  factory :post do
    title { 'test' }
    content { 'test content' }
    user

    after(:create) do |post|
      create_list(:comment, 1, post: post)
    end
  end
end