class UserMailer < Devise::Mailer
  default from: 'Heartbit <no-reply@heartbit.com>'
  default reply_to: 'Heartbit <no-reply@heartbit.com>'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.reset_password_instructions.subject
  #
  def reset_password_instructions(record, token, _opts = {})
    @reset_password_url = edit_password_url(token)
    @email = record.email
    mail(to: @email, subject: 'Reset password instructions', content_type: 'text/html')
  end

  def school_code_instructions(email, code)
    @email = email
    @token = code
    mail(to: @email, subject: 'Teacher School Code', content_type: 'text/html')
  end

  private

  def edit_password_url(token)
    "#{Rails.configuration.x.bo.webapp_url}/recover-password?reset_password_token=#{token}"
  end
end
