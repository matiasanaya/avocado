class CardMailer < ActionMailer::Base
  default from: 'me@matiasanaya.com.ar'

  def shared_card(email_share)
    @email_share = email_share
    attachment = File.open("#{email_share.card.display_name}.vcf", 'w') {|f| f.write(email_share.card.vcard) }
    attachments["#{email_share.card.display_name}.vcf"] = File.read("#{email_share.card.display_name}.vcf")
    mail to: @email_share.email, subject: 'Awesome Stuff for you'
  end
end
