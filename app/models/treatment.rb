class Treatment < ApplicationRecord
  belongs_to :customer
  belongs_to :consultant

  enum treatment_type: [:organizational, :accounting, :procedure, :project]
  enum status: [:confirmation, :analyze, :in_progress, :pending_budget, :pending_payment]

  validates_length_of :description, minimum: 50, on: :create

  validates_format_of :rate, with: %r/\d{0,5}/

  validates_presence_of :treatment_type,
                        :title,
                        :status,
                        :description
end
