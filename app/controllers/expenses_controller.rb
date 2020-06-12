class ExpensesController < ApplicationController
  before_action :set_expense, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /expenses
  # GET /expenses.json
  def index
    user = User.find_by(id: current_user.id)
    @user_expenses = user.expenses.where.not(group_id: nil)
    @total = @user_expenses.sum(:amount)
  end


  # GET /expenses/new
  def new
    @expense = Expense.new
  end

  # GET /expenses/1/edit
  def edit
  end

  # POST /expenses
  # POST /expenses.json
  def create
    @expense = Expense.new(expense_params)
    @expense.user = current_user

    respond_to do |format|
      if @expense.save
        if @expense.group_id.nil?
          format.html { redirect_to home_external_path, notice: 'External expense was successfully created.' }
        else
          format.html { redirect_to expenses_path, notice: 'Expense was successfully created.' }
        end
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /expenses/1
  # PATCH/PUT /expenses/1.json
  def update
    respond_to do |format|
      if @expense.update(expense_params)
        if @expense.group_id.nil?
          format.html {redirect_to home_external_path, notice: 'External expense was successfully updated.'}
        else
          format.html { redirect_to expenses_path, notice: 'Expense was successfully updated.' }
        end
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /expenses/1
  # DELETE /expenses/1.json
  def destroy
    @expense.destroy
    respond_to do |format|
      format.html { redirect_to expenses_url, notice: 'Expense was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_expense
      @expense = Expense.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def expense_params
      params.require(:expense).permit(:name, :amount, :group_id)
    end
end
