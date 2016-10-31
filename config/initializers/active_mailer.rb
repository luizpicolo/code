################################################################################
# The MIT License (MIT)
#
# Copyright (c) 2016 C.O.D.E
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
################################################################################

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
