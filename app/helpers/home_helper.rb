module HomeHelper
  def total_user_expense(user, amount)
    user.expenses.sum(amount)
  end

  def total_friends_expense(expenses, amount)
    expenses.sum(amount)
  end
end
