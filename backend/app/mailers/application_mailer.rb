class ApplicationMailer < ActionMailer::Base
  after_action :set_envelope_from
  
  add_template_helper(SessionsHelper)

  default from: 'noreply@example.com'
  layout 'mailer'

  private

  def set_envelope_from
    mail.smtp_envelope_from = 'DoIT <noreply@example.com>'
  end
end
