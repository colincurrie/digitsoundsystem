module Content
  include ActiveSupport::Concern

  scope :today, -> { where('created_at > ?', Date.today) }
  scope :this_week, -> { where('created_at > ?', 1.week.ago) }
  scope :this_month, -> { where('created_at > ?', 1.month.ago) }
end