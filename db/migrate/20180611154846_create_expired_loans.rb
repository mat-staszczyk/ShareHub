class CreateExpiredLoans < ActiveRecord::Migration[5.2]
  def change
    create_view :expired_loans, materialized: false
  end
end
