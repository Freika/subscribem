FactoryGirl.define do
  factory :account, :class => Subscribem::Account do
    sequence(:name) { |n| "Test Account ##{n}" }
    sequence(:subdomain) { |n| "test#{n}" }
    association :owner, factory: :user
  end
end
