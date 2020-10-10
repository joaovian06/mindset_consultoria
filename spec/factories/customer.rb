FactoryBot.define do
  factory :customer do
    cnpj { Faker::Company.brazilian_company_number(formatted: true) }
    corporate_name { "Racão ltda." }
    status { 0 }
    agreement { Faker::Lorem.paragraph }
    phone_number { "(019)99973-8339" }

    trait :invalid do
      cnpj
    end
  end
end
