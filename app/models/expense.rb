class Expense < ApplicationRecord
  belongs_to :user
  belongs_to :group, optional: true
end
