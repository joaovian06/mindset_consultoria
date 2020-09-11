FactoryBot.define do
  factory :customer do
    cnpj { BRDocuments::CNPJ.generate }
    status { 1 }
    agreement { "MyString" }
    phone_number { "(019)99973-8339" }
    trait :invalid do
      cnpj { "" }
    end
  end
end
