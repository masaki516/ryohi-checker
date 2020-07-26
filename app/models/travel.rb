class Travel < ApplicationRecord
  belongs_to :user
  has_many :budget_items, dependent: :destroy
  has_many :paid_items, dependent: :destroy
  mount_uploader :picture, PictureUploader
  validates :name, presence: true, length: { maximum: 20 }
  validate  :picture_size
  
  private
  
  def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
  end
end
