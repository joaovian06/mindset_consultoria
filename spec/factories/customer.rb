FactoryBot.define do
  factory :customer do
    cnpj { BRDocuments::CNPJ.generate }
    corporate_name { Faker::Company.name }
    status { 0 }
    agreement { Faker::Lorem.paragraph }
    phone_number { "(019)99973-8339" }

    trait :invalid do
      cnpj { "" }
    end
  end
end
