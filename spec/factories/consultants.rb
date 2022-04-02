FactoryBot.define do
  factory :consultant do
    name { Faker::Name.name_with_middle }
    cpf { BRDocuments::CPF.generate }
    level { 1 }
    registration_num {  }
    phone_number { "(19) 99973-8339" }

    trait :invalid do
      cpf { "" }
    end
  end
end
