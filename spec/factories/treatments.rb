FactoryBot.define do
  factory :treatment do
    treatment_type { 1 }
    status { 1 }
    rate { 5 }
    description { "A default description. Please describe the treatment." }
    budget { 0 }
    customer
    consultant

    trait :invalid do
      treatment_type { nil }
    end
  end
end
