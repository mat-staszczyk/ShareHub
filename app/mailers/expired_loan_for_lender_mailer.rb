class ExpiredLoanForLenderMailer < ApplicationMailer
  TITLE = 'The borrowing time has been exceeded'.freeze

  def notify(email)
    mail(
      to: email,
      subject: TITLE
    )
  end
end
