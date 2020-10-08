class Treatment < ApplicationRecord
  belongs_to :customer
  belongs_to :consultant
end
