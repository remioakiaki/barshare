# frozen_string_literal: true

FactoryBot.define do
  factory :micropost do
    content { 'Rspec実施中' }
    association :user
  end
end
