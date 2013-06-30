ActionMailer::Base.smtp_settings = {
    :address              => "smtp.gmail.com",
    :port                 => 587,
    :domain               => "googlemail.com",
    :user_name            => "sandeepkuvs@gmail.com",
    :password             => "Sydney#123",
    :authentication       => "plain",
    :enable_starttls_auto => true
}