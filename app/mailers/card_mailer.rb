class CardMailer < ActionMailer::Base
  default from: 'me@matiasanaya.com.ar'

  def shared_card(email_share)
    @email_share = email_share
    mail to: @email_share.email, subject: 'Awesome Stuff for you'
  end
end
