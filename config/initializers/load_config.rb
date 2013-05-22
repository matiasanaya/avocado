ENV['APP_DOMAIN'] = 'matiasanaya.com.ar'

if Rails.env.development?
  configs = []
  SENDGRID_CONFIG = YAML.load_file("#{Rails.root}/config/sendgrid.yml")
  configs << { name: 'SENDGRID', obj: SENDGRID_CONFIG }
  SMTP_CONFIG = YAML.load_file("#{Rails.root}/config/smtp.yml")
  configs << { name: 'SMTP_CONFIG', obj: SMTP_CONFIG }

  configs.each do |config|
    config[:obj].each do |k, v|
      ENV["#{config[:name]}_#{k.to_s}"] ||= v.to_s
    end
  end
end