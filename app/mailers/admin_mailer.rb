class AdminMailer < ApplicationMailer

  default from: 'digitsoundsystem@gmail.com'

  def new_user(user)
    @user = user
    mail(to: 'digitsoundsystem@gmail.com', subject: 'We got a new user') unless Rails.env == 'development'
  end

  def new_comment(comment)
    @comment = comment
    subject = comment.subject
    if subject.is_a? Photo
      @subject = "#{subject.class} #{subject.id}"
    elsif subject.respond_to? :title
      @subject = "the #{subject.class} '#{subject.title}'"
    end
    @link = url_for(subject)
    mail(to: 'digitsoundsystem@gmail.com', subject: 'Somebody left a comment') unless Rails.env == 'development'
  end
end
