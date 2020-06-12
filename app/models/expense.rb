class Expense < ApplicationRecord
  validates :name, presence: true, length: { maximum: 20 }
  validates :amount, presence: true

  belongs_to :user
  belongs_to :group, optional: true
end
