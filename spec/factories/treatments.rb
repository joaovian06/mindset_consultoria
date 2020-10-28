FactoryBot.define do
  factory :treatment do
    title { Faker::Company.catch_phrase }
    treatment_type { 1 }
    description { "A default description. Please describe the treatment." }
    customer
    consultant

    trait :invalid do
      treatment_type { nil }
    end
  end
end
