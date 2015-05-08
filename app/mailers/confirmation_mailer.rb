class ConfirmationMailer < ActionMailer::Base
  default from: "andre-hohmann@gmx.de"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.confirmation_mailer.confirmation.subject
  #
  def confirmation
    @greeting = "Hi"

    mail to: "ahohman@imn.htwk-leipzig.de",
    from: "andre-hohmann@gmx.de",
    subject: "Test"
  end
end
