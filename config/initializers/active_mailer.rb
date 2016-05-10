Rails.env.on(:any) do
  # config mailer
  config.action_mailer.default_url_options = { host: ENV['DOMAIN'] }
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    :address =>  ENV['ADDRESS'],
    :port => ENV['PORT'],
    :domain => ENV['DOMAIN'],
    :user_name => ENV['USER_NAME'],
    :password => ENV['PASSWORD'],
    :authentication => 'plain',
    :enable_starttls_auto => false,
    :openssl_verify_mode => 'none'
  }
end
Rails.env.on(:development) do
  # Send email in development mode.
  config.action_mailer.perform_deliveries = true
end
