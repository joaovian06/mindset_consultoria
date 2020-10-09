FactoryBot.define do
  factory :treatment do
    type { 1 }
    status { 1 }
    rate { 5 }
    description { "A default description. Please describe the treatment." }
    budget { 0 }
    customer
    consultant

    trait :invalid do
      type { nil }
    end
  end
end
