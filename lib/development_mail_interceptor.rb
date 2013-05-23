class DevelopmentMailInterceptor
  def self.delivering_email(message)
    if ENV['MAIL_INTERCEPTOR'] == 'on'
      message.subject = "To: #{message.to}, Subject: #{message.subject}"
      message.to = 'matiasanaya@gmail.com'
    end
  end
end