class PaidItem < ApplicationRecord
  
  belongs_to :travel
  
  validates :name, presence: true, length: { maximum: 20 }
  validates :cost, presence: true, length: { maximum: 20 }, numericality: { only_integer: true }
  
end
