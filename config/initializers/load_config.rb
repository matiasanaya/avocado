SENDGRID_CONFIG = YAML.load_file("#{Rails.root}/config/sendgrid.yml")
SMTP_CONFIG = YAML.load_file("#{Rails.root}/config/smtp.yml")
APP_DOMAIN = 'matiasanaya.com.ar'