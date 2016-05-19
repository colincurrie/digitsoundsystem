# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
MAX_COMMENTS = 10
NUM_STORIES = 25
NUM_PHOTOS = 50
NUM_MIXTAPES = 5
NUM_TUNES = 15
NUM_VIDEOS = 7
NUM_EVENTS = 12

SOUNDCLOUD_ID = '70bdb497739d010e71e6f97e12adac20'

LOREM = [
    'Lorem ipsum dolor sit amet',
    'magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo ',
    'magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo ' +
        'consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. ' +
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore',
    'magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo ' +
        'consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. ' +
        'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. '
]

def create_admins
  create_admin 'Colin', 'Currie', 'colin@digitsoundsystem.co.uk'
  create_admin 'Dan', 'Carrier', 'dan@digitsoundsystem.co.uk'
  create_admin 'Matt', 'Gross', 'matt@digitsoundsystem.co.uk'
  create_admin 'Carolyn', 'Boyle', 'carolyn@digitsoundsystem.co.uk'
  @users = User.all
end

def create_admin name, surname, email
  user = User.create(name: name, surname: surname, email: email, password: 'password', admin: true, mailing_list: true)
  if user.errors.count == 0
    puts "Added #{name} (#{email})"
  else
    puts "Failed to add #{name} (#{email}):"
    user.errors.each { |k,v| puts "  #{k} #{v}" }
  end
end

def create_stories
  num_stories = NUM_STORIES
  num_stories.times do |i|
    create_story i, num_stories, @users.shuffle.first
  end
  puts "Added #{Story.count} Stories"
end

def create_story(index, total, user)
  story = Story.create(title: "Story #{index+1} of #{total}: #{LOREM.first}", content: LOREM.last(3).shuffle.first, user: user)
  story_date = Time.now - ((total-index)*60*60*24*7) # one story a week
  story.created_at = story_date
  story.updated_at = story_date
  if story.save
    num_comments = rand(MAX_COMMENTS)
    num_comments.times do |i|
      create_comment i, @users.shuffle.first, story: story
    end
    puts "Created #{story.comments.count} comments for #{story}"
  end
end

def create_comment(index, user, options)
  comment = Comment.create(options.merge(user: user, content: LOREM.shuffle.first))
  target = options[:story] || options[:photo] || options[:mixtape] || options[:tune] || options[:event] || options[:video]
  comment.created_at = target.created_at + (index*60*60) # one comment every hour
  comment.updated_at = comment.created_at
  comment.save
end

def create_photos
  num_photos = NUM_PHOTOS
  num_photos.times do |i|
    create_photo i, num_photos, @users.shuffle.first
  end
  puts "Added #{Photo.count} photos"
end

def create_photo(index, total, user)
  photo = Photo.new(description: "Photo #{index+1} of #{total}: #{LOREM.shuffle.first}", user: user)
  created = Time.now - (total*8*60*60) + rand(index*8*60*60)
  photo.created_at = created
  photo.updated_at = created
  if photo.save
    num_comments = rand(MAX_COMMENTS)
    num_comments.times do |i|
      create_comment i, @users.shuffle.first, photo: photo
    end
    puts "Created #{photo.comments.count} comments for #{photo}"
  end
end

def create_mixtapes
  num_mixtapes = NUM_MIXTAPES
  @urls = fetch_mixcloud_urls num_mixtapes
  num_mixtapes.times do |i|
    create_mixtape i, num_mixtapes, @users.shuffle.first
  end
  puts "Added #{Mixtape.count} mixtapes"
end

def fetch_mixcloud_urls(num_urls)
  [''] * num_urls
end

def create_mixtape(index, total, user)
  target = Mixtape.new(user: user, url: @urls[index%@urls.size])
  created = Time.now - ((total-index)*60*60*24*7*4) # one mixtape every 4 weeks
  target.created_at = created
  target.updated_at = created
  if target.save
    num_comments = rand(MAX_COMMENTS)
    num_comments.times do |i|
      create_comment i, @users.shuffle.first, mixtape: target
    end
    puts "Created #{target.comments.count} comments for #{target}"
  end
end

def create_tunes
  num = NUM_TUNES
  urls = []
  begin
    # scrape youtube
    urls << RestClient::Request.execute(
        url: 'http://www.youtube.com/', :method => :get, :verify_ssl => false).scan(/watch\?v=[^"]+/).map { |id| "http://www.youtube.com/#{id}" }
  rescue
    # fake it
    urls << (num/2).times.map { [*('a'..'z'), *('A'..'Z'), *('0'..'9')].shuffle[0, 11].join }
  end
  begin
    urls << JSON.parse(RestClient.get("https://api.soundcloud.com/tracks.json?client_id=#{SOUNDCLOUD_ID}")).map { |t| t["permalink_url"] }
  rescue
    urls << [''] * num # ?!? how
  end
  urls.shuffle.each_with_index do |url, i|
    user = @users.shuffle.first
    Tune.create(url: url, artist: user.name, title: "Tune #{i+1} of #{urls.size}", user: user)
  end
  puts "Created #{Tune.count} Tunes"
end

def create_videos
  num_videos = NUM_VIDEOS
  urls = fetch_urls(:you_tube)
  num_videos.times do |i|
    user = @users.shuffle.first
    description = LOREM.shuffle.first
    url = urls[i%urls.size] # use urls in sequence
    frequency = 60*60*24*4 # a couple of videos a week
    created = Time.now - (num_videos*frequency)+(i*frequency)
    Video.create(title: "Video #{i+1} of #{num_videos}", description: description, url: url, user: user, score: created, created_at: created)
  end
  puts "Created #{Video.count} Videos"
end

def fetch_urls(source)
  case source
    when :you_tube
      begin
        RestClient::Request.execute(url: 'http://www.youtube.com/', :method => :get, :verify_ssl => false)
                   .scan(/watch\?v=[^"]+/).map { |id| "http://www.youtube.com/#{id}" }.uniq
      rescue
        NUM_VIDEOS.times.map { [*('a'..'z'), *('A'..'Z'), *('0'..'9')].shuffle[0, 11].join }
      end
    else
      throw ArgumentError 'No valid source'
  end.shuffle!
end

def create_events

end

create_admins
create_stories
create_photos
create_mixtapes
create_videos
create_events
