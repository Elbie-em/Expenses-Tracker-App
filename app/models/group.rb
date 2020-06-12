class Group < ApplicationRecord
  validates :name, presence: true, length: { maximum: 20 }
  validates :icon, presence: true

  belongs_to :user
  has_many :expenses
end
