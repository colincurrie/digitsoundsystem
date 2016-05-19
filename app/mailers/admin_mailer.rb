class AdminMailer < ApplicationMailer

  default from: 'admininfo@digitsoundsystem.co.uk'

  def new_user(user)
    @user = user
    mail(to: 'digitsoundsystem@gmail.com', subject: 'We got a new user')
  end
end
