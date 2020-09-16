class Consultant < ApplicationRecord
  before_validation :set_registration_num

  enum level: %i[primary secondary]

  validates :cpf,
            :level,
            :phone_number,
            presence: true

  validates :cpf, uniqueness: true

  validates_format_of :cpf, with: %r/\d{3}.\d{3}.\d{3}-\d{2}/

  private

  def set_registration_num
    self.registration_num = Time.now.to_f.to_s
  end
end
