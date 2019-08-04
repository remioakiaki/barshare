FactoryBot.define do
  factory :micropost do
    content { "MyText" }
    pictures { "" }
    likes_count { 1 }
    title { "MyString" }
  end
end
