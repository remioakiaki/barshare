FactoryBot.define do
  factory :like do
    micropost
    user { micropost.user }
  end
end
