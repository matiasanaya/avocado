class DevelopmentMailInterceptor
  def self.delivering_email(message)
    message.subject = "To: #{message.to}, Subject: #{message.subject}"
    message.to = 'matiasanaya@gmail.com'
  end
end