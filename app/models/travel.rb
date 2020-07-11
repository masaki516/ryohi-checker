class Travel < ApplicationRecord
  belongs_to :user
  has_many :budget_items, dependent: :destroy
  has_many :paid_items, dependent: :destroy
  
  validates :name, presence: true, length: { maximum: 20 }
end
