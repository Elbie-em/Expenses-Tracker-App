class Expense < ApplicationRecord
  validates :name, presence: true, length: { maximum: 20 }
  validates :amount, presence: true, numericality: { less_than_or_equal_to: 100000, greater_than: 1}

  belongs_to :user
  belongs_to :group, optional: true
end
