# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def create_target_types
  TargetType.create name: 'story'
  TargetType.create name: 'photo'
  TargetType.create name: 'tune'
  TargetType.create name: 'mixtape'
  TargetType.create name: 'video'
end

def create_admins
  create_admin 'Colin', 'Currie', 'colin@digitsoundsystem.co.uk'
  create_admin 'Dan', 'Carrier', 'dan@digitsoundsystem.co.uk'
  create_admin 'Matt', 'Gross', 'matt@digitsoundsystem.co.uk'
  create_admin 'Carolyn', 'Boyle', 'carolyn@digitsoundsystem.co.uk'
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
MAX_COMMENTS = 10
MAX_STORIES = 100
MAX_TUNES = 50
MAX_VIDEOS = 50
USERS = User.all

def create_stories
  num_stories = rand(MAX_STORIES)
  @users = User.all
  num_stories.times do |i|
    create_story i, num_stories, USERS[i%USERS.count]
  end
  puts "Added #{Story.count} Stories"
end

def create_story(index, total, user)
  story = Story.create(title: "Story #{index+1} of #{total}: #{LOREM.first}", content: LOREM.last(3).shuffle.first, user: user)
  story_date = Time.now - (total*8*60*60) + rand(index*8*60*60)
  story.created_at = story_date
  story.updated_at = story_date
  if story.save
    num_comments = rand(MAX_COMMENTS)
    num_comments.times do |i|
      create_comment i, USERS[i%USERS.count], story
    end
    puts "Created #{story.comments.count} comments for #{story}"
  end
end

def create_comment(index, user, story)
  comment = Comment.create(user: user, story: story, content: LOREM[index%LOREM.length])
  comment.created_at = story.created_at + (index*66*60)
  comment.updated_at = comment.created_at
  comment.save
end

def create_tunes
  max_tunes = rand(MAX_TUNES)
  begin
    # scrape youtube
    youtube_tracks = RestClient::Request.execute(
        url: 'http://www.youtube.com/', :method => :get, :verify_ssl => false).scan(/watch\?v=[^"]+/).map { |id| "http://www.youtube.com/#{id}" }
    soundcloud_tracks = JSON.parse(RestClient.get("https://api.soundcloud.com/tracks.json?client_id=#{SOUNDCLOUD_ID}")).map{|t| t["permalink_url"]}
  rescue
    # fake it
    youtube_tracks = (max_tunes/2).times.map { [*('a'..'z'), *('A'..'Z'), *('0'..'9')].shuffle[0, 11].join }
  end
  youtube_tracks.each_with_index do |youtube,i|
    user = USERS[i % USERS.length]
    Tune.create( url: youtube, artist: user.name, title: "YouTube #{i+1} of #{youtube_tracks.length}", user: user )
  end
  puts "Created #{youtube_tracks.length} YouTube Tunes"
end

def create_videos
  max_videos = rand(MAX_VIDEOS)
  begin
    # scrape youtube
    urls = RestClient::Request.execute(url: 'http://www.youtube.com/', :method => :get, :verify_ssl => false)
               .scan(/watch\?v=[^"]+/).map { |id| "http://www.youtube.com/#{id}" }
  rescue
    # fake it
    urls = (max_videos/2).times.map { [*('a'..'z'), *('A'..'Z'), *('0'..'9')].shuffle[0, 11].join }
  end
  urls.each_with_index do |url, i|
    user = USERS[i % USERS.length]
    description = LOREM[i%LOREM.length]
    Video.create(title: "Video #{i+1} of #{urls.length}", description: description, url: url, user: user)
  end
  puts "Created #{urls.length} Videos"
end

create_target_types
create_admins
create_stories
create_tunes
create_videos
