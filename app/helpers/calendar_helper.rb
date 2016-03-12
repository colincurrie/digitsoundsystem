module CalendarHelper

  def format_datetime(start_at, end_at=nil)
    unless end_at
      start_at.strftime('On %A %B %d at %H:%M')
    else
      start_date = start_at.strftime('%A %B %d')
      if start_at.beginning_of_day == end_at.beginning_of_day
        "#{start_date} From #{start_at.strftime('%H:%M')} to #{end_at.strftime('%H:%M')}"
      else
        "From #{start_date} at #{start_at.strftime('%H:%M')} to #{end_at.strftime('%A %B %d at %H:%M')}"
      end
    end
  end
end
