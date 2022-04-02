class Customer < ApplicationRecord
  has_many :treatments, inverse_of: :customer, dependent: :destroy
  accepts_nested_attributes_for :treatments, allow_destroy: true

  enum status: %i[active disable pending]

  validates :cnpj,
            :phone_number,
            :corporate_name,
            presence: true

  validates :cnpj, uniqueness: true

  validates_format_of :cnpj, with: %r/\d{2}.\d{3}.\d{3}\/\d{4}\-\d{2}/

  validates_format_of :phone_number, with: %r/\(\d{3}\)\d{5}\-\d{4}/
end
