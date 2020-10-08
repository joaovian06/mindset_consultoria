FactoryBot.define do
  factory :treatment do
    type { 1 }
    status { 1 }
    rate { 1 }
    description { "MyString" }
    budget { 1 }
    customer { nil }
    consultant { nil }
  end
end
