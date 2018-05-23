class TransactionsController < ApplicationController
  def index
    transactions = Transaction.all

    render locals: { transactions: transactions }
  end

  def new
    transaction = LendingForm.new(current_user.id)

    render locals: { transaction: transaction }
  end

  def create
    transaction = LendingForm.new(current_user.id, transaction_params)

    if transaction.save
      redirect_to root_path
    else
      render :new, locals: { transaction: transaction }
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(
      :notes,
      :lender_id,
      :borrower_id,
      :thing_id,
      :borrowed_at,
      :return_planned_at
    )
  end
end
