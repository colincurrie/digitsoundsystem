class AdminMailer < ApplicationMailer

  default from: 'digitsoundsystem@gmail.com'

  def new_user(user)
    @user = user
    mail(to: 'digitsoundsystem@gmail.com', subject: 'We got a new user')
  end

  def new_comment(comment)
    @comment = comment
    subject = comment.subject
    if subject.is_a? Photo
      @subject = "#{subject.class} #{subject.id}"
    else
      @subject = "the #{subject.class} '#{subject.title}'"
    end
    @link = url_for(subject)
    mail(to: 'digitsoundsystem@gmail.com', subject: 'Somebody left a comment')
  end
end
