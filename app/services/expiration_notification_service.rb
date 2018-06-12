class ExpirationNotificationService
  def initialize
    @expirations = ExpiredLoan.all
  end

  def call
    send_mailing
  end

  private

  def send_mailing
    @expirations.each do |loan|
      LoanExpirationWorker.perform_async(loan.borrower_email, loan.lender_email)
    end
  end
end
