class ExpiredLoanForBorrowerMailer < ApplicationMailer
  TITLE = 'You should return the item immediately'.freeze

  def notify(email)
    mail(
      to: email,
      subject: TITLE
    )
  end
end
