class LoanExpirationWorker
  include Sidekiq::Worker

  def perform(borrower_email, lender_email)
    ExpiredLoanForBorrowerMailer.notify(borrower_email).deliver
    ExpiredLoanForLenderMailer.notify(lender_email).deliver
  end
end
