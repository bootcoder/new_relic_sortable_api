FactoryBot.define do
  factory :company do
    name "Tom's Diner"
    factory :company_with_customers do
      transient do
        customer_count 5
      end
      after(:create) do |company, evaluator|
        create_list(:customer, evaluator.customer_count, company: company)
      end
    end
  end
end
