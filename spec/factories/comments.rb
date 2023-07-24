FactoryBot.define do
  factory :comment do
    sequence(:content) { |n| "comment #{n} layers" }
    association :post
    user
  end
end
