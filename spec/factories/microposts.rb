FactoryBot.define do
  factory :micropost do
    content { 'Rspec実施中' }
    association :user
  end
end