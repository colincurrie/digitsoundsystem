class Event < ActiveRecord::Base

  belongs_to :user
  has_many :comments

  scope :between, lambda {|start_time, end_time| {:conditions => ["? < starts_at and starts_at < ?", Event.sanitize(start_time), Event.sanitize(end_time)] }}

  def as_json(options = {})
    {
        id: self.id,
        title: self.title,
        user_name: self.user.name,
        start: start_at.rfc822,
        end: end_at.rfc822,
        allDay: false,
        url: Rails.application.routes.url_helpers.event_path(self.id),
        venue: self.venue,
        description: self.description
    }
  end

  def self.next
    order(:start_at).where(['end_at>?', Time.now]).first
  end
end
