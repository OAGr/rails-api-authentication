require 'factory_girl'

FactoryGirl.define do
  factory :room do
    sequence(:name) { |i| "CoolRoom#{i}"}
  end
end
