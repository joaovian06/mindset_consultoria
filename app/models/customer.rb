class Customer < ApplicationRecord
  enum status: %i[active disable pending]

  validates :cnpj,
            :status,
            :phone_number,
            presence: true

  validates :cnpj, uniqueness: true

  validates_format_of :cnpj, with: %r/\d{2}.\d{3}.\d{3}\/\d{4}\-\d{2}/

  validates_format_of :phone_number, with: %r/\(\d{3}\)\d{5}\-\d{4}/
end
