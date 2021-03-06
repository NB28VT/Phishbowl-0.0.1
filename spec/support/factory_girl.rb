require 'factory_girl'

FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "user#{n}@example.com" }
    username 'John'
    password 'password'
    password_confirmation 'password'
  end

end
