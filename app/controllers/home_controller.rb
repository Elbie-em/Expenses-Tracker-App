class HomeController < ApplicationController
  before_action :authenticate_user!, only: [:main, :external]

  def index
    redirect_to home_main_path if current_user
  end

  def main
  end

  def external
    user = User.find_by(id: current_user.id)
    @external_user_expenses = user.expenses.where(group_id: nil).order(created_at: :desc)
    @external_total =  @external_user_expenses.sum(:amount)
  end

  def friends
    @users = User.where.not(id: current_user.id)
    @expenses = Expense.where.not(user_id: current_user.id)
  end
  
end
