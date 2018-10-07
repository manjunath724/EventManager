if Rails.env.development?
  MAIL_CONFIG = YAML.load_file("#{Rails.root}/config/mailer.yml")[Rails.env]

  ActionMailer::Base.smtp_settings = {
    address: "smtp.gmail.com",
    port: 587,
    authentication: "plain",
    enable_starttls_auto: true,
    user_name: MAIL_CONFIG["username"],
    password: MAIL_CONFIG["password"]
  }
end
