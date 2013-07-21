class PostageappDeviseMailer < PostageApp::Mailer
  include Devise::Mailers::Helpers

  def confirmation_instructions(record)
    # PostageApp specific elements (example):
    postageapp_template 'my-signup-confirmation'
    postageapp_variables :email => record.email,
                         :link  => confirmation_url(record, :confirmation_token => record.confirmation_token)

    devise_mail(record, :confirmation_instructions)
  end

  def reset_password_instructions(record)
    # PostageApp specific elements (example):
    postageapp_template 'my-password-reset'
    postageapp_variables :name  => record.name ||= record.email,
                         :link  => password_url(record, :reset_password_token => record.reset_password_token)

    devise_mail(record, :reset_password_instructions)
  end

  def unlock_instructions(record)
    # PostageApp specific elements (example):
    postageapp_template 'my-unlock-instructions'
    postageapp_variables :name  => record.name ||= record.email,
                         :link  => unlock_url(record, :unlock_token => record.unlock_token)

    devise_mail(record, :unlock_instructions)
  end
end