class ExpensesController < ApplicationController
  before_action :set_expense, only: %i[show edit update destroy]
  before_action :authenticate_user!

  def index
    user = User.find_by(id: current_user.id)
    @user_expenses = user.expenses.where.not(group_id: nil).order(created_at: :desc)
    @total = @user_expenses.sum(:amount)
  end

  def new
    @expense = Expense.new
  end

  def edit; end

  def create
    @expense = Expense.new(expense_params)
    @expense.user = current_user
      if @expense.save
        if @expense.group_id.nil?
          redirect_to home_external_path, notice: 'External expense was successfully created.'
        else
          redirect_to expenses_path, notice: 'Expense was successfully created.'
        end
      else
        render :new
      end
  end

  def update
      if @expense.update(expense_params)
        if @expense.group_id.nil?
          redirect_to home_external_path, notice: 'External expense was successfully updated.'
        else
          redirect_to expenses_path, notice: 'Expense was successfully updated.'
        end
      else
         render :edit
      end
  end

  def destroy
    @expense.destroy
    redirect_to expenses_url, notice: 'Expense was successfully deleted.'
  end

  private

  def set_expense
    @expense = Expense.find(params[:id])
  end

  def expense_params
    params.require(:expense).permit(:name, :amount, :group_id)
  end
end
