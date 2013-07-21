ActionMailer::Base.smtp_settings = {
    :address              => "smtp.postageapp.com",
    :port                 => 587,
    :domain               => "postageapp.com",
    :user_name            => "no-return@postageapp.com",
    :password             => "Sydney#123",
    :authentication       => "plain",
    :enable_starttls_auto => true
}