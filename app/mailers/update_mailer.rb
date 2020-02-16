class UpdateMailer < ApplicationMailer

  default from: 'digitsoundsystem@gmail.com'

  def weekly_updates
    User.signed_up.each do |user|
      if ENV.fetch('EMAIL_UPDATES', 'disabled') == 'enabled' || user.email =~ /ENV.fetch('EMAIL_UPDATE_FILTER','.*')/
        @stories = Story.this_week
        @tunes = Tune.this_week
        @photos = Photo.this_week
        @mix_tapes = Mixtape.this_week
        @comments = Comment.this_week
        @videos = Video.this_week
      end
    end
  end
end
