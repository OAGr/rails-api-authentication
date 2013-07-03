# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:name) {|i| "User#{i}"}
    sequence(:email) {|i| "Email#{i}"}
    password 'changeme'
    password_confirmation 'changeme'
  end
end
