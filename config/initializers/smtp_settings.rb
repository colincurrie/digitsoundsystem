ActionMailer::Base.smtp_settings = {
    :enable_starttls_auto => true,
    :address => 'smtp.gmail.com',
    :port => 587,
    :domain => 'digitsoundsystem.co.uk',
    :authentication => :plain,
    :user_name => 'digitsoundsystem@gmail.com',
    :password => ENV['SMTP_PASSWORD'],
    :openssl_verify_mode => 'none'
}
