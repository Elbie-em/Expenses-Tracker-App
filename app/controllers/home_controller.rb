class HomeController < ApplicationController
  before_action :authenticate_user!, only: [:main, :external]

  def index
    redirect_to home_main_path if current_user
  end

  def main
  end

  def external
    user = User.find_by(id: current_user.id)
    @external_user_expenses = user.expenses.where(group_id: nil)
    @external_total =  @external_user_expenses.sum(:amount)
  end

  def friends
    
  end
  
end
